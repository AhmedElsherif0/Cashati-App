import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../widgets/expenses_and_income_widgets/chart_bar.dart';

class ChartBarsCard extends StatelessWidget {
  const ChartBarsCard({
    Key? key,
    this.transactionsValues = const [],
  }) : super(key: key);

  final List<Map<String, dynamic>> transactionsValues;

  /* List<ExpensesModel> get recentExpense {
    ExpensesLists expensesList = ExpensesLists();
    return expensesList.expensesData.where((element) {
      return element.dateTime
          .isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }*/

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
          height:  _charHeight(index),
          percentage: transactionsValues.length <= 5 ? 'Week' : 'Month',
          totalExp: _totalTransActions(index).isNaN
              ? 0.0
              : _totalTransActions(index).toDouble(),
        );
      },
    );
  }
}
