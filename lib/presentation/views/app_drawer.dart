import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/constants/app_icons.dart';
import 'package:temp/presentation/router/app_router_names.dart';
import 'package:temp/presentation/screens/test_screens/add_goal_test_screen.dart';
import 'package:temp/presentation/screens/test_screens/fetch_goals_test.dart';
import 'package:temp/presentation/widgets/drawer_item.dart';

import '../screens/test_screens/all_inc_and_exp_test.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 65.w,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20.sp),
              topRight: Radius.circular(20.sp))),
      child: Column(
        children: [
          const Spacer(flex: 2),
          Expanded(
            flex: 3,
            child: DrawerItem(
                icon: AppIcons.closeDrawer,
                onTap: () => Navigator.of(context).pop()),
          ),
          const Spacer(),
          Expanded(
            flex: 3,
            child: DrawerItem(
              icon: AppIcons.expenseDrawer,
              text: 'Expense Types',
              onTap: () => Navigator.of(context)
                  .pushNamed(AppRouterNames.rExpenseRepeatType),
            ),
          ),
          Expanded(
            flex: 3,
            child: DrawerItem(
                icon: AppIcons.incomeDrawer,
                text: 'Income Types',
              onTap: () => Navigator.of(context)
                  .pushNamed(AppRouterNames.rIncomeRepeatType),),
          ),
          Expanded(
            flex: 3,
            child: DrawerItem(
                icon: AppIcons.goalsDrawer, text: 'Goals', onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const FetchGoalsTestScreen(),
                ),
              );

            }),
          ),
          Expanded(
            flex: 3,
            child: DrawerItem(
                icon: AppIcons.exportDrawer, text: 'Export Data', onTap: () {}),
          ),
          Expanded(
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
                text: 'Test Add Goal',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>  AddGoalTestScreen(),
                    ),
                  );
                }),
          ),
          const Spacer(flex: 3),
        ],
      ),
    );
  }
}
