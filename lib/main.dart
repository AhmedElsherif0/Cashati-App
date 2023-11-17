import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:temp/notification_manager.dart';
import 'package:temp/notifications_api.dart';
import 'package:temp/presentation/router/app_router_names.dart';
import 'package:temp/presentation/styles/themes.dart';
import 'package:temp/presentation/utils/app_bloc.dart';
import 'package:temp/presentation/widgets/status_bar_configuration.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'business_logic/cubit/bloc_observer.dart';
import 'business_logic/cubit/global_cubit/global_cubit.dart';
import 'data/local/cache_helper.dart';
import 'data/local/hive/hive_initialize.dart';
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
  @override
  Widget build(BuildContext context) {
    return AppBlocs(
      child: BlocBuilder<GlobalCubit, GlobalState>(
        builder: (context, state) => FlutterSizer(
          builder: (_, orientation, deviceType) {
            return LayoutBuilder(
              builder: (context, constraints) {
                print(constraints.maxWidth);
                setOrientationPortraitUP();
                statusBarConfig();
                return MaterialApp(
                  title: 'Cashati',
                  theme: AppTheme.lightThemeMode,
                  debugShowCheckedModeBanner: false,
                  localizationsDelegates: translator.delegates,
                  locale: translator.activeLocale,
                  supportedLocales: translator.locals(),
                  // home: const WelcomeScreen(), // Locals list
                  initialRoute: AppRouterNames.rSplashScreen,
                  onGenerateRoute: widget.appRouter.onGenerateRoute,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
