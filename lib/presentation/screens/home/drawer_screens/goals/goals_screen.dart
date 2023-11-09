import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:temp/business_logic/cubit/confirm_payments/confirm_payment_cubit.dart';
import 'package:temp/business_logic/cubit/goals_cubit/goals_cubit.dart';
import 'package:temp/constants/app_icons.dart';
import 'package:temp/constants/app_strings.dart';
import 'package:temp/data/models/goals/goal_model.dart';
import 'package:temp/data/models/goals/repeated_goal_model.dart';
import 'package:temp/data/repository/helper_class.dart';
import 'package:temp/presentation/router/app_router_names.dart';
import 'package:temp/presentation/styles/colors.dart';
import 'package:temp/presentation/views/app_bar_with_icon.dart';
import 'package:temp/presentation/widgets/dorp_downs_buttons/goals_drop_down.dart';
import 'package:temp/presentation/widgets/goals_widgets/goal_card.dart';
import 'package:temp/presentation/widgets/show_dialog.dart';

import '../../../../../business_logic/cubit/home_cubit/home_cubit.dart';
import '../../../../../constants/app_images.dart';

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({Key? key}) : super(key: key);

  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> with AlertDialogMixin, HelperClass {
  @override
  void initState() {
    BlocProvider.of<GoalsCubit>(context).fetchAllGoals();
    super.initState();
  }

  _deleteGoal(GoalModel goalModel) {
    BlocProvider.of<GoalsCubit>(context).deleteGoal(goalModel);
    BlocProvider.of<HomeCubit>(context)
        .onRemoveNotificationForDeletedTransaction(goalModel.goalName);
    BlocProvider.of<HomeCubit>(context).getNotificationList();
    BlocProvider.of<ConfirmPaymentCubit>(context).onDeleteGoal(goalModel);
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
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(height: 2.h),
                    GoalsFilterWidget(
                      dropDownList: goalCubit.goalsFilterDropDown,
                      hint: goalCubit.choseFilter.toLowerCase().tr(),
                      onChangedFunc: (value) => goalCubit.chooseFilter(value),
                      icon: AppIcons.downArrow,
                      isExpanded: false,
                      backgroundColor: AppColor.veryLightGrey,
                      leadingIcon: AppIcons.filterGreen,
                      arrowIconColor: AppColor.pineGreen,
                      hintStyle: Theme.of(context).textTheme.subtitle1,
                    ),
                    SizedBox(height: 1.h),
                    Expanded(
                      child: goalCubit.registeredGoals.isEmpty
                          ? Image.asset(AppImages.noDataCate)
                          : ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: goalCubit.registeredGoals.length,
                              itemBuilder: (context, index) {
                                final GoalRepeatedDetailsModel goal =
                                    goalCubit.registeredGoals[index];
                                return GoalCard(
                                  goal: goal.goal,
                                  deleteFunction: () => showYesOrNoDialog(
                                      title: AppStrings.deleteGoal.tr(),
                                      message: getMsg(goal.goal.goalName),
                                      onYes: () {
                                        _deleteGoal(goal.goal);
                                      },
                                      context: context),
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
