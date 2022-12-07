import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/models/transactions/expenses_lists.dart';
import '../../data/models/transactions/expenses_model.dart';
import '../widgets/expenses_and_income_widgets/chart_bar.dart';

class ChartBarsCard extends StatelessWidget {
  const ChartBarsCard({Key? key}) : super(key: key);

  List<Map<String, dynamic>> get groupExpensesValues {
    List<ExpensesModel> expensesList = ExpensesLists().expensesData;
    return List.generate(expensesList.length, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      return {
        'day': DateFormat.E().format(weekDay),
        'amount': expensesList[index].price,
      };
    });
  }

  List<ExpensesModel> get recentExpense {
    ExpensesLists expensesList = ExpensesLists();
    return expensesList.expensesData.where((element) {
      return element.dateTime
          .isAfter(DateTime.now().subtract(const Duration(days: 12)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: groupExpensesValues.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => ChartBar(
          index: index,
          height: groupExpensesValues[index]['amount'] / 100,
          percentage: groupExpensesValues[index]['day'],
          after: recentExpense[index].price / 100,
        ),
      );
  }
}
