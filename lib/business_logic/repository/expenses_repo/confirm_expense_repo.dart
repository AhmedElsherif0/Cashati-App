import '../../../data/models/expenses/expense_details_model.dart';
import '../../../data/models/expenses/expense_model.dart';

abstract class ConfirmExpenseRepo {
  Future<void> addExpenseToBoxFromRepeatedBox(
      {required ExpenseModel currentExpense, num? newAmount});

  List<ExpenseModel> getTodayPayments();

  bool weeklyShowChecking(ExpenseRepeatDetailsModel weeklyExpense);

  bool checkSameDay({required DateTime date});

  bool checkNoConfirmedAndWeekly(
      {required DateTime nextShownDate,
      required DateTime lastConfirmedDate,
      required DateTime expensePayment});

  bool checkNoConfirmedAndMonthly(
      {required DateTime nextShownDate,
      required DateTime lastConfirmedDate,
      required DateTime expensePayment});

// when Yes
  ExpenseRepeatDetailsModel editDailyExpenseLastShown(
      {required ExpenseModel addedExpense, required DateTime today});

  Future saveDailyExpenseAndAddToRepeatBox(
      ExpenseRepeatDetailsModel theMatchingDailyExpense);

  Future saveDailyExpenseNoConfirm(
      ExpenseRepeatDetailsModel theMatchingDailyExpense);

  Future saveWeeklyExpenseNoConfirm(
      ExpenseRepeatDetailsModel theMatchingWeeklyExpenseModel);

  Future saveMonthlyExpenseNoConfirm(
      ExpenseRepeatDetailsModel theMatchingMonthlyExpenseModel);

  ExpenseRepeatDetailsModel editWeeklyExpenseLastShown(
      {required ExpenseModel addedExpense, required DateTime today});

  Future saveWeeklyExpenseAndAddToRepeatBox(
      ExpenseRepeatDetailsModel theMatchingWeeklyExpenseModel);

  ExpenseRepeatDetailsModel editMonthlyExpenseLastShown(
      {required ExpenseModel addedExpense, required DateTime today});

  Future saveMonthlyExpenseAndAddToRepeatBox(
      ExpenseRepeatDetailsModel theMatchingMonthlyExpenseModel);

  ExpenseRepeatDetailsModel editNoRepeatExpenseLastShown(
      {required ExpenseModel addedExpense, required DateTime today});

  Future saveNoRepeatExpenseAndDeleteRepeatBox(
      ExpenseRepeatDetailsModel theMatchingNoRepExpenseModel);

  Future deleteNoRepeatExpense(
      ExpenseRepeatDetailsModel theMatchingNoRepExpenseModel);

  Future<void> onYesConfirmed(
      {required String currentRepeatType, required ExpenseModel addedExpense});

  Future<void> onNoConfirmed(
      {required String currentRepeatType, required ExpenseModel addedExpense});
}
