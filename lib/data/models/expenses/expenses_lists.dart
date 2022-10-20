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
        price: 14100.00,
        chooseDate: 'choose Week',
        chooseInnerData: 'Week',
        dateTime: DateTime.now(),
        isImportant: false,
        totalExpenses: 'No data to Show'),
    ExpensesModel(
        header: 'Monthly',
        price: 11100.00,
        chooseDate: 'choose Month',
        chooseInnerData: 'Month',
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
        totalExpenses: 'No data to Show'),
    ExpensesModel(
        header: 'Monthly',
        price: 1900.00,
        chooseDate: 'choose Month',
        chooseInnerData: 'Month',
        dateTime: DateTime.now(),
        isImportant: false,
        totalExpenses: 'No data to Show'),
    ExpensesModel(
        header: 'Monthly',
        price: 6000.00,
        chooseDate: 'choose Month',
        chooseInnerData: 'Month',
        dateTime: DateTime.now(),
        isImportant: false,
        totalExpenses: 'No data to Show'),
    ExpensesModel(
        header: 'Monthly',
        price: 2000.00,
        chooseDate: 'choose Month',
        chooseInnerData: 'Month',
        dateTime: DateTime.now(),
        isImportant: false,
        totalExpenses: 'No data to Show'),
    ExpensesModel(
        header: 'Monthly',
        price: 3000.00,
        chooseDate: 'choose Month',
        chooseInnerData: 'Month',
        dateTime: DateTime.now(),
        isImportant: false,
        totalExpenses: 'No data to Show'),
    ExpensesModel(
        header: 'Monthly',
        price: 9000.00,
        chooseDate: 'choose Month',
        chooseInnerData: 'Month',
        dateTime: DateTime.now(),
        isImportant: false,
        totalExpenses: 'No data to Show'),
    ExpensesModel(
        header: 'Monthly',
        price: 1000.00,
        chooseDate: 'choose Month',
        chooseInnerData: 'Month',
        dateTime: DateTime.now(),
        isImportant: false,
        totalExpenses: 'No data to Show'),
    ExpensesModel(
        header: 'Monthly',
        price: 5000.00,
        chooseDate: 'choose Month',
        chooseInnerData: 'Month',
        dateTime: DateTime.now(),
        isImportant: false,
        totalExpenses: 'No data to Show'),
    ExpensesModel(
        header: 'Monthly',
        price: 7820.00,
        chooseDate: 'choose Month',
        chooseInnerData: 'Month',
        dateTime: DateTime.now(),
        isImportant: false,
        totalExpenses: 'No data to Show'),
  ];
}
