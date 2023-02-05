import 'package:temp/constants/enum_classes.dart';
import 'package:temp/data/models/statistics/expenses_model.dart';

class ExpensesLists {
  int daysDate = DateTime.now().day;
  int weekDate = DateTime.now().weekday;
  int monthDate = DateTime.now().month;

  List<String> noRepeats =['Day','Weekly','Monthly','No Repeat'];
  List<String> statisticsList =['By Day','By Month','By Year'];
  List<ExpensesModel> expensesData = [
    ExpensesModel(
        name: Header.daily,
        salary: 10000,
        totalExpense: 2400,
        chooseDate: 'choose Day',
        chooseInnerData: 'Day',
        dateTime: DateTime.now(),
        isImportant: true,
        totalTransaction: 'No data to Show'),
    ExpensesModel(
        name: Header.monthly,
        salary: 10000,
        totalExpense: 4000,
        chooseDate: 'choose Week',
        chooseInnerData: 'Week',
        dateTime: DateTime.now(),
        isImportant: false,
        totalTransaction: 'No data to Show'),
    ExpensesModel(
        name: Header.weekly,
        salary: 10000,
        totalExpense: 6000,
        chooseDate: 'choose Month',
        chooseInnerData: 'Month',
        dateTime: DateTime.now(),
        isImportant: false,
        totalTransaction: 'No data to Show'),
    ExpensesModel(
        name: Header.monthly,
        salary: 10000,
        totalExpense: 0,
        chooseDate: 'choose Month',
        chooseInnerData: 'Month',
        dateTime: DateTime.now(),
        isImportant: false,
        totalTransaction: 'No data to Show'),
    ExpensesModel(
        name: Header.monthly,
        salary: 10000,
        totalExpense: 21111,
        chooseDate: 'choose Month',
        chooseInnerData: 'Month',
        dateTime: DateTime.now(),
        isImportant: false,
        totalTransaction: 'No data to Show'),
    ExpensesModel(
        name: Header.monthly,
        salary: 10000,
        totalExpense: 9800,
        chooseDate: 'choose Month',
        chooseInnerData: 'Month',
        dateTime: DateTime.now(),
        isImportant: false,
        totalTransaction: 'No data to Show'),
    ExpensesModel(
        name: Header.monthly,
        salary: 10000,
        totalExpense: 1444,
        chooseDate: 'choose Month',
        chooseInnerData: 'Month',
        dateTime: DateTime.now(),
        isImportant: false,
        totalTransaction: 'No data to Show'),
    ExpensesModel(
        name: Header.monthly,
        salary: 10000,
        totalExpense: 6220,
        chooseDate: 'choose Month',
        chooseInnerData: 'Month',
        dateTime: DateTime.now(),
        isImportant: false,
        totalTransaction: 'No data to Show'),
    ExpensesModel(
        name: Header.monthly,
        salary: 10000,
        totalExpense: 3000,
        chooseDate: 'choose Month',
        chooseInnerData: 'Month',
        dateTime: DateTime.now(),
        isImportant: false,
        totalTransaction: 'No data to Show'),
    ExpensesModel(
        name: Header.monthly,
        salary: 10000,
        totalExpense: 7200,
        chooseDate: 'choose Month',
        chooseInnerData: 'Month',
        dateTime: DateTime.now(),
        isImportant: false,
        totalTransaction: 'No data to Show'),
    ExpensesModel(
        name: Header.monthly,
        salary: 10000,
        totalExpense: 920,
        chooseDate: 'choose Month',
        chooseInnerData: 'Month',
        dateTime: DateTime.now(),
        isImportant: false,
        totalTransaction: 'No data to Show'),
    ExpensesModel(
        name: Header.monthly,
        salary: 10000,
        totalExpense: 8600,
        chooseDate: 'choose Month',
        chooseInnerData: 'Month',
        dateTime: DateTime.now(),
        isImportant: false,
        totalTransaction: 'No data to Show'),
  ];
  List<ExpensesModel> expensesData2 = [
    ExpensesModel(
        name: Header.daily,
        salary: 10000,
        totalExpense: 8799,
        chooseDate: 'choose Day',
        chooseInnerData: 'Day',
        dateTime: DateTime.now(),
        isImportant: true,
        totalTransaction: 'No data to Show'),
    ExpensesModel(
        name: Header.monthly,
        salary: 10000,
        totalExpense: 6220,
        chooseDate: 'choose Month',
        chooseInnerData: 'Month',
        dateTime: DateTime.now(),
        isImportant: false,
        totalTransaction: 'No data to Show'),
    ExpensesModel(
        name: Header.monthly,
        salary: 10000,
        totalExpense: 0,
        chooseDate: 'choose Month',
        chooseInnerData: 'Month',
        dateTime: DateTime.now(),
        isImportant: false,
        totalTransaction: 'No data to Show'),
    ExpensesModel(
        name: Header.monthly,
        salary: 10000,
        totalExpense: 0,
        chooseDate: 'choose Month',
        chooseInnerData: 'Month',
        dateTime: DateTime.now(),
        isImportant: false,
        totalTransaction: 'No data to Show'),
  ];
}
