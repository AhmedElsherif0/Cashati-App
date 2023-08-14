import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:temp/data/models/transactions/transaction_model.dart';

import '../../constants/app_strings.dart';
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
    final from = AppStrings.from.tr(), to = AppStrings.to.tr();
    return [
      '$from 1 \\ $chosenMonth  $to 7 \\ $chosenMonth',
      '$from 8 \\ $chosenMonth   $to  14 \\ $chosenMonth',
      '$from 15 \\ $chosenMonth   $to  21 \\ $chosenMonth',
      '$from 22 \\ $chosenMonth   $to  28  \\ $chosenMonth',
      '$from 29 \\ $chosenMonth   $to  $lastDay \\ $chosenMonth'
    ];
  }

  String currencyFormat(num currency) =>
     NumberFormat.currency(
            symbol: translator.activeLanguageCode == 'en' ? 'LE' : 'جم',
            locale: translator.activeLanguageCode == 'en' ? 'en_US' : 'ar_EG')
        .format(currency);


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
        String expense = ((transaction!.isExpense) ? 'Expense' : 'Income').tr();
        return PriorityWidget(
          text: 'Highest $expense',
          color: !transaction.isPriority ? AppColor.red : AppColor.pinkishGrey,
        );
      case SwitchWidgets.seeMore:
        return UnderLineTextButton(
          onPressed: onPress,
          text: AppStrings.seeMore.tr(),
        );
      case SwitchWidgets.defaultWidget:
        return const SizedBox.shrink();
      default:
    }
    return const SizedBox.shrink();
  }

  String priorityNames(bool isExpense, bool isPriority) => isPriority
      ? (isExpense ? 'important' : 'fixed').tr()
      : (isExpense ? 'notImportant' : 'notFixed').tr();

  String switchPriorityName(PriorityType priorityType) {
    switch (priorityType) {
      case PriorityType.notImportant:
        return PriorityType.notImportant.name;
      case PriorityType.fixed:
        return PriorityType.fixed.name;
      case PriorityType.notFixed:
        return PriorityType.notFixed.name;
      case PriorityType.important:
        return PriorityType.important.name;
      case PriorityType.higherExpenses:
        return PriorityType.higherExpenses.name;
    }
  }

  String formatDayDate(DateTime inputDate, String currentLocal) =>
      DateFormat('d / MM/ yyyy', currentLocal).format(inputDate.toLocal());

  String formatDayWeek(DateTime inputDate, String currentLocal) =>
      DateFormat('EEE', currentLocal).format(inputDate.toLocal());

  String formatWeekDate(DateTime inputDate, String currentLocal) =>
      DateFormat(' MM / yyyy', currentLocal)
          .format(inputDate.toLocal())
          .replaceFirst('0', '');

  Future onNavigateTo<T>(context, Widget navigateScreen) =>
      Navigator.push(context, MaterialPageRoute(builder: (context) => navigateScreen));
}
