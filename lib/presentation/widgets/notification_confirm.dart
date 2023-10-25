import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/svg.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:temp/constants/app_icons.dart';
import 'package:temp/data/models/notification/notification_model.dart';
import 'package:temp/data/repository/formats_mixin.dart';
import 'package:temp/presentation/widgets/buttons/underline_text_button.dart';
import 'package:temp/presentation/widgets/confirm_paying_title_card.dart';

import '../../constants/app_strings.dart';
import '../styles/colors.dart';
import '../widgets/buttons/cancel_confirm_text_button.dart';
import '../widgets/custom_row_icon_with_title.dart';

class NotifyingConfirmPaying extends StatelessWidget with FormatsMixin {
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
            elevation: 8.dp,
            color: AppColor.white,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(24))),
            child: Column(
              children: [
                Expanded(
                  child:
                      ConfirmPayingTitleCard(cardTitle: notificationModel.modelName),
                ),
                Expanded(
                  child: RowIconWithTitle(
                    toolTipMessage: AppStrings.editPaidAmount,
                    startIcon: AppIcons.poundSterlingSign,
                    title: currencyFormat(context, notificationModel.amount).tr(),
                    endIcon: InkWell(
                      onTap: onEditAmount,
                      child: SvgPicture.asset(AppIcons.editIcon,
                          color: AppColor.primaryColor),
                    ),
                  ),
                ),
                Expanded(
                  child: RowIconWithTitle(
                      toolTipMessage: AppStrings.transactionDate,
                      startIcon: AppIcons.calender,
                      title: date),
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
                                SvgPicture.asset(AppIcons.exclamationMark,
                                    color: AppColor.primaryColor),
                                SizedBox(width: 2.w),
                                UnderLineTextButton(
                                    onPressed: onDetails,
                                    text: AppStrings.details,
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
                          onCancel: onCancel, onConfirm: onConfirm),
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
