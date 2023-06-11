import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../constants/enum_classes.dart';
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

  Widget switchWidgets(SwitchWidgets? switchWidgets, {String name = 'Expense'}) {
    Widget widget;
    switch (switchWidgets) {
      case SwitchWidgets.higherExpenses:
        widget = PriorityWidget(text: 'Highest $name', circleColor: AppColor.red);
        break;
      case SwitchWidgets.seeMore:
        widget = UnderLineTextButton(onPressed: () {}, text: 'see more');
        break;
      default:
        widget = const SizedBox.shrink();
    }
    return widget;
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
    }
  }

  Color switchPriorityColor(PriorityType priorityType) {
    switch (priorityType) {
      case PriorityType.NotImportant:
      case PriorityType.NotFixed:
        return AppColor.pinkishGrey;
      default:
        AppColor.secondColor;
    }
    return AppColor.secondColor;
  }

  String formatDayDate(DateTime inputDate) =>
      DateFormat('d / MM/ yyyy').format(inputDate.toLocal());

  String formatWeekDate(DateTime inputDate) =>
      DateFormat(' MM / yyyy').format(inputDate.toLocal()).replaceFirst('0', '');

  Future onPressed<T>(context, Widget navigateScreen) =>
      Navigator.push(context, MaterialPageRoute(builder: (context) => navigateScreen));
}
