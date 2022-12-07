import 'package:temp/data/models/transactions/transaction_details_model.dart';
import 'package:temp/data/models/transactions/transaction_model.dart';

abstract class ConfirmIncomeRepo {
  Future<void> addIncomeToBoxFromRepeatedBox(
      {required TransactionModel currentIncomeModel, num? newAmount});

  List<TransactionModel> getTodayPayments();

  bool checkSameDay({required DateTime date});

  bool checkNoConfirmedAndWeekly(
      {required DateTime nextShownDate,
      required DateTime lastConfirmedDate,
      required DateTime incomePayment});

  bool checkNoConfirmedAndMonthly(
      {required DateTime nextShownDate,
      required DateTime lastConfirmedDate,
      required DateTime incomePayment});

// when Yes
  TransactionRepeatDetailsModel editDailyIncomeLastShown(
      {required TransactionRepeatDetailsModel theAddedIncome,
      required DateTime today});

  Future saveDailyIncomeAndAddToRepeatBox(
      TransactionModel theMatchingDailyIncome);

  Future saveDailyIncomeNoConfirm(
      TransactionRepeatDetailsModel theMatchingDailyIncome);

  Future saveWeeklyIncomeNoConfirm(
      TransactionModel theMatchingWeeklyIncomeModel);

  Future saveMonthlyIncomeNoConfirm(
      TransactionModel theMatchingMonthlyIncomeModel);

  TransactionModel editWeeklyIncomeLastShown(
      {required TransactionModel theAddedIncome, required DateTime today});

  Future saveWeeklyIncomeAndAddToRepeatBox(
      TransactionModel theMatchingWeeklyIncomeModel);

  TransactionModel editMonthlyIncomeLastShown(
      {required TransactionModel theAddedIncome, required DateTime today});

  Future saveMonthlyIncomeAndAddToRepeatBox(
      TransactionModel theMatchingMonthlyIncomeModel);

  TransactionModel editNoRepeatIncomeLastShown(
      {required TransactionModel theAddedIncome, required DateTime today});

  Future saveNoRepeatIncomeAndDeleteRepeatBox(
      TransactionModel theMatchingNoRepIncomeModel);

  Future deleteNoRepeatIncome(TransactionModel theMatchingNoRepIncomeModel);

  Future<void> onYesConfirmed(
      {String? currentRepeatType, required TransactionModel theAddedIncome});

  Future<void> onNoConfirmed(
      {String? currentRepeatType, required TransactionModel theAddedIncome});
}
