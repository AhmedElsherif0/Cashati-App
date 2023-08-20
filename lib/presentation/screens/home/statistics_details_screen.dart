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
            CustomAppBar(
                title: '${transactions[index].repeatType} ${AppStrings.expenseSmall}',
                isEndIconVisible: false),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                      transactions[index].repeatType == AppStrings.daily
                          ? formatDayDate(transactions[index].createdDate,
                              translator.activeLanguageCode)
                          : getWeekRange(
                              chosenDay: transactions[index].createdDate)[index],
                      style: theme.textTheme.headline6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PriorityWidget(
                          text: !transactions[index].isExpense
                              ? AppStrings.important
                              : AppStrings.fixed)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PriorityWidget(
                          text: transactions[index].isExpense
                              ? AppStrings.notImportant
                              : AppStrings.notFixed,
                          color: AppColor.pinkishGrey)
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (_, currIndex) => TransactionsCard(
                  index: index,
                  isRepeated: false,
                  isSeeMore: true,
                  transactionModel: transactions[index],
                  priorityName: transactions[index].isPriority
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
