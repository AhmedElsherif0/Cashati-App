import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:temp/constants/app_strings.dart';

import '../widgets/expenses_and_income_widgets/chart_bar.dart';

class ChartBarsCard extends StatelessWidget {
  const ChartBarsCard({
    Key? key,
    this.transactionsValues = const [],
  }) : super(key: key);

  final List<Map<String, dynamic>> transactionsValues;

  double _totalTransActions(int index) {
    num total = transactionsValues[index]['totalWeeks'] ?? 10000;
    num expense = transactionsValues[index]['expense'] ?? 0.0;
    return ((total * 100) / expense);
  }

  double _charHeight(int index) {
    return (transactionsValues[index]['totalWeeks'] * 200) /
        transactionsValues[index]['expense'];
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: transactionsValues.length,
      scrollDirection: Axis.horizontal,
      itemExtent: transactionsValues.length <= 5 ? 25.w : 16.w,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return ChartBar(
          index: index,
          height: _charHeight(index),
          percentage: transactionsValues.length <= 5
              ? AppStrings.week.tr()
              : AppStrings.month.tr(),
          totalExp: _totalTransActions(index).isNaN
              ? 0.0
              : _totalTransActions(index).toDouble(),
        );
      },
    );
  }
}
