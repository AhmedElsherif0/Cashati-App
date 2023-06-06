import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import '../../data/models/statistics/expenses_model.dart';
import '../widgets/expenses_and_income_widgets/chart_bar.dart';

class ChartBarsCard extends StatelessWidget {
  const ChartBarsCard({
    Key? key,
    required this.expensesList,
    this.transactionsValues = const [],
  }) : super(key: key);

  final List<ExpensesModel> expensesList;
  final List<Map<String, dynamic>> transactionsValues;

  /* List<ExpensesModel> get recentExpense {
    ExpensesLists expensesList = ExpensesLists();
    return expensesList.expensesData.where((element) {
      return element.dateTime
          .isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }*/

  /* List<Map<String, dynamic>> get transactionsValues {
    return List.generate(expensesList.length, (index) {
      final weekDay = DateTime.now().subtract(const Duration(days: 7));
      return {
        'date': DateFormat.E().format(weekDay),
        'amount': expensesList[index].salary,
        'expense': expensesList[index].totalExpense,
      };
    });
  }*/

  double _totalTransActions(int index) {
    num salary = transactionsValues[index]['amount'] ?? 10000;
    num expense = transactionsValues[index]['expense'] ?? 0.0;
    return ((expense * 100) / salary);
  }

  double _charHeight(int index) {
    return transactionsValues[index]['expense'] *
        200 /
        transactionsValues[index]['amount'];
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
