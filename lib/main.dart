import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/presentation/screens/home/control_screen.dart';

import 'business_logic/bloc_observer.dart';
import 'business_logic/global_cubit/global_cubit.dart';
import 'business_logic/home_cubit/home_cubit.dart';
import 'constants/language_manager.dart';
import 'data/local/cache_helper.dart';
import 'presentation/router/app_router.dart';
import 'presentation/router/app_router_names.dart';
import 'presentation/styles/themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await translator.init(
    localeType: LocalizationDefaultType.asDefined,
    languagesList: <String>['en','ar'],
    assetsDirectory: 'assets/i18n/',
  );
  // BlocOverrides.runZoned(
  //   () async {
  //     await CacheHelper.init();
  //
  //     Widget startPoint;
  //     if (CacheHelper.getDataFromSharedPreference(key: 'onBoardDone') == true ||
  //         CacheHelper.getDataFromSharedPreference(key: 'onBoardDone') != null) {
  //       startPoint = MyApp(appRouter: AppRouter());
  //     } else {
  //       startPoint = const OnBoardScreens();
  //     }
  //     runApp(startPoint);
  //   },
  //   blocObserver: MyBlocObserver(),
  // );
  runApp(MyApp(appRouter: AppRouter()));
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
        BlocProvider(create: ((context) => HomeCubit())),

      ],
      child: BlocConsumer<GlobalCubit, GlobalState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Sizer(
            builder: (context, orientation, deviceType) {
              return LayoutBuilder(builder: (context, constraints) {
                statusBarConfig();

                return MaterialApp(
                  theme: AppTheme.lightThemeMode,
                  debugShowCheckedModeBanner: false,
                //  onGenerateRoute: widget.appRouter.onGenerateRoute,
                  home: ControlScreen(),
                  localizationsDelegates: translator.delegates,
                  // Android + iOS Delegates
                  locale: translator.activeLocale,
                  // Active locale
                  supportedLocales: translator.locals(), // Locals list
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
