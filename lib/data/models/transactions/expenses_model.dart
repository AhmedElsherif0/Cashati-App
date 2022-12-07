enum Header { daily, weekly, monthly }

class ExpensesModel {
  String name = 'Daily';
  String chooseDate = 'Choose day';
  String chooseInnerData = 'Day';
  String totalExpenses = 'Total';
  String priorityName = 'Important';
  num price = 0.0;
  DateTime dateTime = DateTime.now();
  bool isImportant = false;

  ExpensesModel(
      {required this.name,
      required this.chooseDate,
      required this.chooseInnerData,
      required this.totalExpenses,
      required this.price,
      required this.dateTime,
      required this.isImportant});
}
