import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/presentation/screens/home/control_screen.dart';
import 'package:temp/presentation/screens/home/expenses_screen.dart';
import 'business_logic/bloc_observer.dart';
import 'business_logic/global_cubit/global_cubit.dart';
import 'data/local/cache_helper.dart';
import 'presentation/router/app_router.dart';
import 'presentation/styles/themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await translator.init(
    localeType: LocalizationDefaultType.device,
    languagesList: <String>['ar', 'en'],
    assetsDirectory: 'assets/i18n/',
  );

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

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: ((context) => GlobalCubit())),
      ],
      child: BlocConsumer<GlobalCubit, GlobalState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Sizer(
            builder: (context, orientation, deviceType) {
              return LayoutBuilder(builder: (context, constraints) {
                statusBarConfig();
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: AppTheme.lightThemeMode,
                  localizationsDelegates: translator.delegates,
                  // Android + iOS Delegates
                  locale: translator.activeLocale,
                  // Active locale
                  supportedLocales: translator.locals(),
                  //home: ExpensesScreen()// Locals list
                  home: ControlScreen(),
                );
              });
            },
          );
        },
      ),
    );
  }

  void statusBarConfig() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark),
    );
  }
}
