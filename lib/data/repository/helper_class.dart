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
    final from = AppStrings.from.tr(), to = AppStrings.to.tr();

    String isEnglish(String arabNum, String engNum) {
      final chosenMonth = '${chosenDay.month}';

      return translator.activeLanguageCode == 'en'
          ? '${arabicToEnglishNum(engNum)} \\ ${arabicToEnglishNum(chosenMonth)}'
          : '${engToArabNum(arabNum)} \\ ${engToArabNum(chosenMonth)}';
    }

    return [
      '$from ${isEnglish('١', '1')}  $to ${isEnglish('٧', '7')}',
      '$from ${isEnglish('٨', '8')}  $to ${isEnglish('١٤', '14')} ',
      '$from ${isEnglish('١٥', '15')}  $to ${isEnglish('٢١', '21')} ',
      '$from ${isEnglish('٢٢', '22')}  $to ${isEnglish('٢٨', '28')} ',
      '$from ${isEnglish('٢٩', '29')}  $to ${isEnglish('٣٠', '$lastDay')} ',
    ];
  }

  /// will convert from english numbers to arabic numbers
  String engToArabNum(String engNum) {
    return engNum
        .replaceAll("0", "٠")
        .replaceAll("1", "١")
        .replaceAll("2", "٢")
        .replaceAll("3", "٣")
        .replaceAll("4", "٤")
        .replaceAll("5", "٥")
        .replaceAll("6", "٦")
        .replaceAll("7", "٧")
        .replaceAll("8", "٨")
        .replaceAll("9", "٩");
  }

  /// will convert from arabic numbers to english numbers
  String arabicToEnglishNum(String arabicNum) {
    return translator.activeLanguageCode == 'en'? arabicNum
        .replaceAll("٠", "0")
        .replaceAll("١", "1")
        .replaceAll("٢", "2")
        .replaceAll("٣", "3")
        .replaceAll("٤", "4")
        .replaceAll("٥", "5")
        .replaceAll("٦", "6")
        .replaceAll("٧", "7")
        .replaceAll("٨", "8")
        .replaceAll("٩", "9"):arabicNum
        .replaceAll("0", "0")
        .replaceAll("1", "1")
        .replaceAll("2", "2")
        .replaceAll("3", "3")
        .replaceAll("4", "4")
        .replaceAll("5", "5")
        .replaceAll("6", "6")
        .replaceAll("7", "7")
        .replaceAll("8", "8")
        .replaceAll("9", "9");
  }

  String currencyFormat(num currency) => NumberFormat.currency(
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
