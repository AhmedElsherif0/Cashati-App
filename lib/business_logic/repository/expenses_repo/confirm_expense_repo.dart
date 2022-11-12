// abstract class ConfirmExpenseRepo {
//
//   Future<void> addExpenseToBoxFromRepeatedBox({required ExpenseModel currentExpenseModel, num? newAmount});
//
//
//   List<ExpenseModel> getTodayPayments();
//   bool weeklyShowCheckings(WeeklyExpenseModel weeklyExpenseModel);
//   bool checkSameDay({required DateTime date});
//   bool checkNoConfirmedAndWeekly({required DateTime nextShownDate,required DateTime lastConfirmedDate, required DateTime expensePayment});
//   bool checkNoConfirmedAndMonthly({required DateTime nextShownDate,required DateTime lastConfirmedDate, required DateTime expensePayment});
//
// // when Yes
//   DailyExpenseModel editDailyExpenseLastShown({required ExpenseModel theAddedExpense,required DateTime today});
//   Future saveDailyExpenseAndAddToRepeatBox(DailyExpenseModel theMatchingDailyExpense);
//
//
//
//   Future saveDailyExpenseNoConfirm(DailyExpenseModel theMatchingDailyExpense);
//   Future saveWeeklyExpenseNoConfirm(WeeklyExpenseModel theMatchingWeeklyExpenseModel);
//   Future saveMonthlyExpenseNoConfirm(MonthlyExpenseModel theMatchingMonthlyExpenseModel);
//
//
//
//   WeeklyExpenseModel editWeeklyExpenseLastShown({required ExpenseModel theAddedExpense,required DateTime today});
//   Future saveWeeklyExpenseAndAddToRepeatBox(WeeklyExpenseModel theMatchingWeeklyExpenseModel);
//
//   MonthlyExpenseModel editMonthlyExpenseLastShown({required ExpenseModel theAddedExpense,required DateTime today});
//   Future saveMonthlyExpenseAndAddToRepeatBox(MonthlyExpenseModel theMatchingMonthlyExpenseModel);
//
//
//   NoRepeatExpenseModel editNoRepeatExpenseLastShown({required ExpenseModel theAddedExpense,required DateTime today});
//   Future saveNoRepeatExpenseAndDeleteRepeatBox(NoRepeatExpenseModel theMatchingNoRepExpenseModel);
//   Future deleteNoRepeatExpense(NoRepeatExpenseModel theMatchingNoRepExpenseModel);
//
//
//   Future<void> onYesConfirmed({
//     required String currentRepeatType,
//     required ExpenseModel theAddedExpense});
//
//   Future<void> onNoConfirmed({
//     required String currentRepeatType,
//     required ExpenseModel theAddedExpense});
//
// }