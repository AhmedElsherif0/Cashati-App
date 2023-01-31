import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/constants/app_icons.dart';
import 'package:temp/presentation/router/app_router_names.dart';
import 'package:temp/presentation/widgets/app_bars/app_bar_with_icon.dart';

class GoalsScreen extends StatelessWidget {
  const GoalsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          SizedBox(
          height: 6.h,
        ),
          AppBarWithIcon(
            titleIcon: AppIcons.medalAppBar,
            titleName: 'Your Goals',
            firstIcon: Icons.arrow_back_ios,
            actionIcon: AppIcons.addIcon,
            actionIconFunction: ()=>Navigator.pushNamed(context, AppRouterNames.rAddGoal),
          ),
         // bodyContent(goalsCubit, context)
    ]),
      ),);
  }
}
