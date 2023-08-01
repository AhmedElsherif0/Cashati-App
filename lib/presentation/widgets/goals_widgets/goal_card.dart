import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:temp/data/models/goals/goal_model.dart';
import 'package:temp/data/repository/helper_class.dart';
import 'package:temp/presentation/styles/colors.dart';
import 'package:temp/presentation/widgets/goals_widgets/circle_button.dart';
import 'package:temp/presentation/widgets/goals_widgets/complete_indicator.dart';

import 'goal_rich_text.dart';

class GoalCard extends StatelessWidget with HelperClass {
  const GoalCard(
      {Key? key,
      required this.goal,
      required this.editFunction,
      required this.deleteFunction})
      : super(key: key);
  final GoalModel goal;
  final Function() editFunction;
  final Function() deleteFunction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: AppColor.primaryColor, borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: EdgeInsets.only(left: 4.0.w, right: 3.0.w, top: 2.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  goalName(context, goal.goalName),
                  GoalsRichText(
                      title: 'Goal Cost',
                      subTitle: '${goal.goalRemainingAmount} LE'),
                  GoalsRichText(
                      title: 'Your Saving',
                      subTitle:
                          '${goal.goalSaveAmount} LE, ${goal.goalSaveAmountRepeat}'),
                  GoalsRichText(
                      title: 'Begin In',
                      subTitle: '${formatDayWeek(goal.goalStartSavingDate)},'
                          ' ${formatDayDate(goal.goalStartSavingDate)}'),
                  GoalsRichText(
                      title: 'Complete In',
                      subTitle: '${formatDayWeek(goal.goalCompletionDate)},'
                          ' ${formatDayDate(goal.goalCompletionDate)}'),
                  GoalsRichText(
                      title: 'Remaining Amount',
                      subTitle: '${goal.goalRemainingAmount} LE'),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 1.h),
                    child: Center(child: CompleteIndicatorBar(goalModel: goal)),
                  )
                ],
              ),
            ),
          ),
          Positioned(
              right: 2.h,
              top: 2.h,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleIconButton(
                    iconData: Icons.edit_outlined,
                    onTap: editFunction,
                  ),
                  CircleIconButton(
                    iconData: Icons.close,
                    onTap: deleteFunction,
                  ),
                ],
              ))
        ],
      ),
    );
  }

  Widget goalName(BuildContext context, String goalName) {
    return Flexible(
      child: Padding(
        padding: EdgeInsets.only(bottom: 1.0.h),
        child: Text(
          goalName,
          style:
              Theme.of(context).textTheme.headline5!.copyWith(color: AppColor.white),
        ),
      ),
    );
  }
}
