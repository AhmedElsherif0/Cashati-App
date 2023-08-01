import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import '../../constants/enum_classes.dart';
import '../../data/models/transactions/transaction_model.dart';
import '../../data/repository/helper_class.dart';
import '../styles/colors.dart';
import '../widgets/expenses_and_income_widgets/important_or_fixed.dart';

class TransactionCardView extends StatelessWidget with HelperClass {
  const TransactionCardView({
    Key? key,
    required this.transaction,
    required this.onPressSeeMore,
    this.priorityName = PriorityType.Important,
    required this.isVisible,
    this.seeMoreOrDetailsOrHighest,
    this.isRepeated = false,
  }) : super(key: key);

  final bool isVisible;
  final bool isRepeated;
  final TransactionModel transaction;
  final PriorityType priorityName;
  final void Function() onPressSeeMore;
  final SwitchWidgets? seeMoreOrDetailsOrHighest;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Card(
          margin: EdgeInsets.symmetric(horizontal: 16.dp),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.dp),
          ),
          elevation: 4.dp,
          color: AppColor.lightGrey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 5,
                      child: Text(transaction.name,
                          overflow: TextOverflow.ellipsis, style: textTheme.headline5),
                    ),
                    Text(
                      '${transaction.amount} LE',
                      style: textTheme.headline5?.copyWith(
                          color: transaction.isExpense
                              ? AppColor.red
                              : AppColor.secondColor),
                    ),
                  ],
                ),
                SizedBox(height: 1.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    formatDayDate(transaction.createdDate),
                    style: textTheme.subtitle1,
                  ),
                ),
                SizedBox(height: isRepeated ? 3.h : 1.h),
                Row(
                  children: [
                    Visibility(
                      visible: isRepeated,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text('Repeated', style: textTheme.subtitle1),
                      ),
                    ),
                    const Spacer()
                  ],
                ),
                Row(
                  children: [
                    Visibility(
                      visible: isVisible,
                      child: switchWidgets(
                          onPress: onPressSeeMore,
                          switchWidgets: SwitchWidgets.seeMore,
                          transaction: transaction),
                    ),
                    const Spacer(),
                    PriorityWidget(
                      color: transaction.isPriority
                          ? AppColor.secondColor
                          : AppColor.pinkishGrey,
                      text:
                          priorityNames(transaction.isExpense, transaction.isPriority),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 3.h)
      ],
    );
  }
}
