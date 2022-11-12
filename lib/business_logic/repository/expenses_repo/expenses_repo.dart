// abstract class ExpensesRepository {
//   Future<void> addExpenseToExpensesBox({
//     required String expenseName,
//     required num expenseAmount,
//     required String expenseMainCateg,
//     required String expenseSubCateg,
//     required String expenseComment,
//     required String expenseRepeat,
//     required bool expensePriority,
//     required bool isExpensePaid,
//     required DateTime expensePaymentDate,
//     required DateTime expenseCreatedDate,
//   });
//   Future<void> addToRepeatedBoxes(String repeat,ExpenseModel expenseModel);
//   DateTime putNextShownDate({required DateTime expensePaymentDate,required String repeatType});
//   bool isEqualToday({required DateTime date});
//   Future addDailyExpenseToRepeatedBox(ExpenseModel expenseModel);
//   Future addWeeklyExpenseToRepeatedBox(ExpenseModel expenseModel);
//   Future addMonthlyExpenseToRepeatedBox(ExpenseModel expenseModel);
//   Future addNoRepeatExpenseToRepeatedBox(ExpenseModel expenseModel);
//   bool checkSameDay({required DateTime date});
//
// }