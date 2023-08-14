import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:temp/business_logic/cubit/goals_cubit/goals_cubit.dart';
import 'package:temp/constants/app_icons.dart';
import 'package:temp/constants/app_strings.dart';
import 'package:temp/data/models/goals/goal_model.dart';
import 'package:temp/data/models/goals/repeated_goal_model.dart';
import 'package:temp/presentation/router/app_router_names.dart';
import 'package:temp/presentation/styles/colors.dart';
import 'package:temp/presentation/widgets/app_bars/app_bar_with_icon.dart';
import 'package:temp/presentation/widgets/drop_down_custom.dart';
import 'package:temp/presentation/widgets/goals_widgets/goal_card.dart';

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({Key? key}) : super(key: key);

  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  @override
  void initState() {
    BlocProvider.of<GoalsCubit>(context).fetchAllGoals();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final goalCubit = BlocProvider.of<GoalsCubit>(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0.w),
        child: RefreshIndicator(
          onRefresh: () async => goalCubit.fetchAllGoals(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 6.h),
              AppBarWithIcon(
                titleIcon: AppIcons.medalAppBar,
                titleName: AppStrings.yourGoals.tr(),
                firstIcon: Icons.arrow_back_ios,
                actionIcon: AppIcons.addIcon,
                actionIconFunction: () =>
                    Navigator.of(context).pushNamed(AppRouterNames.rAddGoal),
              ),
              BlocBuilder<GoalsCubit, GoalsState>(
                builder: (context, state) => Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 4.h),
                    DropDownCustomWidget(
                      dropDownList: goalCubit.goalsFilterDropDown,
                      hint: goalCubit.choseFilter.toLowerCase().tr(),
                      onChangedFunc: (value)=> goalCubit.chooseFilter(value),
                      icon: AppIcons.downArrow,
                      isExpanded: false,
                      backgroundColor: AppColor.veryLightGrey,
                      leadingIcon: AppIcons.filterGreen,
                      arrowIconColor: AppColor.pineGreen,
                      hintStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w300,
                          fontSize: 13.dp,
                          color: AppColor.pineGreen),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: goalCubit.registeredGoals.length,
                        itemBuilder: (context, index) {
                          final GoalRepeatedDetailsModel goal =
                              goalCubit.registeredGoals[index];
                          return GoalCard(
                            goal: goal.goal,
                            deleteFunction: () => goalCubit.deleteGoal(goal.goal),
                            editFunction: () {},
                          );
                        },
                      ),
                    ),
                  ],
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
