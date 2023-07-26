import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/data/models/goals/goal_model.dart';

import '../../constants/app_icons.dart';
import '../styles/colors.dart';
import '../widgets/buttons/cancel_confirm_text_button.dart';
import '../widgets/confirm_paying_title_card.dart';
import '../widgets/custom_row_icon_with_title.dart';

class ConfirmPayingGoals extends StatelessWidget {
  const ConfirmPayingGoals({
    Key? key,
    required this.amount,
    required this.onEditAmount,
    required this.index,
    required this.onDelete,
    required this.onCancel,
    required this.changedAmount,
    required this.onEditChangedAmount,
    required this.onConfirm,
    required this.blockedAmount,
    required this.onEditBlockedAmount,
    required this.goalModel,
  }) : super(key: key);

  final int index;
  final double amount;
  final GoalModel goalModel;
  final double changedAmount;
  final double blockedAmount;
  final void Function() onEditAmount;
  final void Function() onEditChangedAmount;
  final void Function() onEditBlockedAmount;
  final void Function() onDelete;
  final void Function() onCancel;
  final void Function() onConfirm;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// must be child for a Expanded Widget.
        Expanded(
          child: Card(
            elevation: 4.sp,
            color: AppColor.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.sp)),
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child:
                      ConfirmPayingTitleCard(cardTitle: 'Goals'),
                ),
                 Expanded(
                  flex: 3,
                  child: RowIconWithTitle(
                      toolTipMessage: "Goal Name",

                      startIcon: AppIcons.goals, title: goalModel.goalName),
                ),
                Expanded(
                  flex: 3,
                  child: RowIconWithTitle(
                      toolTipMessage: "Registered Repeated amount",

                      startIcon: AppIcons.poundSterlingSign,
                      title: '${goalModel.goalSaveAmount.toStringAsFixed(0)} LE, Weekly',
                      endIcon: onPressIcon(onEditAmount, AppIcons.editIcon)),
                ),
                Expanded(
                  flex: 3,
                  child: RowIconWithTitle(
                    toolTipMessage: "Paid Amount",

                    startIcon: AppIcons.change,
                    title: '${goalModel.goalSaveAmount.toStringAsFixed(0)} LE',
                    endIcon: onPressIcon(onEditChangedAmount, AppIcons.editIcon),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: RowIconWithTitle(
                    toolTipMessage: "Remaining Goal Target Amount",

                    startIcon: AppIcons.blockedCash,
                    title: '${blockedAmount.toStringAsFixed(0)} LE',
                    endIcon: onPressIcon(onEditChangedAmount, AppIcons.editIcon),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      const Spacer(),
                      Expanded(
                        flex: 10,
                        child: InkWell(
                          onTap: onDelete,
                          child: SvgPicture.asset(AppIcons.delete,
                              color: AppColor.primaryColor),
                        ),
                      ),
                      CancelConfirmTextButton(
                        onCancel: onCancel,
                        onConfirm: onConfirm,
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  InkWell onPressIcon(onTap, icon) => InkWell(
        onTap: onTap,
        child: SvgPicture.asset(icon, color: AppColor.primaryColor),
      );
}
