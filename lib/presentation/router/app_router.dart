import 'package:flutter/material.dart';
import 'package:temp/presentation/screens/add_exp_inc_screen.dart';
import 'package:temp/presentation/screens/home/drawer_screens/expense_repeat_type_screen.dart';
import 'package:temp/presentation/screens/home/drawer_screens/income_repeat_type_screen.dart';
import 'package:temp/presentation/screens/home/nav_bottom_screens/home_screen.dart';
import 'package:temp/presentation/screens/shared/notification_screen.dart';
import 'package:temp/presentation/screens/welcome/splash_screen.dart';
import 'package:temp/presentation/subcategories/add_subcategory_screen.dart';
import '../screens/home/nav_bottom_screens/control_screen.dart';
import '../screens/home/nav_bottom_screens/settings_screen.dart';
import '../screens/welcome/on_boarding_screens.dart';
import 'app_router_names.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouterNames.rSplashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case AppRouterNames.rHomeRoute:
        return MaterialPageRoute(builder: (_) => const ControlScreen());
      case AppRouterNames.rOnBoardingRoute:
        return MaterialPageRoute(builder: (_) => const OnBoardScreens());
      case AppRouterNames.rSettingsRoute:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case AppRouterNames.rExpenseRepeatType:
        return MaterialPageRoute(
            builder: (_) => const ExpenseRepeatTypeScreen());
      case AppRouterNames.rIncomeRepeatType:
        return MaterialPageRoute(
            builder: (_) => const IncomeRepeatTypeScreen());
      case AppRouterNames.rExpenseRepeatDetails:
        return MaterialPageRoute(
            builder: (_) => const AddExpenseOrIncomeScreen());
      case AppRouterNames.rAddExpenseOrIncomeScreen:
        return MaterialPageRoute(
            builder: (_) => const AddExpenseOrIncomeScreen());
      case AppRouterNames.rAddSubCategory:
        return MaterialPageRoute(builder: (_) => const AddSubCategoryScreen());
      case AppRouterNames.rNotification:
        return MaterialPageRoute(builder: (_) => const NotificationScreen());
      default:
        return null;
    }
  }
}
