import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:temp/business_logic/cubit/add_subcategory/add_subcategory_cubit.dart';
import 'package:temp/business_logic/cubit/confirm_payments/confirm_payment_cubit.dart';
import 'package:temp/business_logic/cubit/expense_repeat/expense_repeat_cubit.dart';
import 'package:temp/business_logic/cubit/goals_cubit/goals_cubit.dart';
import 'package:temp/business_logic/cubit/income_repeat/income_repeat_cubit.dart';
import 'package:temp/business_logic/cubit/statistics_cubit/statistics_cubit.dart';
import 'package:temp/business_logic/repository/general_stats_repo/general_stats_repo.dart';
import 'package:temp/data/repository/general_stats_repo_impl/general_stats_repo_impl.dart';
import 'package:temp/data/repository/income_repo_impl/income_repo_impl.dart';
import 'package:temp/notification_manager.dart';
import 'package:temp/notifications_api.dart';
import 'package:temp/presentation/router/app_router_names.dart';
import 'package:temp/presentation/screens/shared/empty_screen.dart';
import 'package:temp/presentation/screens/shared/error_sreen.dart';
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
import 'data/local/cache_helper.dart';
import 'data/local/hive/hive_initialize.dart';
import 'data/repository/expenses_repo_impl/expenses_repo_impl.dart';
import 'presentation/router/app_router.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await HiveInitialize.init();
  tz.initializeTimeZones();

   await translator.init(
      localeType: LocalizationDefaultType.device,
      languagesList: <String>['ar', 'en'],
      assetsDirectory: 'assets/i18n/');
   await NotificationManager().init();
   // await NotificationsManagerHandler().saveInitialNotification();
  BlocOverrides.runZoned(
    () async {
      await CacheHelper.init();
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
        BlocProvider(
            create: ((context) =>
                HomeCubit(_generalStatsRepository)..getTheGeneralStatsModel())),
        BlocProvider(
            create: ((context) => AddExpOrIncCubit(
                _expensesRepository, _incomeRepository, _generalStatsRepository))),
        BlocProvider(create: ((context) => ExpenseRepeatCubit(_expensesRepository))),
        BlocProvider(
            create: ((context) => AddExpOrIncCubit(
                _expensesRepository, _incomeRepository, _generalStatsRepository))),
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
          return FlutterSizer(
            builder: (context, orientation, deviceType) {
              return LayoutBuilder(
                builder: (context, constraints) {
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
                   // home: const EmptyScreen(), // Locals list
                    initialRoute: AppRouterNames.rSplashScreen,
                    onGenerateRoute: widget.appRouter.onGenerateRoute,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
