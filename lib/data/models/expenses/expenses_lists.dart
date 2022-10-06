import 'package:temp/data/models/expenses/expenses_model.dart';

///  Importance enum class
enum Importance { importantExpense, notImportantExpense }


class ExpensesLists {
  int daysDate = DateTime.now().day;
  int weekDate = DateTime.now().weekday;
  int monthDate = DateTime.now().weekday;

  List<ExpensesModel> expensesData = [
    ExpensesModel(
        header: 'Daily',
        price: 200,
        chooseDate: 'choose Day',
        chooseInnerData: 'Day',
        dateTime: DateTime.now(),
        isImportant: true,
        totalExpenses: 'No data to Show'),
    ExpensesModel(
        header: 'Weekly',
        price: 1400.00,
        chooseDate: 'choose Week',
        chooseInnerData: 'Week',
        dateTime: DateTime.now(),
        isImportant: false,
        totalExpenses: 'No data to Show'),
    ExpensesModel(
        header: 'Monthly',
        price: 18000.00,
        chooseDate: 'choose Month',
        chooseInnerData: 'Month',
        dateTime: DateTime.now(),
        isImportant: false,
        totalExpenses: 'No data to Show')
  ];
}
