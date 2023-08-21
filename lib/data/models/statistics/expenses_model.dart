import 'package:temp/data/models/transactions/transaction_model.dart';
import '../../../constants/enum_classes.dart';

class ExpensesModel {
  //Todo:: why we use name var ??
  StatisticsHeader name = StatisticsHeader.Daily;
  String chooseDate = 'Choose day';
  String chooseInnerData = 'Day';
  String totalTransaction = 'Total';
  double salary = 10000;
  double totalExpense = 5000;
  DateTime dateTime = DateTime.now();
  bool isImportant = false;
  List<TransactionModel> transactions= [];

  ExpensesModel(
      {required this.name,
      required this.chooseDate,
      required this.chooseInnerData,
      required this.totalTransaction,
      required this.salary,
      required this.totalExpense,
      required this.dateTime,
      required this.isImportant});
}
