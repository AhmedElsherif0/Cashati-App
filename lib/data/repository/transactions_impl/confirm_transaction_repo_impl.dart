import 'package:hive/hive.dart';
import 'package:temp/constants/app_strings.dart';
import 'package:temp/data/local/hive/app_boxes.dart';
import 'package:temp/data/models/notification/notification_model.dart';
import 'package:temp/data/models/transactions/transaction_details_model.dart';
import 'package:temp/data/models/transactions/transaction_model.dart';
import 'package:temp/data/repository/general_stats_repo_impl/general_stats_repo_impl.dart';
import 'package:temp/data/repository/transactions_impl/mixin_transaction.dart';

import '../../../business_logic/repository/expenses_repo/confirm_expense_repo.dart';
import '../../local/hive/id_generator.dart';

class ConfirmTransactionImpl
    with GeneralStatsRepoImpl, MixinTransaction
    implements ConfirmTransactionRepo {
  List<TransactionModel> todayList = [];

  Future<void> _addTransactionToBoxFromRepeatedBox(
      {required TransactionModel currentExpense, double? newAmount}) async {
    final TransactionModel transaction = currentExpense;
    transaction.amount = newAmount ?? currentExpense.amount;
    transaction.id = GUIDGen.generate();
    transaction.paymentDate = today;
    transaction.createdDate = today;
    Box<TransactionModel> allExpenseModel = Hive.box(AppBoxes.transactionBox);
    try {
      await hiveDatabase
          .putByKey<TransactionModel>(
              indexKey: transaction.id,
              dataModel: transaction,
              boxName: allExpenseModel)
          .then((_) {
        if (transaction.isExpense) {
          super.minusBalance(amount: transaction.amount);
        } else {
          super.plusBalance(amount: transaction.amount);
        }
      });
    } catch (error) {
      print(
          'Error in adding transaction from repeated box to transaction box (confirm) is ${error.toString()}');
    }
  }

  @override
  List<TransactionModel> getTodayPayments({required bool isExpense}) {
    List<TransactionModel> todayList = [];

    todayList.addAll(_getTodayDailyExpenses(isExpense: isExpense));
    todayList.addAll(_getTodayWeeklyExpenses(isExpense: isExpense));
    todayList.addAll(_getTodayMonthlyExpenses(isExpense: isExpense));
    todayList.addAll(_getTodayNoRepeatExpenses(isExpense: isExpense));
    return todayList;
  }

  List<TransactionModel> _getTodayDailyExpenses({required bool isExpense}) {
    List<TransactionModel> todaDailyList = [];

    /// Daily Expenses List.
    List<TransactionRepeatDetailsModel> dailyExpenses =
        getRepTransactionsByRep(repeat: AppStrings.daily, isExpense: isExpense);
    for (var item in dailyExpenses) {
      // here we check confirmation date  Slide number 12
      if (_dailyShowChecking(item)) {
        todaDailyList.add(item.transactionModel);
      }
    }
    return todaDailyList;
  }

  List<TransactionModel> _getTodayWeeklyExpenses({required bool isExpense}) {
    /// Weekly Expenses List.
    List<TransactionModel> todayWeeklyList = [];
    List<TransactionRepeatDetailsModel> weeklyExpenses =
        getRepTransactionsByRep(repeat: AppStrings.weekly, isExpense: isExpense);
    for (var item in weeklyExpenses) {
      // here we check confirmation date  Slide number 12
      if (_weeklyShowChecking(item)) {
        todayWeeklyList.add(item.transactionModel);
      }
    }
    return todayWeeklyList;
  }

  List<TransactionModel> _getTodayMonthlyExpenses({required bool isExpense}) {
    /// Monthly Expenses List.
    // List<TransactionRepeatDetailsModel> monthlyExpenses = expenseRepeatTypes.get(2);
    List<TransactionModel> todayMonthlyList = [];

    List<TransactionRepeatDetailsModel> monthlyExpenses =
        getRepTransactionsByRep(repeat: AppStrings.monthly, isExpense: isExpense);
    for (var item in monthlyExpenses) {
      if (_monthlyShowChecking(item)) todayMonthlyList.add(item.transactionModel);
    }
    return todayMonthlyList;
  }

  List<TransactionModel> _getTodayNoRepeatExpenses({required bool isExpense}) {
    /// NoRepeat Expenses List.
    List<TransactionModel> todayNoRepeatList = [];
    List<TransactionRepeatDetailsModel> noRepeatExpenses =
        getRepTransactionsByRep(repeat: AppStrings.monthly, isExpense: isExpense);
    for (var item in noRepeatExpenses) {
      if (_noRepeatShowChecking(item)) {
        todayNoRepeatList.add(item.transactionModel);
      }
    }
    return todayNoRepeatList;
  }

  /// is it calling from any class less this ??
  bool _checkNoConfirmedAndWeekly(
      {required DateTime nextShownDate,
      required DateTime lastConfirmedDate,
      required DateTime expensePayment}) {
    // for showing the payment weekly if it is not the same expense date day
    if (
        //today.difference(expensePayment).inDays!=0&&
        !checkSameDay(date: expensePayment) &&
            today.difference(nextShownDate).inDays % 7 == 0

            // &&today.difference(lastConfirmedDate).inDays!=0
            &&
            !checkSameDay(date: lastConfirmedDate)) {
      return true;
    } else {
      return false;
    }
  }

  /// is it calling from any class less this ??
  bool _checkNoConfirmedAndMonthly(
      {required DateTime nextShownDate,
      required DateTime lastConfirmedDate,
      required DateTime expensePayment}) {
    // for showing the payment weekly if he didn't take action
    if (
        //today.difference(expensePayment).inDays!=0&&
        !checkSameDay(date: expensePayment) &&
            today.difference(nextShownDate).inDays % 30 == 0
            //&&today.difference(lastConfirmedDate).inDays!=0
            &&
            !checkSameDay(date: lastConfirmedDate)

        // &&expensePayment.isAfter(today)
        ) {
      return true;
    } else {
      return false;
    }
  }

  bool _dailyShowChecking(TransactionRepeatDetailsModel dailyTransaction) {
    if (!checkSameDay(date: dailyTransaction.lastConfirmationDate)) {
      return true;
    } else {
      return false;
    }
  }

  bool _weeklyShowChecking(TransactionRepeatDetailsModel weeklyTransaction) {
    if (checkSameDay(date: weeklyTransaction.nextShownDate) &&
            !checkSameDay(date: weeklyTransaction.lastConfirmationDate) ||
        _checkNoConfirmedAndWeekly(
            nextShownDate: weeklyTransaction.nextShownDate,
            lastConfirmedDate: weeklyTransaction.lastConfirmationDate,
            expensePayment: weeklyTransaction.transactionModel.paymentDate)) {
      return true;
    } else {
      return false;
    }
  }

  bool _monthlyShowChecking(TransactionRepeatDetailsModel monthlyTransaction) {
    if (checkSameDay(date: monthlyTransaction.nextShownDate) &&
            !checkSameDay(date: monthlyTransaction.lastConfirmationDate) ||
        _checkNoConfirmedAndMonthly(
            nextShownDate: monthlyTransaction.nextShownDate,
            lastConfirmedDate: monthlyTransaction.lastConfirmationDate,
            expensePayment: monthlyTransaction.transactionModel.paymentDate)) {
      return true;
    } else {
      return false;
    }
  }

  bool _noRepeatShowChecking(TransactionRepeatDetailsModel noRepTransaction) {
    if (checkSameDay(date: noRepTransaction.nextShownDate) &&
        !checkSameDay(date: noRepTransaction.lastConfirmationDate)) {
      return true;
    } else {
      return false;
    }
  }

// when Yes

  Future _saveDailyExpenseNoConfirm(
      TransactionRepeatDetailsModel theMatchingDailyExpense) async {
    await theMatchingDailyExpense.save();
  }

  Future _saveWeeklyExpenseNoConfirm(
      TransactionRepeatDetailsModel theMatchingWeeklyExpenseModel) async {
    await theMatchingWeeklyExpenseModel.save();
  }

  Future _saveMonthlyExpenseNoConfirm(
      TransactionRepeatDetailsModel theMatchingMonthlyExpenseModel) async {
    await theMatchingMonthlyExpenseModel.save();
  }

  Future<void> _saveDailyExpenseAndAddToRepeatBox(
      TransactionRepeatDetailsModel theMatchingDailyExpense) async {
    await theMatchingDailyExpense.save();
    await _addTransactionToBoxFromRepeatedBox(
        currentExpense: theMatchingDailyExpense.transactionModel);
  }

  Future _saveWeeklyExpenseAndAddToRepeatBox(
      TransactionRepeatDetailsModel theMatchingWeeklyExpenseModel) async {
    await theMatchingWeeklyExpenseModel.save();
    await _addTransactionToBoxFromRepeatedBox(
        currentExpense: theMatchingWeeklyExpenseModel.transactionModel);
  }

  Future _saveMonthlyExpenseAndAddToRepeatBox(
      TransactionRepeatDetailsModel theMatchingMonthlyExpenseModel) async {
    await theMatchingMonthlyExpenseModel.save();
    await _addTransactionToBoxFromRepeatedBox(
        currentExpense: theMatchingMonthlyExpenseModel.transactionModel);
  }

  Future _saveNoRepeatExpenseAndDeleteRepeatBox(
      TransactionRepeatDetailsModel theMatchingNoRepExpenseModel) async {
    await _addTransactionToBoxFromRepeatedBox(
        currentExpense: theMatchingNoRepExpenseModel.transactionModel);
    theMatchingNoRepExpenseModel.delete();
  }

  TransactionRepeatDetailsModel _editDailyExpenseLastShown(
      {required TransactionModel addedExpense, required DateTime today}) {
    //TODO check if there is any difference between getting key and loop in ids
    /// this transaction model is fetched from the repeated model So its key is always the same one
    /// with its repeated model as both have same key and id (when adding transaction at first time)
    TransactionRepeatDetailsModel theMatchingDailyExpense =
        Hive.box<TransactionRepeatDetailsModel>(AppBoxes.dailyTransactionsBoxName)
            .get(addedExpense.id)!;
    print('Before Edit Daily ${theMatchingDailyExpense.lastConfirmationDate}');
    theMatchingDailyExpense.isLastConfirmed =
        isEqualToday(date: addedExpense.paymentDate);
    theMatchingDailyExpense.lastConfirmationDate = today;
    theMatchingDailyExpense.nextShownDate = today.add(const Duration(days: 1));
    theMatchingDailyExpense.lastShownDate = today;
    return theMatchingDailyExpense;
  }

  TransactionRepeatDetailsModel _editWeeklyExpenseLastShown(
      {required TransactionModel addedExpense, required DateTime today}) {
    TransactionRepeatDetailsModel theMatchingWeeklyExpenseModel =
        Hive.box<TransactionRepeatDetailsModel>(AppBoxes.weeklyTransactionsBoxName)
            .get(addedExpense.id)!;

    // Hive.box<TransactionRepeatDetailsModel>('ExpenseRepeatDetailsModel')
    //     .values
    //     .where((element) => element.transactionModel.id == addedExpense.id)
    //     .single;

    // the right last confirmation date is below
    theMatchingWeeklyExpenseModel.isLastConfirmed =
        isEqualToday(date: addedExpense.paymentDate);

    theMatchingWeeklyExpenseModel.lastConfirmationDate = today;
    theMatchingWeeklyExpenseModel.nextShownDate = today.add(const Duration(days: 7));
    theMatchingWeeklyExpenseModel.lastShownDate = today;
    return theMatchingWeeklyExpenseModel;
  }

  TransactionRepeatDetailsModel _editMonthlyExpenseLastShown(
      {required TransactionModel addedExpense, required DateTime today}) {
    TransactionRepeatDetailsModel theMatchingMonthlyExpenseModel =
        Hive.box<TransactionRepeatDetailsModel>(AppBoxes.monthlyTransactionsBoxName)
            .get(addedExpense.id)!;

    // Hive.box<TransactionRepeatDetailsModel>('ExpenseRepeatDetailsModel')
    //     .values
    //     .where((element) => element.transactionModel.id == addedExpense.id)
    //     .single;
    theMatchingMonthlyExpenseModel.isLastConfirmed =
        isEqualToday(date: addedExpense.paymentDate);

    theMatchingMonthlyExpenseModel.lastConfirmationDate = today;
    theMatchingMonthlyExpenseModel.nextShownDate = today.add(const Duration(days: 30));
    theMatchingMonthlyExpenseModel.lastShownDate = today;
    return theMatchingMonthlyExpenseModel;
  }

  TransactionRepeatDetailsModel _editNoRepeatExpenseLastShown(
      {required TransactionModel addedExpense, required DateTime today}) {
    TransactionRepeatDetailsModel theMatchingNoRepExpenseModel =
        Hive.box<TransactionRepeatDetailsModel>(AppBoxes.noRepeaTransactionsBoxName)
            .get(addedExpense.id)!;

    // Hive.box<TransactionRepeatDetailsModel>(AppBoxes.noRepeaTransactionsBoxName)
    //     .values
    //     .where((element) => element.transactionModel.id == addedExpense.id)
    //     .single;
    theMatchingNoRepExpenseModel.isLastConfirmed =
        isEqualToday(date: addedExpense.paymentDate);
    theMatchingNoRepExpenseModel.lastConfirmationDate = today;
    theMatchingNoRepExpenseModel.lastShownDate = today;
    theMatchingNoRepExpenseModel.nextShownDate = today;
    return theMatchingNoRepExpenseModel;
  }

  @override
  Future deleteNoRepeatTransaction(
      TransactionRepeatDetailsModel theMatchingNoRepExpenseModel) async {
    await theMatchingNoRepExpenseModel.delete();
  }

  @override
  Future<void> onYesConfirmed({required TransactionModel addedExpense}) async {
    print('working yes ..');
    try {
      if (addedExpense.repeatType == 'Daily') {
        TransactionRepeatDetailsModel theEditedDailyExpense =
            _editDailyExpenseLastShown(addedExpense: addedExpense, today: today);
        await _saveDailyExpenseAndAddToRepeatBox(theEditedDailyExpense);
        // print('After Edit Daily ${theMatchingDailyExpense.lastConfirmationDate}');
      }
      if (addedExpense.repeatType == 'Weekly') {
        TransactionRepeatDetailsModel theEditedWeeklyExpense =
            _editWeeklyExpenseLastShown(addedExpense: addedExpense, today: today);
        await _saveWeeklyExpenseAndAddToRepeatBox(theEditedWeeklyExpense);
      }
      if (addedExpense.repeatType == 'Monthly') {
        TransactionRepeatDetailsModel theEditedMonthlyExpense =
            _editMonthlyExpenseLastShown(addedExpense: addedExpense, today: today);
        _saveMonthlyExpenseAndAddToRepeatBox(theEditedMonthlyExpense);
      }
      if (addedExpense.repeatType == 'No Repeat') {
        TransactionRepeatDetailsModel theEditedNoRepeatedExpense =
            _editNoRepeatExpenseLastShown(addedExpense: addedExpense, today: today);
        await _saveNoRepeatExpenseAndDeleteRepeatBox(theEditedNoRepeatedExpense);
      }
    } catch (error) {
      print('error on yes is $error');
    }
  }

  @override
  Future<void> onNoConfirmed({required TransactionModel addedExpense}) async {
    if (addedExpense.repeatType == 'Daily') {
      TransactionRepeatDetailsModel theEditedDailyExpense =
          _editDailyExpenseLastShown(addedExpense: addedExpense, today: today);
      await _saveDailyExpenseNoConfirm(theEditedDailyExpense);
    }
    if (addedExpense.repeatType == 'Weekly') {
      TransactionRepeatDetailsModel theMatchingWeeklyExpenseModel =
          _editWeeklyExpenseLastShown(addedExpense: addedExpense, today: today);
      await _saveWeeklyExpenseNoConfirm(theMatchingWeeklyExpenseModel);
    }
    if (addedExpense.repeatType == 'Monthly') {
      TransactionRepeatDetailsModel theEditedMonthlyExpense =
          _editMonthlyExpenseLastShown(addedExpense: addedExpense, today: today);
      await _saveMonthlyExpenseNoConfirm(theEditedMonthlyExpense);
    }
    if (addedExpense.repeatType == 'No Repeat') {
      TransactionRepeatDetailsModel theEditedNoRepeatExpense =
          _editNoRepeatExpenseLastShown(addedExpense: addedExpense, today: today);
      await deleteNoRepeatTransaction(theEditedNoRepeatExpense);
    }
  }

  @override
  Future<void> onYesConfirmedFromNotifications(
      {required NotificationModel notificationModel}) async {
    print('working yes ..');
    try {
      TransactionModel theMatchingExpense = Hive.box<TransactionRepeatDetailsModel>(
              getBoxNameAccordingToRepeat(repeatType: notificationModel.payLoad!))
          .get(notificationModel.id)!
          .transactionModel;
      theMatchingExpense.id = GUIDGen.generate();
      theMatchingExpense.amount = notificationModel.amount;
      theMatchingExpense.paymentDate = notificationModel.checkedDate;
      theMatchingExpense.createdDate = notificationModel.checkedDate;
      final box = Hive.box<TransactionModel>(AppBoxes.transactionBox);

      await box.put(theMatchingExpense.id, theMatchingExpense).whenComplete(() async {
        switch (notificationModel.typeName) {
          case "Expense":
            await minusBalance(amount: notificationModel.amount);
            print("Minus balance Notification Confirm Expense");
            break;
          case "Income":
            print("Plus balance Notification Confirm Expense");
            await plusBalance(amount: notificationModel.amount);
        }
      });
    } catch (error) {
      print('error on yes is $error');
    }
  }

  @override
  Future<void> onNoConfirmedFromNotifications(
      {required NotificationModel notificationModel}) async {
    // TODO: implement onNoConfirmedFromNotifications
    throw UnimplementedError();
  }

  @override
  Future<void> deleteTransactionPermanently(TransactionModel transactionModel) async {
    await deleteTransactionRepeatedModelByTransactionId(transactionModel);
  }
}
