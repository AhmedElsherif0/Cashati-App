import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:temp/business_logic/cubit/goals_cubit/goals_cubit.dart';
import 'package:temp/constants/app_strings.dart';
import 'package:temp/data/models/goals/goal_model.dart';
import 'package:temp/presentation/styles/colors.dart';
import 'package:temp/presentation/widgets/goals_widgets/circle_button.dart';
import 'package:temp/presentation/widgets/goals_widgets/complete_indicator.dart';

import '../../../data/repository/formats_mixin.dart';
import 'goal_rich_text.dart';

class GoalCard extends StatelessWidget with FormatsMixin {
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
    final aLangCode = translator.activeLanguageCode;
    final amountRepeat = goal.goalSaveAmountRepeat.toLowerCase();
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: AppColor.primaryColor, borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GoalName(goalName: goal.goalName),
                  GoalsRichText(
                      title: AppStrings.goalCost.tr(),
                      subTitle: currencyFormat(context,goal.goalRemainingAmount)),
                  GoalsRichText(
                      title: AppStrings.yourSaving.tr(),
                      subTitle:
                          '${currencyFormat(context,goal.goalSaveAmount)}, ${context.read<GoalsCubit>().repeatUiValues(goal.goalSaveAmountRepeat)}'),
                  GoalsRichText(
                      title: AppStrings.beginIn.tr(),
                      subTitle:
                          '${formatDayWeek(goal.goalStartSavingDate, aLangCode)},'
                          ' ${formatDayDate(goal.goalStartSavingDate, aLangCode)}'),
                  GoalsRichText(
                      title: AppStrings.completeIn.tr(),
                      subTitle: '${formatDayWeek(goal.goalCompletionDate, aLangCode)},'
                          ' ${formatDayDate(goal.goalCompletionDate, aLangCode)}'),
                  GoalsRichText(
                      title: AppStrings.remainingAmount.tr(),
                      subTitle: currencyFormat(context,goal.goalRemainingAmount)),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 1.h),
                    child: Center(child: CompleteIndicatorBar(goalModel: goal)),
                  )
                ],
              ),
            ),
          ),
          Positioned(
              right: translator.activeLanguageCode == 'en' ? -70.w : 0,
              left: translator.activeLanguageCode == 'en' ? 0 : -70.w,
              top: 2.h,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleIconButton(iconData: Icons.edit_outlined, onTap: editFunction),
                  CircleIconButton(iconData: Icons.close, onTap: deleteFunction),
                ],
              ))
        ],
      ),
    );
  }
}

class GoalName extends StatelessWidget {
  const GoalName({super.key, required this.goalName});

  final String goalName;

  @override
  Widget build(BuildContext context) {
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
