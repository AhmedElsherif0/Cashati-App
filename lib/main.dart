import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/business_logic/cubit/add_subcategory/add_subcategory_cubit.dart';
import 'package:temp/business_logic/cubit/confirm_payments/confirm_payment_cubit.dart';
import 'package:temp/business_logic/cubit/expense_repeat/expense_repeat_cubit.dart';
import 'package:temp/business_logic/cubit/goals_cubit/goals_cubit.dart';
import 'package:temp/business_logic/cubit/income_repeat/income_repeat_cubit.dart';
import 'package:temp/business_logic/cubit/statistics_cubit/statistics_cubit.dart';
import 'package:temp/business_logic/repository/general_stats_repo/general_stats_repo.dart';
import 'package:temp/data/models/goals/goal_model.dart';
import 'package:temp/data/models/goals/repeated_goal_model.dart';
import 'package:temp/data/models/notification/notification_model.dart';
import 'package:temp/data/models/statistics/general_stats_model.dart';
import 'package:temp/data/models/subcategories_models/expense_subcaegory_model.dart';
import 'package:temp/data/repository/general_stats_repo_impl/general_stats_repo_impl.dart';
import 'package:temp/data/repository/income_repo_impl/income_repo_impl.dart';
import 'package:temp/notifications_api.dart';
import 'package:temp/presentation/router/app_router_names.dart';
import 'package:temp/presentation/screens/add_transactions/add_expenses_screen.dart';
import 'package:temp/presentation/screens/home/statistics_details_screen.dart';
import 'package:temp/presentation/screens/shared/loading_screen.dart';
import 'package:temp/presentation/screens/welcome/on_boarding_screens.dart';
import 'package:temp/presentation/screens/welcome/welcome_screen.dart';
import 'package:temp/presentation/styles/themes.dart';
import 'package:temp/presentation/widgets/status_bar_configuration.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'business_logic/cubit/add_exp_inc/add_exp_or_inc_cubit.dart';
import 'business_logic/cubit/bloc_observer.dart';
import 'business_logic/cubit/global_cubit/global_cubit.dart';
import 'business_logic/cubit/home_cubit/home_cubit.dart';
import 'business_logic/repository/transactions_repo/transaction_repo.dart';
import 'constants/app_strings.dart';
import 'data/local/cache_helper.dart';
import 'data/local/hive/app_boxes.dart';
import 'data/local/hive/hive_database.dart';
import 'data/models/transactions/transaction_details_model.dart';
import 'data/models/transactions/transaction_model.dart';
import 'data/models/transactions/transaction_types_model.dart';
import 'data/repository/expenses_repo_impl/expenses_repo_impl.dart';
import 'presentation/router/app_router.dart';
import 'package:timezone/timezone.dart' as tz;

import 'presentation/screens/home/part_time_details.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();

  await translator.init(
    localeType: LocalizationDefaultType.device,
    languagesList: <String>['ar', 'en'],
    assetsDirectory: 'assets/i18n/',
  );

  await Hive.initFlutter();
  Hive.registerAdapter(GeneralStatsModelAdapter());
  Hive.registerAdapter(TransactionModelAdapter());
  Hive.registerAdapter(TransactionRepeatTypesAdapter());
  Hive.registerAdapter(TransactionRepeatDetailsModelAdapter());
  Hive.registerAdapter(SubCategoryAdapter());
  Hive.registerAdapter(GoalModelAdapter());
  Hive.registerAdapter(GoalRepeatedDetailsModelAdapter());
  Hive.registerAdapter(NotificationModelAdapter());


  await Hive.openBox<GeneralStatsModel>(AppBoxes.generalStatisticsBox);

  await HiveHelper()
      .openBox<TransactionRepeatDetailsModel>(boxName: AppBoxes.dailyTransactionsBoxName);
  await HiveHelper()
      .openBox<TransactionRepeatDetailsModel>(boxName: AppBoxes.weeklyTransactionsBoxName);
  await HiveHelper()
      .openBox<TransactionRepeatDetailsModel>(boxName: AppBoxes.monthlyTransactionsBoxName);
  await HiveHelper()
      .openBox<TransactionRepeatDetailsModel>(boxName: AppBoxes.noRepeaTransactionsBoxName);
  await HiveHelper().openBox<SubCategory>(boxName: AppBoxes.subCategoryExpense);
  await HiveHelper().openBox<TransactionModel>(boxName: AppBoxes.transactionBox);
  await HiveHelper().openBox<GoalModel>(boxName: AppBoxes.goalModel);
  await HiveHelper().openBox<GoalRepeatedDetailsModel>(boxName: AppBoxes.goalRepeatedBox);

  BlocOverrides.runZoned(
    () async {
      await CacheHelper.init();
      await EasyLocalization.ensureInitialized();
      await NotificationsApi.initialize();
      runApp(MyApp(appRouter: AppRouter()));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({required this.appRouter, Key? key}) : super(key: key);
  final AppRouter appRouter;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with ConfigurationStatusBar {
  final TransactionRepo _expensesRepository = ExpensesRepositoryImpl();
  final TransactionRepo _incomeRepository = IncomeRepositoryImpl();
  final GeneralStatsRepo _generalStatsRepository = GeneralStatsRepoImpl();


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: ((context) => GlobalCubit())),

        BlocProvider(create: ((context) => HomeCubit(_generalStatsRepository)..getTheGeneralStatsModel())),
        BlocProvider(
            create: ((context) =>
                AddExpOrIncCubit(_expensesRepository, _incomeRepository,_generalStatsRepository))),
        BlocProvider(
            create: ((context) => ExpenseRepeatCubit(_expensesRepository))),
        BlocProvider(
            create: ((context) =>
                AddExpOrIncCubit(_expensesRepository, _incomeRepository,_generalStatsRepository))),
        BlocProvider(create: ((context) => ExpenseRepeatCubit(_expensesRepository))),
        BlocProvider(create: ((context) => IncomeRepeatCubit(_incomeRepository))),
        BlocProvider(create: ((context) => AddSubcategoryCubit())),
        BlocProvider(create: ((context) => GoalsCubit())),
        BlocProvider(create: ((context) => ConfirmPaymentCubit())),
        BlocProvider(create: ((context) => StatisticsCubit(_expensesRepository))),
      ],
      child: BlocConsumer<GlobalCubit, GlobalState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Sizer(
            builder: (context, orientation, deviceType) {
              return LayoutBuilder(builder: (context, constraints) {
                print(constraints.maxWidth);
                statusBarConfig();
                return MaterialApp(
                  title: 'Cashati',
                  theme: AppTheme.lightThemeMode,
                  debugShowCheckedModeBanner: false,
                  localizationsDelegates: translator.delegates,

                  // Android + iOS Delegates
                  locale: translator.activeLocale,
                  // Active locale
                  supportedLocales: translator.locals(),
                 // home: const WelcomeScreen(), // Locals list
                    initialRoute: AppRouterNames.rSplashScreen,
                  onGenerateRoute: widget.appRouter.onGenerateRoute,
                );
              });
            },
          );
        },
      ),
    );
  }
}
