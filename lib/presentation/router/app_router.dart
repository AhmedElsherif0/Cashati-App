import 'package:flutter/material.dart';
import '../screens/home/control_screen.dart';
import '../screens/home/settings_screen.dart';
import '../screens/welcome/on_boarding_screens.dart';
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
