import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/constants/app_icons.dart';
import 'package:temp/presentation/widgets/confirm_paying_title_card.dart';
import 'package:temp/presentation/widgets/expenses_and_income_widgets/underline_text_button.dart';

import '../styles/colors.dart';
import '../widgets/cancel_confirm_text_button.dart';
import '../widgets/custom_row_icon_with_title.dart';

class ConfirmPayingExpense extends StatelessWidget {
  const ConfirmPayingExpense({
    Key? key,
    required this.amount,
    required this.onEditAmount,
    required this.onDetails,
    required this.index,
    required this.date,
    required this.onDelete,
    required this.onCancel,
    required this.onConfirm,
  }) : super(key: key);

  final int index;
  final double amount;
  final String date;
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
                      cardTitle: 'Expense', index: index),
                ),
                const Expanded(
                  child: RowIconWithTitle(
                      startIcon: AppIcons.categories, title: 'Family'),
                ),
                Expanded(
                  child: RowIconWithTitle(
                    startIcon: AppIcons.poundSterlingSign,
                    title: '${amount.toStringAsFixed(0)} LE',
                    endIcon: InkWell(
                      onTap: onEditAmount,
                      child: SvgPicture.asset(AppIcons.editIcon,
                          color: AppColor.primaryColor),
                    ),
                  ),
                ),
                 Expanded(
                  child: RowIconWithTitle(
                      startIcon: AppIcons.calender, title: date),
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
                        onCancel: () {},
                        onConfirm: () {},
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
