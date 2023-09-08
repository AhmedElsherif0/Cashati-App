import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/svg.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:temp/constants/app_icons.dart';
import 'package:temp/constants/app_strings.dart';
import 'package:temp/data/models/transactions/transaction_model.dart';
import 'package:temp/data/repository/helper_class.dart';
import 'package:temp/presentation/widgets/confirm_paying_title_card.dart';
import 'package:temp/presentation/widgets/buttons/underline_text_button.dart';

import '../../data/repository/formats_mixin.dart';
import '../styles/colors.dart';
import '../widgets/buttons/cancel_confirm_text_button.dart';
import '../widgets/custom_row_icon_with_title.dart';

class ConfirmPayingExpense extends StatelessWidget with FormatsMixin {
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
    required this.transactionModel,
  }) : super(key: key);

  final int index;
  final double amount;
  final String date;
  final TransactionModel transactionModel;
  final void Function() onEditAmount;
  final void Function() onDetails;
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
            elevation: 8.dp,
            color: AppColor.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.dp)),
            child: Column(
              children: [
                Expanded(
                    child: ConfirmPayingTitleCard(cardTitle: transactionModel.name)),
                Expanded(
                  child: RowIconWithTitle(
                      toolTipMessage: AppStrings.transactionCategoryAndSub,
                      startIcon: AppIcons.categories,
                      title:
                          "${transactionModel.mainCategory} , ${transactionModel.subCategory}"),
                ),
                Expanded(
                  child: RowIconWithTitle(
                    toolTipMessage: AppStrings.editPaidAmount.tr(),
                    startIcon: AppIcons.poundSterlingSign,
                    title: currencyFormat(context,amount),
                    endIcon: InkWell(
                      onTap: onEditAmount,
                      child: SvgPicture.asset(AppIcons.editIcon,
                          color: AppColor.primaryColor),
                    ),
                  ),
                ),
                Expanded(
                  child: RowIconWithTitle(
                      toolTipMessage: AppStrings.transactionConfirmDate.tr(),
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
                                SvgPicture.asset(
                                  AppIcons.exclamationMark,
                                  color: AppColor.primaryColor,
                                ),
                                if(translator.activeLanguageCode=='en')
                                SizedBox(width: 2.w),
                                UnderLineTextButton(
                                    fontSize: 14.dp,
                                    borderLineColor: AppColor.primaryColor,
                                    onPressed: onDetails,
                                    text: AppStrings.details.tr(),
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
