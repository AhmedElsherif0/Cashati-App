import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/constants/app_icons.dart';
import 'package:temp/data/models/transactions/transaction_details_model.dart';
import 'package:temp/data/models/transactions/transaction_model.dart';
import '../../constants/enum_classes.dart';
import '../styles/colors.dart';
import '../widgets/transaction_card.dart';

class TabCardView extends StatelessWidget {
  const TabCardView(
      {Key? key,
      required this.expenseRepeatList,
      required this.onPressSeeMore,
      this.priorityName = 'Important',
      this.priceColor = AppColor.red,
      required this.isVisible,
      this.seeMoreOrDetailsOrHighest,
      this.isRepeated = false,
      this.priorityColor = AppColor.secondColor})
      : super(key: key);

  final bool isVisible;
  final bool isRepeated;
  final List<TransactionRepeatDetailsModel> expenseRepeatList;
  final String priorityName;
  final Color priceColor;
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
                onPressSeeMore: onPressSeeMore,
                isRepeated: isRepeated,
                priorityColor: priorityColor,
                priorityName: priorityName,
              );
            });
  }
}
