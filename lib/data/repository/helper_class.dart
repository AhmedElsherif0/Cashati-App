import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:temp/data/models/transactions/transaction_model.dart';

import '../../constants/app_strings.dart';
import '../../constants/enum_classes.dart';
import '../../presentation/styles/colors.dart';
import '../../presentation/widgets/buttons/underline_text_button.dart';
import '../../presentation/widgets/expenses_and_income_widgets/important_or_fixed.dart';

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

  String getMsg(String name) {
    final isEnglish = translator.activeLanguageCode == 'en';
    final questionMark = isEnglish ? '?' : '؟';
    return "${AppStrings.areYouSureYouWantToDelete.tr()}"
        " ${name} ${AppStrings.permanently.tr()} $questionMark";
  }

  String weekNum(index) => translator.activeLanguageCode == 'en'
      ? '${index + 1}'
      : engToArabNum('${index + 1}');

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
    return arabicNum
        .replaceAll("٠", "0")
        .replaceAll("١", "1")
        .replaceAll("٢", "2")
        .replaceAll("٣", "3")
        .replaceAll("٤", "4")
        .replaceAll("٥", "5")
        .replaceAll("٦", "6")
        .replaceAll("٧", "7")
        .replaceAll("٨", "8")
        .replaceAll("٩", "9");
  }

  Widget switchWidgets(
      {SwitchWidgets? switchWidgets,
      TransactionModel? transaction,
      PriorityType? priorityType,
      Color? borderLineColor,
      void Function()? onPress}) {
    switch (switchWidgets) {
      case SwitchWidgets.higherExpenses:
        String transX =
            ((transaction!.isExpense) ? AppStrings.expense : AppStrings.income).tr();
        return PriorityWidget(
          text: '${AppStrings.highest.tr()} ${transX.tr()}',
          color: !transaction.isPriority ? AppColor.red : AppColor.pinkishGrey,
        );
      case SwitchWidgets.seeMore:
        return UnderLineTextButton(
          borderLineColor: borderLineColor!,
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
}
