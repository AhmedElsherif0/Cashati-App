import 'package:hive/hive.dart';
import 'package:temp/business_logic/repository/expense_repeat/expense_repeat_repo.dart';
import 'package:temp/data/local/hive/app_boxes.dart';
import 'package:temp/data/local/hive/hive_database.dart';
import 'package:temp/data/models/expenses/expense_details_model.dart';
import 'package:temp/data/models/expenses/expense_types_model.dart';

import '../../models/expenses/expense_model.dart';

class ExpensesRepeatImpl extends ExpenseRepeatRepo {
  final HiveHelper _hiveHelper = HiveHelper();

  @override
  Future<Box> openExpenseRepeatBox(String boxName) async =>
      await _hiveHelper.openBox(boxName: boxName);

  @override
  List<ExpenseRepeatDetailsModel> getExpenseTypeList(int currentIndex) {
    List<List<ExpenseRepeatDetailsModel>> expenseTypesList = [];
    try {
      expenseTypesList = [
        _getRepeatDaily(),
        _getRepeatWeekly(),
        _getRepeatMonthly(),
        _getRepeatNoRepeat(),
      ];
    } catch (error) {
      print(' ${error.toString()}');
    }
    return expenseTypesList[currentIndex];
  }

  List<ExpenseRepeatDetailsModel> _getRepeatDaily() {
    /// get dailyExpenseRepeatList from BOX based on key number = 0.
    List<ExpenseRepeatDetailsModel> expenseRepeatModel = [];

    try {
       expenseRepeatModel = _getExpenseDataFromBox().dailyExpense;
    } catch (error) {
      print('from repeatDaily Impl : ${error.toString()}');
      HiveError('RepeatDaily is Empty: ${error.toString()}');
    }
    return expenseRepeatModel;
  }

  List<ExpenseRepeatDetailsModel> _getRepeatWeekly() {
    /// get weeklyExpenseRepeatList from BOX .

    List<ExpenseRepeatDetailsModel> expenseRepeatModel = [];
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

  List<ExpenseRepeatDetailsModel> _getRepeatMonthly() {
    /// get monthlyExpenseRepeatList from BOX .
    List<ExpenseRepeatDetailsModel> expenseRepeatModel = [];

    try {
      expenseRepeatModel = _getExpenseDataFromBox().monthlyExpense;
    } catch (error) {
      print('from RepeatMonthly Impl : ${error.toString()}');
      HiveError('RepeatMonthly is Empty: ${error.toString()}');
    }
    return expenseRepeatModel;
  }

  List<ExpenseRepeatDetailsModel> _getRepeatNoRepeat() {
    /// get noRepeatExpenseRepeatList from BOX .
    List<ExpenseRepeatDetailsModel> expenseRepeatModel = [];
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
        .getBox(boxName: AppBoxes.expenseRepeatTypes).getAt(0);
  }
}
