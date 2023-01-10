import 'package:hive/hive.dart';
import 'package:temp/data/local/hive/app_boxes.dart';
import 'package:temp/data/models/transactions/transaction_details_model.dart';
import 'package:temp/data/models/transactions/transaction_model.dart';
import 'package:temp/data/repository/transactions_impl/mixin_transaction.dart';
import '../../../business_logic/repository/expenses_repo/confirm_expense_repo.dart';
import '../../local/hive/id_generator.dart';

class ConfirmExpenseImpl with MixinTransaction implements ConfirmExpenseRepo {
  List<TransactionModel> todayList = [];

  @override
  Future<void> addExpenseToBoxFromRepeatedBox(
      {required TransactionModel currentExpense, num? newAmount}) async {
    final TransactionModel expenseModel = currentExpense;
    expenseModel.amount = newAmount ?? currentExpense.amount;
    expenseModel.id = GUIDGen.generate();
    expenseModel.paymentDate = today;
    expenseModel.createdDate = today;

    final allExpensesModel =
        hiveDatabase.getBoxName(boxName: AppBoxes.dailyTransactionsBoxName);

    await allExpensesModel.add(expenseModel);

    print('Expenses values are ${allExpensesModel.values}');
  }

  /// is it calling from any class less this ??
  @override
  bool checkNoConfirmedAndWeekly(
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
            !checkSameDay(date: lastConfirmedDate))  {
      return true;
    } else {
      return false;
    }
  }

  /// is it calling from any class less this ??
  @override
  bool checkNoConfirmedAndMonthly(
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

  @override
  List<TransactionModel> getTodayPayments() {
    Box expenseRepeatTypes = hiveDatabase.getBoxName(boxName: AppBoxes.dailyTransactionsBoxName);
    _getTodayDailyExpenses(todayList, expenseRepeatTypes);
    _getTodayWeeklyExpenses(todayList, expenseRepeatTypes);
    _getTodayMonthlyExpenses(todayList, expenseRepeatTypes);
    _getTodayNoRepeatExpenses(todayList, expenseRepeatTypes);
    return todayList;
  }

  List<TransactionModel> _getTodayDailyExpenses(
      List<TransactionModel> todayList, Box expenseRepeatTypes) {
    /// Daily Expenses List.
    List<TransactionRepeatDetailsModel> dailyExpenses = expenseRepeatTypes.get(0);
    for (var item in dailyExpenses) {
      // here we check confirmation date  Slide number 12
      if (!checkSameDay(date: item.lastConfirmationDate)) {
        todayList.add(item.transactionModel);
      }
    }
    return todayList;
  }

  List<TransactionModel> _getTodayWeeklyExpenses(
      List<TransactionModel> todayList, Box expenseRepeatTypes) {
    /// Weekly Expenses List.
    List<TransactionRepeatDetailsModel> weeklyExpenses = expenseRepeatTypes.get(1);
    for (var item in weeklyExpenses) {
      // here we check confirmation date  Slide number 12
      if (!checkSameDay(date: item.lastConfirmationDate)) {
        todayList.add(item.transactionModel);
      }
    }
    return todayList;
  }

  List<TransactionModel> _getTodayMonthlyExpenses(
      List<TransactionModel> todayList, Box expenseRepeatTypes) {
    /// Monthly Expenses List.
    List<TransactionRepeatDetailsModel> monthlyExpenses = expenseRepeatTypes.get(2);
    for (var item in monthlyExpenses) {
      if (checkSameDay(date: item.nextShownDate) &&
              !checkSameDay(date: item.lastConfirmationDate) ||
          checkNoConfirmedAndMonthly(
              nextShownDate: item.nextShownDate,
              lastConfirmedDate: item.lastConfirmationDate,
              expensePayment: item.transactionModel.paymentDate)) {
        todayList.add(item.transactionModel);
      }
    }
    return todayList;
  }

  List<TransactionModel> _getTodayNoRepeatExpenses(
      List<TransactionModel> todayList, Box expenseRepeatTypes) {
    /// NoRepeat Expenses List.
    List<TransactionRepeatDetailsModel> noRepeatExpenses = expenseRepeatTypes.get(3);
    for (var item in noRepeatExpenses) {
      if (checkSameDay(date: item.nextShownDate) &&
          !checkSameDay(date: item.lastConfirmationDate)) {
        todayList.add(item.transactionModel);
      }
    }
    return todayList;
  }

  @override
  bool weeklyShowChecking(TransactionRepeatDetailsModel weeklyExpense) {
    if (checkSameDay(date: weeklyExpense.nextShownDate) &&
            !checkSameDay(date: weeklyExpense.lastConfirmationDate) ||
        checkNoConfirmedAndWeekly(
            nextShownDate: weeklyExpense.nextShownDate,
            lastConfirmedDate: weeklyExpense.lastConfirmationDate,
            expensePayment: weeklyExpense.transactionModel.paymentDate )) {
      return true;
    } else {
      return false;
    }
  }

// when Yes

  @override
  TransactionRepeatDetailsModel editDailyExpenseLastShown(
      {required TransactionModel addedExpense, required DateTime today}) {
    TransactionRepeatDetailsModel theMatchingDailyExpense =
        Hive.box<TransactionRepeatDetailsModel>('ExpenseRepeatDetailsModel')
            .values
            .where((element) => element.transactionModel.id == addedExpense.id)
            .single;
    print('Before Edit Daily ${theMatchingDailyExpense.lastConfirmationDate}');
    theMatchingDailyExpense.lastConfirmationDate = today;
    theMatchingDailyExpense.nextShownDate = today.add(const Duration(days: 1));
    theMatchingDailyExpense.lastShownDate = today;
    return theMatchingDailyExpense;
  }

  @override
  Future<void> saveDailyExpenseAndAddToRepeatBox(
      TransactionRepeatDetailsModel theMatchingDailyExpense) async {
    await theMatchingDailyExpense.save();
    await addExpenseToBoxFromRepeatedBox(
        currentExpense: theMatchingDailyExpense.transactionModel);
  }

  @override
  Future saveDailyExpenseNoConfirm(
      TransactionRepeatDetailsModel theMatchingDailyExpense) async {
    await theMatchingDailyExpense.save();
  }

  @override
  Future saveWeeklyExpenseNoConfirm(
      TransactionRepeatDetailsModel theMatchingWeeklyExpenseModel) async {
    await theMatchingWeeklyExpenseModel.save();
  }

  @override
  Future saveMonthlyExpenseNoConfirm(
      TransactionRepeatDetailsModel theMatchingMonthlyExpenseModel) async {
    await theMatchingMonthlyExpenseModel.save();
  }

  @override
  TransactionRepeatDetailsModel editWeeklyExpenseLastShown(
      {required TransactionModel addedExpense, required DateTime today}) {
    TransactionRepeatDetailsModel theMatchingWeeklyExpenseModel =
        Hive.box<TransactionRepeatDetailsModel>('ExpenseRepeatDetailsModel')
            .values
            .where((element) => element.transactionModel.id == addedExpense.id)
            .single;

    // the right last confirmation date is below
    theMatchingWeeklyExpenseModel.lastConfirmationDate = today;
    theMatchingWeeklyExpenseModel.nextShownDate =
        today.add(const Duration(days: 7));
    theMatchingWeeklyExpenseModel.lastShownDate = today;
    return theMatchingWeeklyExpenseModel;
  }

  @override
  Future saveWeeklyExpenseAndAddToRepeatBox(
      TransactionRepeatDetailsModel theMatchingWeeklyExpenseModel) async {
    await theMatchingWeeklyExpenseModel.save();
    await addExpenseToBoxFromRepeatedBox(
        currentExpense: theMatchingWeeklyExpenseModel.transactionModel);
  }

  @override
  TransactionRepeatDetailsModel editMonthlyExpenseLastShown(
      {required TransactionModel addedExpense, required DateTime today}) {
    TransactionRepeatDetailsModel theMatchingMonthlyExpenseModel =
        Hive.box<TransactionRepeatDetailsModel>('ExpenseRepeatDetailsModel')
            .values
            .where((element) => element.transactionModel.id == addedExpense.id)
            .single;

    theMatchingMonthlyExpenseModel.lastConfirmationDate = today;
    theMatchingMonthlyExpenseModel.nextShownDate =
        today.add(const Duration(days: 30));
    theMatchingMonthlyExpenseModel.lastShownDate = today;
    return theMatchingMonthlyExpenseModel;
  }

  @override
  TransactionRepeatDetailsModel editNoRepeatExpenseLastShown(
      {required TransactionModel addedExpense, required DateTime today}) {
    TransactionRepeatDetailsModel theMatchingNoRepExpenseModel =
        Hive.box<TransactionRepeatDetailsModel>('ExpenseRepeatDetailsModel')
            .values
            .where((element) => element.transactionModel.id == addedExpense.id)
            .single;
    theMatchingNoRepExpenseModel.lastConfirmationDate = today;
    theMatchingNoRepExpenseModel.lastShownDate = today;
    theMatchingNoRepExpenseModel.nextShownDate = today;
    return theMatchingNoRepExpenseModel;
  }

  @override
  Future saveMonthlyExpenseAndAddToRepeatBox(
      TransactionRepeatDetailsModel theMatchingMonthlyExpenseModel) async {
    await theMatchingMonthlyExpenseModel.save();
    await addExpenseToBoxFromRepeatedBox(
        currentExpense: theMatchingMonthlyExpenseModel.transactionModel);
  }

  @override
  Future saveNoRepeatExpenseAndDeleteRepeatBox(
      TransactionRepeatDetailsModel theMatchingNoRepExpenseModel) async {
    await addExpenseToBoxFromRepeatedBox(
            currentExpense: theMatchingNoRepExpenseModel.transactionModel);
          theMatchingNoRepExpenseModel.delete();
  }

  @override
  Future deleteNoRepeatExpense(
      TransactionRepeatDetailsModel theMatchingNoRepExpenseModel) async {
    await theMatchingNoRepExpenseModel.delete();
  }

  @override
  Future<void> onYesConfirmed(
      {required String currentRepeatType,
      required TransactionModel addedExpense}) async {
    print('working yes ..');
    try {
      if (currentRepeatType == 'Daily') {
        TransactionRepeatDetailsModel theEditedDailyExpense = editDailyExpenseLastShown(
            addedExpense: addedExpense, today: today);
        await saveDailyExpenseAndAddToRepeatBox(theEditedDailyExpense);
        // print('After Edit Daily ${theMatchingDailyExpense.lastConfirmationDate}');

      }
      if (currentRepeatType == 'Weekly') {
        TransactionRepeatDetailsModel theEditedWeeklyExpense = editWeeklyExpenseLastShown(
            addedExpense: addedExpense, today: today);
        await saveWeeklyExpenseAndAddToRepeatBox(theEditedWeeklyExpense);
      }
      if (currentRepeatType == 'Monthly') {
        TransactionRepeatDetailsModel theEditedMonthlyExpense =
            editMonthlyExpenseLastShown(
                addedExpense: addedExpense, today: today);
        saveMonthlyExpenseAndAddToRepeatBox(theEditedMonthlyExpense);
      }
      if (currentRepeatType == 'No Repeat') {
        TransactionRepeatDetailsModel theEditedNoRepeatedExpense =
            editNoRepeatExpenseLastShown(
                addedExpense: addedExpense, today: today);
        await saveNoRepeatExpenseAndDeleteRepeatBox(theEditedNoRepeatedExpense);
      }
    } catch (error) {
      print('error on yes is $error');
    }
  }

  @override
  Future<void> onNoConfirmed(
      {required String currentRepeatType,
      required TransactionModel addedExpense}) async {
    if (currentRepeatType == 'Daily') {
      TransactionRepeatDetailsModel theEditedDailyExpense = editDailyExpenseLastShown(
          addedExpense: addedExpense, today: today);
      await saveDailyExpenseNoConfirm(theEditedDailyExpense);
    }
    if (currentRepeatType == 'Weekly') {
      TransactionRepeatDetailsModel theMatchingWeeklyExpenseModel =
          editWeeklyExpenseLastShown(
              addedExpense: addedExpense, today: today);
      await saveWeeklyExpenseNoConfirm(theMatchingWeeklyExpenseModel);
    }
    if (currentRepeatType == 'Monthly') {
      TransactionRepeatDetailsModel theEditedMonthlyExpense = editMonthlyExpenseLastShown(
          addedExpense: addedExpense, today: today);
      await saveMonthlyExpenseNoConfirm(theEditedMonthlyExpense);
    }
    if (currentRepeatType == 'No Repeat') {
      TransactionRepeatDetailsModel theEditedNoRepeatExpense =
          editNoRepeatExpenseLastShown(
              addedExpense: addedExpense, today: today);
      await deleteNoRepeatExpense(theEditedNoRepeatExpense);
    }
  }
}

