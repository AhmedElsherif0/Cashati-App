import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/constants/enum_classes.dart';
import 'package:temp/data/models/transactions/transaction_model.dart';
import 'package:temp/presentation/styles/colors.dart';
import 'package:temp/presentation/widgets/expenses_and_income_widgets/important_or_fixed.dart';
import 'package:temp/presentation/widgets/transaction_card.dart';

import '../../widgets/custom_app_bar.dart';

class StatisticsDetailsScreen extends StatelessWidget {
  const StatisticsDetailsScreen({
    Key? key,
    this.dateTime,
    this.transactions,
  }) : super(key: key);

  final DateTime? dateTime;

  final List<TransactionModel>? transactions;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Column(children: [
        SizedBox(height: 10.sp),
        const CustomAppBar(
          title: 'Day Expense',
          isEndIconVisible: false,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('$dateTime', style: theme.textTheme.headline6),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [PriorityWidget()]),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
                PriorityWidget(
                    text: 'Not Important', circleColor: AppColor.pinkishGrey)
              ])
            ],
          ),
        ),
        Expanded(
          flex: 5,
          child: ListView.builder(
              itemCount: transactions?.length ?? 5,
              itemBuilder: (_, index) {
                final transaction = transactions?[index] ?? TransactionModel();
                return TransactionsCard(
                  index: index,
                  isRepeated: false,
                  isVisible: false,
                  priceColor:
                      transaction.isExpense ? AppColor.secondColor : AppColor.red,
                  transactionModel: transaction,
                  onPressSeeMore: () => onPressed(),
                  priorityName: transaction.isPriority ? 'Important' : 'Not Important',
                  priorityColor: transaction.isPriority
                      ? AppColor.secondColor
                      : AppColor.pinkishGrey,
                  widget: PriorityWidget(
                      text: 'Heighset ${transaction.name}', circleColor: AppColor.red),
                );
              }),
        )
      ]),
    );
  }

  void onPressed() {}

  Color priorityColor(PriorityType priorityType) {
    switch (priorityType) {
      case PriorityType.NotImportant:
        return AppColor.pinkishGrey;
      case PriorityType.NotFixed:
        return AppColor.pinkishGrey;
      default:
        AppColor.secondColor;
    }
    return AppColor.secondColor;
  }
}
