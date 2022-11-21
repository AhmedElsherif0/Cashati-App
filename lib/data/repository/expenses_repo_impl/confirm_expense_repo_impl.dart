import 'package:hive/hive.dart';
import 'package:temp/data/local/hive/app_boxes.dart';
import 'package:temp/data/local/hive/hive_database.dart';
import '../../../business_logic/repository/expenses_repo/confirm_expense_repo.dart';
import '../../local/hive/id_generator.dart';
import '../../models/expenses/expense_details_model.dart';
import '../../models/expenses/expense_model.dart';

class ConfirmExpenseImpl implements ConfirmExpenseRepo {
  final HiveHelper _hiveDatabase = HiveHelper();
  List<ExpenseModel> todayList = [];
  final DateTime today = DateTime.now();

  @override
  Future<void> addExpenseToBoxFromRepeatedBox(
      {required ExpenseModel currentExpense, num? newAmount}) async {
    final ExpenseModel expenseModel = currentExpense;
    expenseModel.amount = newAmount ?? currentExpense.amount;
    expenseModel.id = GUIDGen.generate();
    expenseModel.paymentDate = today;
    expenseModel.createdDate = today;

    final allExpensesModel =
        _hiveDatabase.getBox(boxName: AppBoxes.expenseModel);

    await allExpensesModel.add(expenseModel);

    print('Expenses values are ${allExpensesModel.values}');
  }

