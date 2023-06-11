import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/constants/app_icons.dart';
import 'package:temp/data/models/transactions/transaction_details_model.dart';
import 'package:temp/data/models/transactions/transaction_model.dart';
import 'package:temp/data/repository/helper_class.dart';
import 'package:temp/presentation/widgets/expenses_and_income_widgets/important_or_fixed.dart';

import '../../constants/enum_classes.dart';
import '../styles/colors.dart';
import '../widgets/transaction_card.dart';

class TabCardView extends StatelessWidget {
  const TabCardView(
      {Key? key,
      required this.expenseRepeatList,
      required this.onPressSeeMore,
      this.priorityName = PriorityType.Important,
      required this.isVisible,
      this.seeMoreOrDetailsOrHighest,
      this.isRepeated = false,
      this.priorityColor = AppColor.secondColor})
      : super(key: key);

  final bool isVisible;
  final bool isRepeated;
  final List<TransactionRepeatDetailsModel> expenseRepeatList;
  final PriorityType priorityName;
  final Color priorityColor;
  final void Function() onPressSeeMore;
  final SwitchWidgets? seeMoreOrDetailsOrHighest;

  @override
  Widget build(BuildContext context) {
    return expenseRepeatList.isEmpty
        ? Image.asset(AppIcons.noDataCate)
        : ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: expenseRepeatList.length,
            itemBuilder: (context, index) {
              final transactionModel = expenseRepeatList[index].transactionModel;
              return TransactionsCard(
                transactionModel: transactionModel,
                index: index,
                priceColor: priorityColor,
                isVisible: isVisible,
                //onPressedssSeeMore: onPressSeeMore,
                isRepeated: isRepeated,
                priorityColor: priorityColor,
                priorityName: priorityName.name,
              );
            });
  }
}

class TabCardViewEdited extends StatelessWidget with HelperClass {
  const TabCardViewEdited(
      {Key? key,
      required this.expenseList,
      required this.onPressSeeMore,
      this.priorityName = PriorityType.Important,
      required this.isVisible,
      this.seeMoreOrDetailsOrHighest,
      this.isRepeated = false,
      this.priorityColor = AppColor.secondColor})
      : super(key: key);

  final bool isVisible;
  final bool isRepeated;
  final List<TransactionModel> expenseList;
  final PriorityType priorityName;
  final Color priorityColor;
  final void Function() onPressSeeMore;
  final SwitchWidgets? seeMoreOrDetailsOrHighest;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return expenseList.isEmpty
        ? Image.asset(AppIcons.noDataCate)
        : ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: expenseList.length,
            itemBuilder: (context, index) {
              final expenseModel = expenseList[index];
              return Column(
                children: [
                  Card(
                    margin: EdgeInsets.symmetric(horizontal: 16.sp),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.sp),
                    ),
                    elevation: 4.sp,
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
                                child: Text(expenseModel.name,
                                    overflow: TextOverflow.ellipsis,
                                    style: textTheme.headline5),
                              ),
                              // const Spacer(),

                              Text(
                                '${expenseModel.amount} LE',
                                style: textTheme.headline5?.copyWith(
                                    color: expenseModel.isExpense
                                        ? AppColor.red
                                        : AppColor.secondColor),
                              ),
                            ],
                          ),
                          SizedBox(height: 1.h),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              formatDayDate(expenseModel.createdDate),
                              style: textTheme.subtitle1,
                            ),
                          ),
                          SizedBox(height: 1.h),
                          Row(
                            children: [
                              Column(
                                children: [
                                  Visibility(
                                    visible: isRepeated,
                                    child: Column(
                                      children: [
                                        SizedBox(height: 2.h),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(expenseModel.repeatType,
                                              style: textTheme.subtitle1),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Visibility(
                                    visible: isVisible,
                                    child: switchWidgets(seeMoreOrDetailsOrHighest,
                                        name: expenseModel.isExpense
                                            ? 'Expense'
                                            : 'Income'),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    const Spacer(),
                                    PriorityWidget(
                                      isPriority: expenseModel.isPriority,
                                      text: priorityNames(expenseModel.isExpense,
                                          expenseModel.isPriority),
                                      circleColor: priorityColor,
                                    ),
                                  ],
                                ),
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
            });
  }
}
