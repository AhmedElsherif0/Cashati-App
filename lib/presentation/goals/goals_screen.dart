import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/business_logic/cubit/goals_cubit/goals_cubit.dart';
import 'package:temp/constants/app_icons.dart';
import 'package:temp/data/models/goals/goal_model.dart';
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
  }
  @override
  Widget build(BuildContext context) {
    final GoalsCubit goalsCubit = BlocProvider.of<GoalsCubit>(context);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0.w),
        child: RefreshIndicator(
          onRefresh: ()async{
             goalsCubit.fetchAllGoals();
          },
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
                actionIconFunction: () =>
                    Navigator.pushNamed(context, AppRouterNames.rAddGoal),
              ),
              BlocBuilder<GoalsCubit, GoalsState>(
  builder: (context, state) {
    return bodyContent(goalsCubit, context);
  },
)
            ],
          ),
        ),
      ),
    );
  }

  Widget bodyContent(GoalsCubit goalsCubit, context) {
    return Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            SizedBox(height: 4.h,),
            filterDropDown(goalsCubit),
            Expanded(
              child: ListView.builder(
                itemCount: goalsCubit.goals.length,
                  itemBuilder: (context,index){
                  GoalModel goal=goalsCubit.goals[index];
                return GoalCard(goal: goal,
                deleteFunction:(){
                  goalsCubit.deleteGoal(goal);
                },
                  editFunction: (){},
                );
              }),
            ),
          ],
        ));
  }

  Widget filterDropDown(GoalsCubit goalsCubit) {
    return DropDownCustomWidget(
      dropDownList: goalsCubit.goalsFilterDropDown,
      hint: goalsCubit.choseFilter,
      onChangedFunc: goalsCubit.chooseFilter,
      icon: AppIcons.downArrow,
      isExpanded: false,
      backgroundColor: AppColor.veryLightGrey,
      leadingIcon: AppIcons.filterGreen,
      arrowIconColor: AppColor.pineGreen,
      hintStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
          fontWeight: FontWeight.w300,
          fontSize: 13.sp,
          color: AppColor.pineGreen),
    );
  }

}