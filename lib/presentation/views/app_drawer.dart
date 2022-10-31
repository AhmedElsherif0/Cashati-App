import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/constants/app_icons.dart';
import 'package:temp/presentation/widgets/drawer_item.dart';

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
            child: DrawerItem(icon: AppIcons.closeDrawer, onTap: () {}),
          ),
          const Spacer(),
          Expanded(
            flex: 3,
            child: DrawerItem(
                icon: AppIcons.expenseDrawer, text: 'Expense Types', onTap: () {}),
          ),
          Expanded(
            flex: 3,
            child: DrawerItem(
                icon: AppIcons.incomeDrawer, text: 'Income Types', onTap: () {}),
          ),
          Expanded(
            flex: 3,
            child:
                DrawerItem(icon: AppIcons.goalsDrawer, text: 'Goals', onTap: () {}),
          ),
          Expanded(
            flex: 3,
            child: DrawerItem(
                icon: AppIcons.exportDrawer, text: 'Export Data', onTap: () {}),
          ),
          const Spacer(flex: 3),
        ],
      ),
    );
  }
}
