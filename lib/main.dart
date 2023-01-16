import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/business_logic/cubit/add_subcategory/add_subcategory_cubit.dart';
import 'package:temp/business_logic/cubit/expense_repeat/expense_repeat_cubit.dart';
import 'package:temp/business_logic/cubit/income_repeat/income_repeat_cubit.dart';
import 'package:temp/business_logic/repository/income_repo/income_repo.dart';
import 'package:temp/data/models/subcategories_models/expense_subcaegory_model.dart';
import 'package:temp/data/models/subcategories_models/income_subcaegory_model.dart';
import 'package:temp/data/repository/income_repo_impl/income_repo_impl.dart';
import 'package:temp/notificationsApi.dart';
import 'package:temp/presentation/router/app_router_names.dart';
import 'package:temp/presentation/screens/welcome/splash_screen.dart';
import 'package:temp/presentation/styles/themes.dart';
import 'package:temp/presentation/widgets/status_bar_configuration.dart';
import 'business_logic/cubit/add_exp_inc/add_exp_or_inc_cubit.dart';
import 'business_logic/cubit/bloc_observer.dart';
import 'business_logic/cubit/global_cubit/global_cubit.dart';
import 'business_logic/cubit/home_cubit/home_cubit.dart';
import 'business_logic/repository/expenses_repo/expenses_repo.dart';
import 'data/local/cache_helper.dart';
import 'data/local/hive/app_boxes.dart';
import 'data/local/hive/hive_database.dart';
import 'data/models/transactions/transaction_details_model.dart';
import 'data/models/transactions/transaction_model.dart';
import 'data/models/transactions/transaction_types_model.dart';
import 'data/repository/expenses_repo_impl/expenses_repo_impl.dart';
import 'presentation/router/app_router.dart';
import 'package:timezone/data/latest.dart' as tz;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();

  await translator.init(
    localeType: LocalizationDefaultType.device,
    languagesList: <String>['ar', 'en'],
    assetsDirectory: 'assets/i18n/',
  );

  await Hive.initFlutter();

  Hive.registerAdapter(TransactionModelAdapter());
  Hive.registerAdapter(TransactionRepeatTypesAdapter());
  Hive.registerAdapter(TransactionRepeatDetailsModelAdapter());
  Hive.registerAdapter(SubCategoryExpenseAdapter());
  Hive.registerAdapter(SubCategoryIncomeAdapter());

  await HiveHelper().openBox<TransactionRepeatDetailsModel>(
      boxName: AppBoxes.dailyTransactionsBoxName);
  await HiveHelper().openBox<TransactionRepeatDetailsModel>(
      boxName: AppBoxes.weeklyTransactionsBoxName);
  await HiveHelper().openBox<TransactionRepeatDetailsModel>(
      boxName: AppBoxes.monthlyTransactionsBoxName);
  await HiveHelper().openBox<TransactionRepeatDetailsModel>(
      boxName: AppBoxes.noRepeaTransactionsBoxName);
  await HiveHelper()
      .openBox<SubCategoryExpense>(boxName: AppBoxes.subCategoryExpense);
  await HiveHelper()
      .openBox<SubCategoryIncome>(boxName: AppBoxes.subCategoryIncome);
  await HiveHelper()
      .openBox<TransactionModel>(boxName: AppBoxes.transactionBox);

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
  final TransactionsRepository _expensesRepository = ExpensesRepositoryImpl();
  final IncomeRepository _incomeRepository = IncomeRepositoryImpl();

  @override
  void initState() {
    _onClickNotify();
    super.initState();
  }

  StreamSubscription _onClickNotify() => NotificationsApi.rxDart.stream.listen(
      (event) => Navigator.pushReplacementNamed(
          context, AppRouterNames.rNotification));

  @override
  void dispose() {
    _onClickNotify().cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: ((context) => GlobalCubit())),
        BlocProvider(create: ((context) => HomeCubit())),
        BlocProvider(
            create: ((context) =>
                AddExpOrIncCubit(_expensesRepository, _incomeRepository))),
        BlocProvider(
            create: ((context) => ExpenseRepeatCubit(_expensesRepository))),
        BlocProvider(
            create: ((context) => IncomeRepeatCubit(_incomeRepository))),
        BlocProvider(create: ((context) => AddSubcategoryCubit())),
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
                  theme: AppTheme.lightThemeMode,
                  debugShowCheckedModeBanner: false,
                  localizationsDelegates: translator.delegates,
                  // Android + iOS Delegates
                  locale: translator.activeLocale,
                  // Active locale
                  supportedLocales: translator.locals(),
                  //    home: SplashScreen()// Locals list
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
