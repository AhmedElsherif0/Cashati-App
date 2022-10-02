import 'package:flutter/material.dart';
import 'package:temp/presentation/screens/control/control_screen.dart';
import 'package:temp/presentation/screens/settings/settings_screen.dart';
import 'package:temp/presentation/screens/user/on_boarding_screens.dart';

import '../screens/user/home_screen.dart';

import 'app_router_names.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouterNames.rHomeRoute:
        return MaterialPageRoute(builder: (_) => const ControlScreen());
      case AppRouterNames.rOnBoardingRoute:
        return MaterialPageRoute(builder: (_) => const OnBoardScreens());
      case AppRouterNames.rSettingsRoute:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      default:
        return null;
    }
  }
}
