import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/business_logic/cubit/expense_repeat/expense_repeat_cubit.dart';
import 'package:temp/business_logic/repository/expense_repeat/expense_repeat_repo.dart';
import 'package:temp/data/repository/expenses_repeat/expenses_repeat_impl.dart';
import 'package:temp/data/models/expenses/expense_model.dart';
import 'package:temp/data/models/income/income_model.dart';
import 'package:temp/presentation/router/app_router_names.dart';
import 'package:temp/presentation/styles/themes.dart';
import 'package:temp/presentation/widgets/status_bar_configuration.dart';
import 'business_logic/cubit/bloc_observer.dart';
import 'business_logic/cubit/global_cubit/global_cubit.dart';
import 'business_logic/cubit/home_cubit/home_cubit.dart';
import 'data/local/cache_helper.dart';
import 'data/local/hive/app_boxes.dart';
import 'data/local/hive/hive_database.dart';
import 'presentation/router/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await translator.init(
    localeType: LocalizationDefaultType.device,
    languagesList: <String>['ar', 'en'],
    assetsDirectory: 'assets/i18n/',
  );

  await Hive.initFlutter();

  Hive.registerAdapter(ExpenseModelAdapter());
  Hive.registerAdapter(IncomeModelAdapter());
  await HiveHelper().openBox(boxName: AppBoxes.expenseModel);
  await HiveHelper().openBox(boxName: AppBoxes.expenseRepeatTypes);
  await HiveHelper().openBox(boxName: AppBoxes.incomeModel);

  BlocOverrides.runZoned(
    () async {
      await CacheHelper.init();
      await EasyLocalization.ensureInitialized();

      /*  Widget startPoint;
      if (CacheHelper.getDataFromSharedPreference(key: 'onBoardDone') == true ||
          CacheHelper.getDataFromSharedPreference(key: 'onBoardDone') != null) {
        startPoint =MyApp(appRouter: AppRouter());
      } else {
        startPoint = const OnBoardScreens();
      }*/

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

  final ExpenseRepeatRepo _expenseRepeatRepo = ExpensesRepeatImpl();
  
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: ((context) => GlobalCubit())),
        BlocProvider(create: ((context) => HomeCubit())),
        BlocProvider(create: ((context) => ExpenseRepeatCubit(_expenseRepeatRepo))),
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
                  //   home: ExpensesStatisticsScreen()// Locals list
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
