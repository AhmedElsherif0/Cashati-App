import 'package:hive/hive.dart';
import 'package:temp/business_logic/repository/expense_repeat/expense_repeat_repo.dart';
import 'package:temp/data/local/hive/app_boxes.dart';
import 'package:temp/data/local/hive/hive_database.dart';
import 'package:temp/data/models/expenses/expense_details_model.dart';
import 'package:temp/data/models/expenses/expense_types_model.dart';

class ExpensesRepeatImpl extends ExpenseRepeatRepo {
  final HiveHelper _hiveHelper = HiveHelper();
  List<ExpenseRepeatDetailsModel> expenseRepeatModel = [];

  @override
  Future<Box> openExpenseRepeatBox() async =>
      await _hiveHelper.openBox(boxName: AppBoxes.expenseRepeatTypes);

  @override
  List<ExpenseRepeatDetailsModel> getRepeatDaily() {
    /// get dailyExpenseRepeatList from BOX based on key number = 0.
    expenseRepeatModel = _getExpenseDataFromBox(0).dailyExpense;
    if (expenseRepeatModel.isEmpty) {
      HiveError('RepeatDaily is Empty');
    }
    return expenseRepeatModel;
  }

  @override
  List<ExpenseRepeatDetailsModel> getRepeatWeekly(int index) {
    /// get dailyExpenseRepeatList from BOX based on key number = 1.
    expenseRepeatModel = _getExpenseDataFromBox(1).weeklyExpense;
    return expenseRepeatModel;
  }

  @override
  List<ExpenseRepeatDetailsModel> getRepeatMonthly(int index) {
    /// get dailyExpenseRepeatList from BOX based on key number = 2.
    expenseRepeatModel = _getExpenseDataFromBox(2).monthlyExpense;
    return expenseRepeatModel;
  }

  @override
  List<ExpenseRepeatDetailsModel> getRepeatNoRepeat(int index) {
    /// get dailyExpenseRepeatList from BOX based on key number = 3.
    expenseRepeatModel = _getExpenseDataFromBox(3).noRepeatExpense;
    return expenseRepeatModel;
  }

  /// box is already opened..now you can handle the data as you can.

  ExpenseRepeatTypes _getExpenseDataFromBox(int index) {
    return _hiveHelper
        .getBox(boxName: AppBoxes.expenseRepeatTypes)
        .values
        .toList()
        .cast<ExpenseRepeatTypes>()[index];
  }
}
