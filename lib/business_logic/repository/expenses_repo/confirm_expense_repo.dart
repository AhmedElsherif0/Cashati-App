import 'package:temp/data/models/transactions/transaction_model.dart';
import '../../../data/models/transactions/transaction_details_model.dart';

abstract class ConfirmExpenseRepo {


  List<TransactionModel> getTodayPayments({required bool isExpense});
  // Future<void> addExpenseToBoxFromRepeatedBox(
  //     {required TransactionModel currentExpense, num? newAmount});

//   bool weeklyShowChecking(TransactionRepeatDetailsModel weeklyExpense);
//
//
//   bool checkNoConfirmedAndWeekly(
//       {required DateTime nextShownDate,
//       required DateTime lastConfirmedDate,
//       required DateTime expensePayment});
//
//   bool checkNoConfirmedAndMonthly(
//       {required DateTime nextShownDate,
//       required DateTime lastConfirmedDate,
//       required DateTime expensePayment});
//
// // when Yes
//   TransactionRepeatDetailsModel editDailyExpenseLastShown(
//       {required TransactionModel addedExpense, required DateTime today});
//
//   Future saveDailyExpenseAndAddToRepeatBox(
//       TransactionRepeatDetailsModel theMatchingDailyExpense);
//
//   Future saveDailyExpenseNoConfirm(
//       TransactionRepeatDetailsModel theMatchingDailyExpense);
//
//   Future saveWeeklyExpenseNoConfirm(
//       TransactionRepeatDetailsModel theMatchingWeeklyExpenseModel);
//
//   Future saveMonthlyExpenseNoConfirm(
//       TransactionRepeatDetailsModel theMatchingMonthlyExpenseModel);
//
//   TransactionRepeatDetailsModel editWeeklyExpenseLastShown(
//       {required TransactionModel addedExpense, required DateTime today});
//
//   Future saveWeeklyExpenseAndAddToRepeatBox(
//       TransactionRepeatDetailsModel theMatchingWeeklyExpenseModel);
//
//   TransactionRepeatDetailsModel editMonthlyExpenseLastShown(
//       {required TransactionModel addedExpense, required DateTime today});
//
//   Future saveMonthlyExpenseAndAddToRepeatBox(
//       TransactionRepeatDetailsModel theMatchingMonthlyExpenseModel);
//
//   TransactionRepeatDetailsModel editNoRepeatExpenseLastShown(
//       {required TransactionModel addedExpense, required DateTime today});
//
//   Future saveNoRepeatExpenseAndDeleteRepeatBox(
//       TransactionRepeatDetailsModel theMatchingNoRepExpenseModel);

  Future deleteNoRepeatExpense(
      TransactionRepeatDetailsModel theMatchingNoRepExpenseModel);

  Future<void> onYesConfirmed(
      { required TransactionModel addedExpense});

  Future<void> onNoConfirmed(
      { required TransactionModel addedExpense});
}
