import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:temp/constants/app_strings.dart';
import 'package:temp/constants/enum_classes.dart';
import 'package:temp/data/models/transactions/transaction_model.dart';
import 'package:temp/data/repository/helper_class.dart';
import 'package:temp/presentation/screens/home/part_time_details.dart';
import 'package:temp/presentation/styles/colors.dart';
import 'package:temp/presentation/widgets/expenses_and_income_widgets/important_or_fixed.dart';
import 'package:temp/presentation/widgets/transaction_card.dart';

import '../../router/app_router.dart';
import '../../widgets/custom_app_bar.dart';

class StatisticsWeekDetailsScreen extends StatelessWidget with HelperClass {
  const StatisticsWeekDetailsScreen({
    Key? key,
    this.transactions = const [],
  }) : super(key: key);

  final List<TransactionModel> transactions;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
                title: '${transactions.first.repeatType} ${AppStrings.expenseSmall}',
                isEndIconVisible: false),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                      transactions.first.repeatType == AppStrings.daily
                          ? formatDayDate(transactions.first.createdDate,
                              translator.activeLanguageCode)
                          : getWeekRange(
                              chosenDay: transactions.first.createdDate).first,
                      style: theme.textTheme.headline6),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    transactions.first.isExpense
                        ? const PriorityWidget()
                        : const PriorityWidget(text: AppStrings.fixed)
                  ]),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    transactions.first.isExpense
                        ? const PriorityWidget(
                            text: AppStrings.important, color: AppColor.pinkishGrey)
                        : const PriorityWidget(
                            text: AppStrings.notFixed, color: AppColor.pinkishGrey)
                  ])
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (_, currIndex) => TransactionsCard(
                  index: currIndex,
                  isRepeated: false,
                  isSeeMore: true,
                  transactionModel: transactions[currIndex],
                  priorityName: transactions[currIndex].isPriority
                      ? AppStrings.important
                      : AppStrings.notImportant,

                  /// check if this is the higherExpense so show it.
                  switchWidget: SwitchWidgets.higherExpenses,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
