import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/data/models/transactions/transaction_model.dart';
import 'package:temp/data/repository/helper_class.dart';
import 'package:temp/presentation/styles/colors.dart';
import 'package:temp/presentation/widgets/expenses_and_income_widgets/important_or_fixed.dart';
import 'package:temp/presentation/widgets/transaction_card.dart';

import '../../widgets/custom_app_bar.dart';

class StatisticsDetailsScreen extends StatelessWidget with HelperClass {
  const StatisticsDetailsScreen({
    Key? key,
    this.transactions = const [],
    this.index = 0,
  }) : super(key: key);

  final List<TransactionModel> transactions;
  final int index;

  // void onPressed() {}

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Column(children: [
        SizedBox(height: 10.sp),
        const CustomAppBar(title: 'Day Expense', isEndIconVisible: false),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(formatDayDate(transactions[index].createdDate),
                  style: theme.textTheme.headline6),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [PriorityWidget()]),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                PriorityWidget(
                  text: 'Not Important',
                  isPriority: transactions[index].isPriority,
                )
              ])
            ],
          ),
        ),
        Expanded(
          flex: 5,
          child: ListView.builder(
              itemCount: transactions.length ?? 5,
              itemBuilder: (_, currIndex) {
                final transaction = transactions[currIndex];
                return TransactionsCard(
                  index: index,
                  isRepeated: false,
                  isVisible: false,
                  priceColor:
                      transaction.isExpense ? AppColor.secondColor : AppColor.red,
                  transactionModel: transaction,
                  // onPress: () => onPressed(),
                  priorityName: transaction.isPriority ? 'Important' : 'Not Important',
                  priorityColor: transaction.isPriority
                      ? AppColor.secondColor
                      : AppColor.pinkishGrey,
                  widget: PriorityWidget(
                      text: 'Heighset ${transaction.name}',
                      isPriority: transaction.isPriority),
                );
              }),
        )
      ]),
    );
  }
}
