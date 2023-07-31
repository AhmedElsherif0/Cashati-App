import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:temp/data/models/transactions/transaction_model.dart';

import '../../constants/enum_classes.dart';
import '../../presentation/screens/home/part_time_details.dart';
import '../../presentation/screens/home/statistics_details_screen.dart';
import '../../presentation/styles/colors.dart';
import '../../presentation/widgets/expenses_and_income_widgets/important_or_fixed.dart';
import '../../presentation/widgets/expenses_and_income_widgets/underline_text_button.dart';

mixin HelperClass {
  List<String> getWeekRange({required DateTime chosenDay}) {
    int lastDay =
        DateTime(chosenDay.year, chosenDay.month != 12 ? chosenDay.month + 1 : 1, 0)
            .day;
    final chosenMonth = chosenDay.month;
    return [
      'From 1 \\ $chosenMonth   To  7 \\ $chosenMonth',
      'From 8 \\ $chosenMonth   To  14 \\ $chosenMonth',
      'From 15 \\ $chosenMonth   To  21 \\ $chosenMonth',
      'From 22 \\ $chosenMonth   To  28  \\ $chosenMonth',
      'From 29 \\ $chosenMonth   To  $lastDay \\ $chosenMonth'
    ];
  }

  Widget onPressDetails(
      int generateIndex, List<TransactionModel> transactions, builderIndex) {
    switch (generateIndex) {
      case 0:
        return PartTimeDetails(
            transactionModel: transactions[builderIndex], insideIndex: builderIndex);
      case 1:
        return StatisticsDetailsScreen(
            index: builderIndex, transactions: transactions);
    }
    return StatisticsDetailsScreen(index: builderIndex, transactions: transactions);
  }

  Widget switchWidgets(
      {SwitchWidgets? switchWidgets,
      TransactionModel? transaction,
      PriorityType? priorityType,
      void Function()? onPress}) {
    switch (switchWidgets) {
      case SwitchWidgets.higherExpenses:
        String expense = (transaction!.isExpense) ? 'Expense' : 'Income';
        return PriorityWidget(
          text: 'Highest $expense',
          color: !transaction.isPriority ? AppColor.red : AppColor.pinkishGrey,
        );
      case SwitchWidgets.seeMore:
        return UnderLineTextButton(onPressed: onPress, text: 'see more');
      case SwitchWidgets.defaultWidget:
        return const SizedBox.shrink();
      default:
    }
    return const SizedBox.shrink();
  }

  String priorityNames(bool isExpense, bool isPriority) => isPriority
      ? (isExpense ? 'Important' : 'Fixed')
      : (isExpense ? 'NotImportant' : 'NotFixed');

  String switchPriorityName(PriorityType priorityType) {
    switch (priorityType) {
      case PriorityType.NotImportant:
        return PriorityType.NotImportant.name;
      case PriorityType.Fixed:
        return PriorityType.Fixed.name;
      case PriorityType.NotFixed:
        return PriorityType.NotFixed.name;
      case PriorityType.Important:
        return PriorityType.Important.name;
      case PriorityType.HigherExpenses:
        return PriorityType.HigherExpenses.name;
    }
  }

  String formatDayDate(DateTime inputDate) =>
      DateFormat('d / MM/ yyyy').format(inputDate.toLocal());

  String formatWeekDate(DateTime inputDate) =>
      DateFormat(' MM / yyyy').format(inputDate.toLocal()).replaceFirst('0', '');

  Future onNavigateTo<T>(context, Widget navigateScreen) =>
      Navigator.push(context, MaterialPageRoute(builder: (context) => navigateScreen));
}
