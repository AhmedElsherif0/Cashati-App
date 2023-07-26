import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/constants/app_icons.dart';
import 'package:temp/data/models/notification/notification_model.dart';
import 'package:temp/presentation/widgets/confirm_paying_title_card.dart';
import 'package:temp/presentation/widgets/expenses_and_income_widgets/underline_text_button.dart';

import '../styles/colors.dart';
import '../widgets/buttons/cancel_confirm_text_button.dart';
import '../widgets/custom_row_icon_with_title.dart';

class NotifyingConfirmPaying extends StatelessWidget {
  const NotifyingConfirmPaying({
    Key? key,
    required this.onEditAmount,
    required this.onDetails,
    required this.date,
    required this.notificationModel,
    required this.onDelete,
    required this.onCancel,
    required this.onConfirm,
  }) : super(key: key);

  final String date;
  final NotificationModel notificationModel;
  final void Function() onEditAmount;
  final void Function() onDetails;
  final void Function() onDelete;
  final void Function() onCancel;
  final void Function() onConfirm;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        /// must be child for a Expanded Widget.
        Expanded(
          child: Card(
            elevation: 8.sp,
            color: AppColor.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.sp)),
            child: Column(
              children: [
                Expanded(
                  child: ConfirmPayingTitleCard(
                      cardTitle: notificationModel.modelName),
                ),

                Expanded(
                  child: RowIconWithTitle(
                    toolTipMessage: "Transaction paid amount,you can change it",

                    startIcon: AppIcons.poundSterlingSign,
                    title: '${notificationModel.amount.toStringAsFixed(0)} LE',
                    endIcon: InkWell(
                      onTap: onEditAmount,
                      child: SvgPicture.asset(AppIcons.editIcon,
                          color: AppColor.primaryColor),
                    ),
                  ),
                ),
                Expanded(
                  child: RowIconWithTitle(
                      toolTipMessage: "Transaction Date",

                      startIcon: AppIcons.calender, title: DateFormat.yMMMd().format(notificationModel.checkedDate)),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      const Spacer(),
                      Row(
                        children: [
                          const Spacer(),
                          Expanded(
                            flex: 7,
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  AppIcons.exclamationMark,
                                  color: AppColor.primaryColor,
                                ),
                                SizedBox(width: 2.w,),
                                UnderLineTextButton(
                                    onPressed: onDetails,
                                    text: 'Details',
                                    textStyle: textTheme.headline6?.copyWith(
                                      decoration: TextDecoration.underline,
                                      decorationStyle: TextDecorationStyle.solid,
                                      decorationThickness: 2,
                                    ),
                                    decorationColor: AppColor.primaryColor),
                              ],
                            ),
                          ),
                          const Spacer(flex: 2),
                          Expanded(
                            flex: 3,
                            child: InkWell(
                              onTap: onDelete,
                              child: SvgPicture.asset(AppIcons.delete,
                                  color: AppColor.primaryColor),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(flex: 2),
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
}
