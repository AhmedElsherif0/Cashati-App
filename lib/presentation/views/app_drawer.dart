import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:temp/constants/app_icons.dart';
import 'package:temp/constants/app_strings.dart';
import 'package:temp/presentation/router/app_router_names.dart';
import 'package:temp/presentation/screens/test_screens/add_goal_test_screen.dart';
import 'package:temp/presentation/screens/test_screens/fetch_goals_test.dart';
import 'package:temp/presentation/styles/decorations.dart';
import 'package:temp/presentation/widgets/drawer_item.dart';

import '../screens/test_screens/all_inc_and_exp_test.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 65.w,
      shape: RoundedRectangleBorder(
          borderRadius: translator.activeLanguageCode == 'ar'
              ? AppDecorations.rightDrawer
              : AppDecorations.liftDrawer),
      child: Column(
        children: [
          const Spacer(flex: 2),
          Expanded(
            flex: 3,
            child: DrawerItem(
                icon: AppIcons.closeDrawer, onTap: () => Navigator.of(context).pop()),
          ),
          const Spacer(flex: 3),
          Expanded(
            flex: 6,
            child: DrawerItem(
              icon: AppIcons.expenseDrawer,
              text: AppStrings.expenseTypes.tr(),
              onTap: () =>
                  Navigator.of(context).pushNamed(AppRouterNames.rExpenseRepeatType),
            ),
          ),
          Expanded(
            flex: 6,
            child: DrawerItem(
              icon: AppIcons.incomeDrawer,
              text: AppStrings.incomeTypes.tr(),
              onTap: () =>
                  Navigator.of(context).pushNamed(AppRouterNames.rIncomeRepeatType),
            ),
          ),
          Expanded(
              flex: 6,
              child: DrawerItem(
                  icon: AppIcons.goalsDrawer,
                  text: AppStrings.goals.tr(),
                  onTap: () =>
                      Navigator.pushNamed(context, AppRouterNames.rGetGoals))),
          Expanded(
            flex: 6,
            child: DrawerItem(
                icon: AppIcons.exportDrawer,
                text: AppStrings.exportData.tr(),
                onTap: () {}),
          ),
          /* Expanded(
            flex: 3,
            child: DrawerItem(
                icon: AppIcons.goalsDrawer, text: 'Fetch Goals Test', onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const FetchGoalsTestScreen(),
                ),
              );

            }),
          ),*/
          /*Expanded(
            flex: 3,
            child: DrawerItem(
                icon: AppIcons.notificationSetting,
                text: 'Test Data',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AllExpIncTest(),
                    ),
                  );
                }),
          ),
          Expanded(
            flex: 3,
            child: DrawerItem(
                icon: AppIcons.notificationSetting,
                text: ' Add Goal',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AddGoalTestScreen(),
                    ),
                  );
                }),
          ),
          Expanded(
            flex: 3,
            child: DrawerItem(
                icon: AppIcons.poundSterlingSign,
                text: ' Confirm Today Payment',
                onTap: () {
                  Navigator.pushNamed(context, AppRouterNames.rConfirmToday);
                }),
          ),*/
          const Spacer(flex: 3),
        ],
      ),
    );
  }
}
