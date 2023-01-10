import 'package:hive/hive.dart';
import 'package:temp/data/models/transactions/transaction_types_model.dart';

import '../../local/hive/hive_database.dart';
import '../../models/transactions/transaction_details_model.dart';

mixin MixinTransaction {
  final TransactionRepeatTypes _expenseRepeatTypes = TransactionRepeatTypes();
  final HiveHelper _hiveDatabase = HiveHelper();

  /// should be convert to int...
  final DateTime _today = DateTime.now();

  get hiveDatabase => _hiveDatabase;

  get expenseRepeatTypes => _expenseRepeatTypes;

  get today => _today;

  get putNextShownDate => _putNextShownDate;

  DateTime _putNextShownDate(
      {required DateTime paymentDate, required String repeatType}) {
    switch (repeatType) {
      case 'Daily':
        return paymentDate;
      case 'Weekly':
        //if(expensePaymentDate.day==today.day&&
        // expensePaymentDate.month==today.month&&
        // expensePaymentDate.year==today.year){
        if (
            // expensePaymentDate.difference(today).inDays==0
            checkSameDay(date: paymentDate)) {
          return paymentDate.add(const Duration(days: 7));
        } else {
          // return expensePaymentDate.add(Duration(days: 7));
          // the right return is below
          return paymentDate;
        }
      case 'Monthly':
        if (
            //expensePaymentDate.difference(today).inDays==0
            checkSameDay(date: paymentDate)) {
          return paymentDate.add(const Duration(days: 30));
        } else {
          return paymentDate;
        }
      case 'No Repeat':
        return paymentDate;

      default:
        return _today;
    }
  }

  bool isEqualToday({required DateTime date}) {
    //DateTime today=DateTime(2022,12,5);

    // if(today.difference(date).inDays==0){
    return (today.day == date.day &&
        today.month == date.month &&
        today.year == date.year)
        ? true
        : false;
  }

  bool checkSameDay({required DateTime date}) {
    int currentTime = DateTime.now().day;
    return date.day == currentTime ? true : false;
  }

  /// box is already opened..now you can handle the data as you can.
  List<TransactionRepeatDetailsModel> getExpenseDataFromBox(String boxName) {
    List<TransactionRepeatDetailsModel> expenseDetailsData = [];
    try {
      ///get box name first
      Box<TransactionRepeatDetailsModel> expenseBox = _hiveDatabase
          .getBoxName<TransactionRepeatDetailsModel>(boxName: boxName);

      /// get data from box and assign it to dailyExpense List.
      expenseDetailsData = expenseBox.values.toList();
      print('the length :${expenseDetailsData.length}');
    } catch (error) {
      print('new error ${error.toString()}');
    }
    return expenseDetailsData;
  }
}