  @override
  bool checkSameDay({required DateTime date}) {
    //DateTime today=DateTime(2022,12,5);

    // if(today.difference(date).inDays==0){
    if (today.day == date.day && today.month == date.month) {
      return true;
    } else {
      return false;
    }
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
  List<ExpenseModel> getTodayPayments() {
    Box expenseRepeatTypes = _hiveDatabase.getBox(boxName: AppBoxes.expenseRepeatTypes);
    _getTodayDailyExpenses(todayList, expenseRepeatTypes);
    _getTodayWeeklyExpenses(todayList, expenseRepeatTypes);
    _getTodayMonthlyExpenses(todayList, expenseRepeatTypes);
    _getTodayNoRepeatExpenses(todayList, expenseRepeatTypes);
    return todayList;
  }

  List<ExpenseModel> _getTodayDailyExpenses(
      List<ExpenseModel> todayList, Box expenseRepeatTypes) {
    /// Daily Expenses List.
    List<ExpenseRepeatDetailsModel> dailyExpenses = expenseRepeatTypes.get(0);
    for (var item in dailyExpenses) {
      // here we check confirmation date  Slide number 12
      if (!checkSameDay(date: item.lastConfirmationDate)) {
        todayList.add(item.expenseModel);
      }
    }
    return todayList;
  }

  List<ExpenseModel> _getTodayWeeklyExpenses(
      List<ExpenseModel> todayList, Box expenseRepeatTypes) {
    /// Weekly Expenses List.
    List<ExpenseRepeatDetailsModel> weeklyExpenses = expenseRepeatTypes.get(1);
    for (var item in weeklyExpenses) {
      // here we check confirmation date  Slide number 12
      if (!checkSameDay(date: item.lastConfirmationDate)) {
        todayList.add(item.expenseModel);
      }
    }
    return todayList;
  }

  List<ExpenseModel> _getTodayMonthlyExpenses(
      List<ExpenseModel> todayList, Box expenseRepeatTypes) {
    /// Monthly Expenses List.
    List<ExpenseRepeatDetailsModel> monthlyExpenses = expenseRepeatTypes.get(2);
    for (var item in monthlyExpenses) {
      if (checkSameDay(date: item.nextShownDate) &&
              !checkSameDay(date: item.lastConfirmationDate) ||
          checkNoConfirmedAndMonthly(
              nextShownDate: item.nextShownDate,
              lastConfirmedDate: item.lastConfirmationDate,
              expensePayment: item.expenseModel.paymentDate??DateTime.now())) {
        todayList.add(item.expenseModel);
      }
    }
    return todayList;
  }

  List<ExpenseModel> _getTodayNoRepeatExpenses(
      List<ExpenseModel> todayList, Box expenseRepeatTypes) {
    /// NoRepeat Expenses List.
    List<ExpenseRepeatDetailsModel> noRepeatExpenses = expenseRepeatTypes.get(3);
    for (var item in noRepeatExpenses) {
      if (checkSameDay(date: item.nextShownDate) &&
          !checkSameDay(date: item.lastConfirmationDate)) {
        todayList.add(item.expenseModel);
      }
    }
    return todayList;
  }

  @override
  bool weeklyShowChecking(ExpenseRepeatDetailsModel weeklyExpense) {
    if (checkSameDay(date: weeklyExpense.nextShownDate) &&
            !checkSameDay(date: weeklyExpense.lastConfirmationDate) ||
        checkNoConfirmedAndWeekly(
            nextShownDate: weeklyExpense.nextShownDate,
            lastConfirmedDate: weeklyExpense.lastConfirmationDate,
            expensePayment: weeklyExpense.expenseModel.paymentDate ?? DateTime.now())) {
      return true;
    } else {
      return false;
    }
  }

// when Yes

  @override
  ExpenseRepeatDetailsModel editDailyExpenseLastShown(
      {required ExpenseModel addedExpense, required DateTime today}) {
    ExpenseRepeatDetailsModel theMatchingDailyExpense =
        Hive.box<ExpenseRepeatDetailsModel>('ExpenseRepeatDetailsModel')
            .values
            .where((element) => element.expenseModel.id == addedExpense.id)
            .single;
    print('Before Edit Daily ${theMatchingDailyExpense.lastConfirmationDate}');
    theMatchingDailyExpense.lastConfirmationDate = today;
    theMatchingDailyExpense.nextShownDate = today.add(const Duration(days: 1));
    theMatchingDailyExpense.lastShownDate = today;
    return theMatchingDailyExpense;
  }

  @override
  Future<void> saveDailyExpenseAndAddToRepeatBox(
      ExpenseRepeatDetailsModel theMatchingDailyExpense) async {
    await theMatchingDailyExpense.save();
    await addExpenseToBoxFromRepeatedBox(
        currentExpense: theMatchingDailyExpense.expenseModel);
  }

  @override
  Future saveDailyExpenseNoConfirm(
      ExpenseRepeatDetailsModel theMatchingDailyExpense) async {
    await theMatchingDailyExpense.save();
  }

  @override
  Future saveWeeklyExpenseNoConfirm(
      ExpenseRepeatDetailsModel theMatchingWeeklyExpenseModel) async {
    await theMatchingWeeklyExpenseModel.save();
  }

  @override
  Future saveMonthlyExpenseNoConfirm(
      ExpenseRepeatDetailsModel theMatchingMonthlyExpenseModel) async {
    await theMatchingMonthlyExpenseModel.save();
  }

  @override
  ExpenseRepeatDetailsModel editWeeklyExpenseLastShown(
      {required ExpenseModel addedExpense, required DateTime today}) {
    ExpenseRepeatDetailsModel theMatchingWeeklyExpenseModel =
        Hive.box<ExpenseRepeatDetailsModel>('ExpenseRepeatDetailsModel')
            .values
            .where((element) => element.expenseModel.id == addedExpense.id)
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
      ExpenseRepeatDetailsModel theMatchingWeeklyExpenseModel) async {
    await theMatchingWeeklyExpenseModel.save();
    await addExpenseToBoxFromRepeatedBox(
        currentExpense: theMatchingWeeklyExpenseModel.expenseModel);
  }

  @override
  ExpenseRepeatDetailsModel editMonthlyExpenseLastShown(
      {required ExpenseModel addedExpense, required DateTime today}) {
    ExpenseRepeatDetailsModel theMatchingMonthlyExpenseModel =
        Hive.box<ExpenseRepeatDetailsModel>('ExpenseRepeatDetailsModel')
            .values
            .where((element) => element.expenseModel.id == addedExpense.id)
            .single;

    theMatchingMonthlyExpenseModel.lastConfirmationDate = today;
    theMatchingMonthlyExpenseModel.nextShownDate =
        today.add(const Duration(days: 30));
    theMatchingMonthlyExpenseModel.lastShownDate = today;
    return theMatchingMonthlyExpenseModel;
  }

  @override
  ExpenseRepeatDetailsModel editNoRepeatExpenseLastShown(
      {required ExpenseModel addedExpense, required DateTime today}) {
    ExpenseRepeatDetailsModel theMatchingNoRepExpenseModel =
        Hive.box<ExpenseRepeatDetailsModel>('ExpenseRepeatDetailsModel')
            .values
            .where((element) => element.expenseModel.id == addedExpense.id)
            .single;
    theMatchingNoRepExpenseModel.lastConfirmationDate = today;
    theMatchingNoRepExpenseModel.lastShownDate = today;
    theMatchingNoRepExpenseModel.nextShownDate = today;
    return theMatchingNoRepExpenseModel;
  }

  @override
  Future saveMonthlyExpenseAndAddToRepeatBox(
      ExpenseRepeatDetailsModel theMatchingMonthlyExpenseModel) async {
    await theMatchingMonthlyExpenseModel.save();
    await addExpenseToBoxFromRepeatedBox(
        currentExpense: theMatchingMonthlyExpenseModel.expenseModel);
  }

  @override
  Future saveNoRepeatExpenseAndDeleteRepeatBox(
      ExpenseRepeatDetailsModel theMatchingNoRepExpenseModel) async {
    await addExpenseToBoxFromRepeatedBox(
            currentExpense: theMatchingNoRepExpenseModel.expenseModel);
          theMatchingNoRepExpenseModel.delete();
  }

  @override
  Future deleteNoRepeatExpense(
      ExpenseRepeatDetailsModel theMatchingNoRepExpenseModel) async {
    await theMatchingNoRepExpenseModel.delete();
  }

  @override
  Future<void> onYesConfirmed(
      {required String currentRepeatType,
      required ExpenseModel addedExpense}) async {
    print('working yes ..');
    try {
      if (currentRepeatType == 'Daily') {
        ExpenseRepeatDetailsModel theEditedDailyExpense = editDailyExpenseLastShown(
            addedExpense: addedExpense, today: today);
        await saveDailyExpenseAndAddToRepeatBox(theEditedDailyExpense);
        // print('After Edit Daily ${theMatchingDailyExpense.lastConfirmationDate}');

      }
      if (currentRepeatType == 'Weekly') {
        ExpenseRepeatDetailsModel theEditedWeeklyExpense = editWeeklyExpenseLastShown(
            addedExpense: addedExpense, today: today);
        await saveWeeklyExpenseAndAddToRepeatBox(theEditedWeeklyExpense);
      }
      if (currentRepeatType == 'Monthly') {
        ExpenseRepeatDetailsModel theEditedMonthlyExpense =
            editMonthlyExpenseLastShown(
                addedExpense: addedExpense, today: today);
        saveMonthlyExpenseAndAddToRepeatBox(theEditedMonthlyExpense);
      }
      if (currentRepeatType == 'No Repeat') {
        ExpenseRepeatDetailsModel theEditedNoRepeatedExpense =
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
      required ExpenseModel addedExpense}) async {
    if (currentRepeatType == 'Daily') {
      ExpenseRepeatDetailsModel theEditedDailyExpense = editDailyExpenseLastShown(
          addedExpense: addedExpense, today: today);
      await saveDailyExpenseNoConfirm(theEditedDailyExpense);
    }
    if (currentRepeatType == 'Weekly') {
      ExpenseRepeatDetailsModel theMatchingWeeklyExpenseModel =
          editWeeklyExpenseLastShown(
              addedExpense: addedExpense, today: today);
      await saveWeeklyExpenseNoConfirm(theMatchingWeeklyExpenseModel);
    }
    if (currentRepeatType == 'Monthly') {
      ExpenseRepeatDetailsModel theEditedMonthlyExpense = editMonthlyExpenseLastShown(
          addedExpense: addedExpense, today: today);
      await saveMonthlyExpenseNoConfirm(theEditedMonthlyExpense);
    }
    if (currentRepeatType == 'No Repeat') {
      ExpenseRepeatDetailsModel theEditedNoRepeatExpense =
          editNoRepeatExpenseLastShown(
              addedExpense: addedExpense, today: today);
      await deleteNoRepeatExpense(theEditedNoRepeatExpense);
    }
  }
}

