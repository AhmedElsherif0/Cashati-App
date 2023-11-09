import 'package:flutter/material.dart';
import 'package:temp/presentation/screens/home/drawer_screens/expense_repeat_type_screen.dart';
import 'package:temp/presentation/screens/home/drawer_screens/income_repeat_type_screen.dart';
import 'package:temp/presentation/screens/home/nav_bottom_screens/home_screens/add_exp_inc_screen.dart';
import 'package:temp/presentation/screens/home/nav_bottom_screens/home_screens/add_subcategory_screen.dart';
import 'package:temp/presentation/screens/home/statistics_details_screen.dart';
import 'package:temp/presentation/screens/shared/notification_screen.dart';
import 'package:temp/presentation/screens/welcome/splash_screen.dart';
import 'package:temp/presentation/screens/welcome/welcome_screen.dart';
import 'package:temp/presentation/styles/decorations.dart';

import '../screens/home/drawer_screens/goals/add_goal_screen.dart';
import '../screens/home/drawer_screens/goals/goals_screen.dart';
import '../screens/home/nav_bottom_screens/control_screen.dart';
import '../screens/home/nav_bottom_screens/settings_screen.dart';
import '../screens/welcome/on_boarding_screens.dart';
import 'app_router_names.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouterNames.rSplashScreen:
        return pageBuilderRoute(child: const SplashScreen());
      case AppRouterNames.rHomeRoute:
        return pageBuilderRoute(child: const ControlScreen());
      case AppRouterNames.rOnBoardingRoute:
        return pageBuilderRoute(child: const OnBoardScreens());
      case AppRouterNames.rWelcomeScreen:
        return pageBuilderRoute(child: const WelcomeScreen());
      case AppRouterNames.rSettingsRoute:
        return pageBuilderRoute(child: const SettingsScreen());
      case AppRouterNames.rExpenseRepeatType:
        return pageBuilderRoute(child: const ExpenseRepeatTypeScreen());
      case AppRouterNames.rIncomeRepeatType:
        return pageBuilderRoute(child: const IncomeRepeatTypeScreen());
      case AppRouterNames.rAddExpenseOrIncomeScreen:
        return pageBuilderRoute(child: const AddExpenseOrIncomeScreen());
      case AppRouterNames.rAddSubCategory:
        return pageBuilderRoute(child: const AddSubCategoryScreen());
      case AppRouterNames.rNotification:
        return pageBuilderRoute(child: const NotificationScreen());
      case AppRouterNames.rAddGoal:
        return pageBuilderRoute(child: const AddGoalScreen());
      case AppRouterNames.rGetGoals:
        return pageBuilderRoute(child: const GoalsScreen());
      case AppRouterNames.rStatisticsDetailsScreen:
        return pageBuilderRoute(child: const StatisticsDetailsScreen());
      default:
    }
    return null;
  }

  static PageRouteBuilder pageBuilderRoute(
      {context, Widget child = const Navigator()}) {
    return PageRouteBuilder(
      transitionDuration: AppDecorations.duration600ms,
      reverseTransitionDuration: AppDecorations.duration600ms,
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: animation.drive(
              Tween(begin: const Offset(1, 0.0), end: Offset.zero)
                  .chain(CurveTween(curve: Curves.easeInOutBack))),
          child: child,
        );
      },
    );
  }
}
