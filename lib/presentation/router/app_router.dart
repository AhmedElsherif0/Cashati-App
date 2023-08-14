import 'package:flutter/material.dart';
import 'package:temp/presentation/goals/add_goal_screen.dart';
import 'package:temp/presentation/goals/goals_screen.dart';
import 'package:temp/presentation/screens/add_exp_inc_screen.dart';
import 'package:temp/presentation/screens/home/drawer_screens/expense_repeat_type_screen.dart';
import 'package:temp/presentation/screens/home/drawer_screens/income_repeat_type_screen.dart';
import 'package:temp/presentation/screens/home/statistics_details_screen.dart';
import 'package:temp/presentation/screens/shared/notification_screen.dart';
import 'package:temp/presentation/screens/test_screens/add_goal_test_screen.dart';
import 'package:temp/presentation/screens/test_screens/confirm_payments.dart';
import 'package:temp/presentation/screens/test_screens/fetch_goals_test.dart';
import 'package:temp/presentation/screens/test_screens/notifications_test.dart';
import 'package:temp/presentation/screens/welcome/splash_screen.dart';
import 'package:temp/presentation/screens/welcome/welcome_screen.dart';
import 'package:temp/presentation/subcategories/add_subcategory_screen.dart';
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
      case AppRouterNames.rExpenseRepeatDetails:
        return pageBuilderRoute(child: const AddExpenseOrIncomeScreen());
      case AppRouterNames.rAddExpenseOrIncomeScreen:
        return pageBuilderRoute(child: const AddExpenseOrIncomeScreen());
      case AppRouterNames.rAddSubCategory:
        return pageBuilderRoute(child: const AddSubCategoryScreen());
      case AppRouterNames.rNotification:
        return pageBuilderRoute(child: const NotificationScreen());
      case AppRouterNames.rNotificationTest:
        return pageBuilderRoute(child: const NotificationTestScreen());
     /* case AppRouterNames.rTestAddGoalScreen:
        return pageBuilderRoute(child: AddGoalTestScreen());*/
     /* case AppRouterNames.rFetchGoalScreen:
        return pageBuilderRoute(child: const FetchGoalsTestScreen());*/
      case AppRouterNames.rAddGoal:
        return pageBuilderRoute(child: const AddGoalScreen());
      case AppRouterNames.rGetGoals:
        return pageBuilderRoute(child: const GoalsScreen());
     /* case AppRouterNames.rConfirmToday:
        return pageBuilderRoute(child: const ConfirmPaymentsScreen());*/
       case AppRouterNames.rStatisticsDetailsScreen:
        return pageBuilderRoute(child: const StatisticsDetailsScreen());
      default:
    }
    return null;
  }

  static PageRouteBuilder pageBuilderRoute(
      {context, Widget child = const Navigator()}) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 600),
      reverseTransitionDuration: const Duration(milliseconds: 600),
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: animation.drive(
            Tween(begin: const Offset(1, 0.0), end: Offset.zero).chain(
              CurveTween(curve: Curves.easeInOutBack),
            ),
          ),
          child: child,
        );
      },
    );
  }
}
