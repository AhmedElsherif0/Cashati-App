import 'package:hive/hive.dart';
import 'package:temp/business_logic/repository/expense_repeat/expense_repeat_repo.dart';
import 'package:temp/data/local/hive/app_boxes.dart';
import 'package:temp/data/local/hive/hive_database.dart';
import 'package:temp/data/models/expenses/expense_details_model.dart';
import 'package:temp/data/models/expenses/expense_types_model.dart';

import '../../models/expenses/expense_model.dart';

class ExpensesRepeatImpl extends ExpenseRepeatRepo {
  final HiveHelper _hiveHelper = HiveHelper();
  List<ExpenseRepeatDetailsModel> expenseRepeatModel = [];

  @override
  Future<Box> openExpenseRepeatBox() async =>
      await _hiveHelper.openBox(boxName: AppBoxes.expenseRepeatTypes);

  @override
  List<ExpenseRepeatDetailsModel> getRepeatDaily() {
    /// get dailyExpenseRepeatList from BOX based on key number = 0.
    try {
      expenseRepeatModel = _getExpenseDataFromBox().dailyExpense;
    } catch (error) {
      print('from repeatDaily Impl : ${error.toString()}');
      HiveError('RepeatDaily is Empty: ${error.toString()}');
    }
    return expenseRepeatModel;
  }

  @override
  List<ExpenseRepeatDetailsModel> getRepeatWeekly() {
    /// get weeklyExpenseRepeatList from BOX .

    /// Dummy Data that used for Testing.
    expenseRepeatModel = [
      ExpenseRepeatDetailsModel.copyWith(
          lastConfirmationDate: DateTime.now(),
          isLastConfirmed: true,
          creationDate: DateTime.now(),
          expenseModel: ExpenseModel(),
          lastShownDate: DateTime.now(),
          nextShownDate: DateTime.now()),
      ExpenseRepeatDetailsModel.copyWith(
          lastConfirmationDate: DateTime.now(),
          isLastConfirmed: true,
          creationDate: DateTime.now(),
          expenseModel: ExpenseModel(),
          lastShownDate: DateTime.now(),
          nextShownDate: DateTime.now()),
    ];
    try {
      expenseRepeatModel = _getExpenseDataFromBox().weeklyExpense;
    } catch (error) {
      print('from RepeatWeekly Impl : ${error.toString()}');
      HiveError('RepeatWeekly is Empty: ${error.toString()}');
    }
    return expenseRepeatModel;
  }

  @override
  List<ExpenseRepeatDetailsModel> getRepeatMonthly() {
    /// get monthlyExpenseRepeatList from BOX .
    try {
      expenseRepeatModel = _getExpenseDataFromBox().monthlyExpense;
    } catch (error) {
      print('from RepeatMonthly Impl : ${error.toString()}');
      HiveError('RepeatMonthly is Empty: ${error.toString()}');
    }
    return expenseRepeatModel;
  }

  @override
  List<ExpenseRepeatDetailsModel> getRepeatNoRepeat() {
    /// get noRepeatExpenseRepeatList from BOX .
    try {
      expenseRepeatModel = _getExpenseDataFromBox().noRepeatExpense;
    } catch (error) {
      print('from RepeatNoRepeat Impl : ${error.toString()}');
      HiveError('RepeatNoRepeat is Empty : ${error.toString()}');
    }
    return expenseRepeatModel;
  }

  /// box is already opened..now you can handle the data as you can.
  ExpenseRepeatTypes _getExpenseDataFromBox() {
    return _hiveHelper
        .getBox(boxName: AppBoxes.expenseRepeatTypes)
        .values
        .toList()[0];
  }
}
