import 'package:flutter/material.dart';
import 'package:temp/constants/enum_classes.dart';
import 'package:temp/data/models/transactions/transaction_model.dart';
import 'package:temp/data/repository/helper_class.dart';
import 'package:temp/presentation/screens/home/part_time_details.dart';
import 'package:temp/presentation/styles/colors.dart';
import 'package:temp/presentation/widgets/expenses_and_income_widgets/important_or_fixed.dart';
import 'package:temp/presentation/widgets/transaction_card.dart';

import '../../router/app_router.dart';
import '../../widgets/custom_app_bar.dart';

class StatisticsDetailsScreen extends StatelessWidget with HelperClass {
  const StatisticsDetailsScreen({
    Key? key,
    this.transactions = const [],
    this.index = 0,
  }) : super(key: key);

  final List<TransactionModel> transactions;
  final int index;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppBar(title: 'Day Expense', isEndIconVisible: false),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                      transactions[index].repeatType == 'Daily'
                          ? formatDayDate(transactions[index].createdDate)
                          : getWeekRange(
                              chosenDay: transactions[index].createdDate)[index],
                      style: theme.textTheme.headline6),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    transactions[index].isExpense
                        ? const PriorityWidget()
                        : const PriorityWidget(text: 'Fixed')
                  ]),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    transactions[index].isExpense
                        ? const PriorityWidget(
                            text: 'Important', color: AppColor.pinkishGrey)
                        : const PriorityWidget(
                            text: 'Not Fixed', color: AppColor.pinkishGrey)
                  ])
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (_, currIndex) => TransactionsCard(
                  onSeeMore: () => Navigator.push(
                      context,
                      AppRouter.pageBuilderRoute(
                          child:
                              PartTimeDetails(transactionModel: transactions[index]))),
                  index: index,
                  switchWidget: SwitchWidgets.seeMore,
                  isRepeated: false,
                  isVisible: true,
                  transactionModel: transactions[index],
                  priorityName:
                      transactions[index].isPriority ? 'Important' : 'Not Important',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
