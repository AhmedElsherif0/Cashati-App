import 'package:flutter/material.dart';
import 'package:temp/constants/app_icons.dart';

import '../../constants/enum_classes.dart';
import '../../data/models/transactions/transaction_model.dart';
import '../styles/colors.dart';
import '../widgets/transaction_card.dart';
/*

class TabCardView extends StatefulWidget {
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
  final List<TransactionModel> expenseRepeatList;
  final PriorityType priorityName;
  final Color priorityColor;
  final void Function() onPressSeeMore;
  final SwitchWidgets? seeMoreOrDetailsOrHighest;

  @override
  State<TabCardView> createState() => _TabCardViewState();
}

class _TabCardViewState extends State<TabCardView> {
  @override
  Widget build(BuildContext context) {
    return widget.expenseRepeatList.isEmpty
        ? Image.asset(AppIcons.noDataCate)
        : ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: widget.expenseRepeatList.length,
            itemBuilder: (context, index) {
              final transactionModel =
                  widget.expenseRepeatList[index];
              return TransactionsCard(
                transactionModel: transactionModel,
                index: index,
                isVisible: widget.isVisible,
                isRepeated: widget.isRepeated,
                priorityName: widget.priorityName.name,
                onSeeMore: () {},
                switchWidget: SwitchWidgets.seeMore,
              );
            },
          );
  }
}
*/
