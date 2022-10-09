enum Header { daily, weekly, monthly }

class ExpensesModel {
  String header = 'Daily';
  String chooseDate = 'Choose day';
  String chooseInnerData = 'Day';
  String totalExpenses = 'Total Expenses';
  num price = 0.0;
  DateTime dateTime = DateTime.now();
  bool isImportant = false;

  ExpensesModel(
      {required this.header,
      required this.chooseDate,
      required this.chooseInnerData,
      required this.totalExpenses,
      required this.price,
      required this.dateTime,
      required this.isImportant});
}
