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
import 'package:temp/presentation/subcategories/add_subcategory_screen.dart';
import '../screens/home/nav_bottom_screens/control_screen.dart';
import '../screens/home/nav_bottom_screens/settings_screen.dart';
import '../screens/welcome/on_boarding_screens.dart';
import 'app_router_names.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouterNames.rSplashScreen:
        return _pageBuilder(child: const SplashScreen());
      case AppRouterNames.rHomeRoute:
        return _pageBuilder(child: const ControlScreen());
      case AppRouterNames.rOnBoardingRoute:
        return _pageBuilder(child: const OnBoardScreens());
      case AppRouterNames.rSettingsRoute:
        return _pageBuilder(child: const SettingsScreen());
      case AppRouterNames.rExpenseRepeatType:
        return _pageBuilder(child: const ExpenseRepeatTypeScreen());
      case AppRouterNames.rIncomeRepeatType:
        return _pageBuilder(child: const IncomeRepeatTypeScreen());
      case AppRouterNames.rExpenseRepeatDetails:
        return _pageBuilder(child: const AddExpenseOrIncomeScreen());
      case AppRouterNames.rAddExpenseOrIncomeScreen:
        return _pageBuilder(child: const AddExpenseOrIncomeScreen());
      case AppRouterNames.rAddSubCategory:
        return _pageBuilder(child: const AddSubCategoryScreen());
     case AppRouterNames.rNotification:
        return _pageBuilder(child: const NotificationScreen());
      case AppRouterNames.rNotificationTest:
        return _pageBuilder(child: const NotificationTestScreen());
      case AppRouterNames.rTestAddGoalScreen:
        return _pageBuilder(child: AddGoalTestScreen());
      case AppRouterNames.rFetchGoalScreen:
        return _pageBuilder(child: FetchGoalsTestScreen());
      case AppRouterNames.rAddGoal:
        return _pageBuilder(child: AddGoalScreen());
      case AppRouterNames.rGetGoals:
        return _pageBuilder(child: const GoalsScreen());
      case AppRouterNames.rConfirmToday:
        return _pageBuilder(child: const ConfirmPaymentsScreen());
     /* case AppRouterNames.rStatisticsDetailsScreen:
        return _pageBuilder(child: const StatisticsDetailsScreen());*/
      default:
    }
    return null;
  }

  PageRouteBuilder _pageBuilder({required Widget child}) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 500),
      reverseTransitionDuration: const Duration(milliseconds: 500),
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
