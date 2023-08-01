import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:temp/data/repository/helper_class.dart';
import '../../constants/enum_classes.dart';
import '../../data/models/transactions/transaction_model.dart';
import '../styles/colors.dart';
import 'expenses_and_income_widgets/important_or_fixed.dart';

class TransactionsCard extends StatelessWidget with HelperClass {
  const TransactionsCard({
    Key? key,
    required this.transactionModel,
    required this.index,
    this.isSeeMore = false,
    required this.isRepeated,
    required this.priorityName,
    this.switchWidget = SwitchWidgets.higherExpenses,
    this.onSeeMore,
  }) : super(key: key);

  final TransactionModel transactionModel;
  final String priorityName;
  final int index;
  final bool isSeeMore;
  final bool isRepeated;
  final SwitchWidgets switchWidget;
  final void Function()? onSeeMore;

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
                  children: [
                    Text('${transactionModel.name} ${index + 1}',
                        style: textTheme.headline5),
                    const Spacer(),
                    Text(
                      '${transactionModel.amount} LE',
                      style: textTheme.headline5?.copyWith(
                          color: transactionModel.isExpense
                              ? AppColor.red
                              : AppColor.secondColor),
                    ),
                  ],
                ),
                SizedBox(height: 1.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    formatDayDate(transactionModel.createdDate),
                    style: textTheme.subtitle1,
                  ),
                ),
                SizedBox(height: 1.h),
                Column(
                  children: [
                    Visibility(
                      visible: isRepeated,
                      child: Column(
                        children: [
                          SizedBox(height: 2.h),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(transactionModel.repeatType,
                                style: textTheme.subtitle1),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Visibility(
                          visible: isSeeMore,
                          child: switchWidgets(
                              onPress: onSeeMore ?? () {},
                              switchWidgets: switchWidget,
                              transaction: transactionModel),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              const Spacer(),
                              PriorityWidget(
                                  text: priorityNames(transactionModel.isExpense,
                                      transactionModel.isPriority),
                                  color: transactionModel.isPriority
                                      ? AppColor.secondColor
                                      : AppColor.pinkishGrey),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        SizedBox(height: 3.h)
      ],
    );
  }
}
