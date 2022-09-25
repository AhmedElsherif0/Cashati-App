import 'package:flutter/material.dart';
<<<<<<< HEAD
=======
import 'package:temp/presentation/screens/user/on_boarding_screens.dart';
>>>>>>> on noaring screens without navigation

import '../screens/user/home_screen.dart';

import 'app_router_names.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouterNames.rHomeRoute:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

<<<<<<< HEAD
=======

>>>>>>> on noaring screens without navigation
      default:
        return null;
    }
  }
}
