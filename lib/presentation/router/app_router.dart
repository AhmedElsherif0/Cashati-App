import 'package:flutter/material.dart';
import 'package:temp/presentation/screens/user/on_boarding_screens.dart';

import '../screens/user/home_screen.dart';

import 'app_router_names.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouterNames.rHomeRoute:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case AppRouterNames.rOnBoarding:
        return MaterialPageRoute(builder: (_) => const OnBoardScreens());

      default:
        return null;
    }
  }
}
