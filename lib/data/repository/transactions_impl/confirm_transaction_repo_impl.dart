import 'package:hive/hive.dart';
import 'package:temp/constants/app_strings.dart';
import 'package:temp/data/local/hive/app_boxes.dart';
import 'package:temp/data/models/transactions/transaction_details_model.dart';
import 'package:temp/data/models/transactions/transaction_model.dart';
import 'package:temp/data/repository/transactions_impl/mixin_transaction.dart';
import '../../../business_logic/repository/expenses_repo/confirm_expense_repo.dart';
import '../../local/hive/id_generator.dart';

class ConfirmTransactionImpl with MixinTransaction implements ConfirmTransactionRepo {

  List<TransactionModel> todayList = [];

  Future<void> addExpenseToBoxFromRepeatedBox(
      {required TransactionModel currentExpense, num? newAmount}) async {
    final TransactionModel expenseModel = currentExpense;
    expenseModel.amount = newAmount ?? currentExpense.amount;
    expenseModel.id = GUIDGen.generate();
    expenseModel.paymentDate = today;
    expenseModel.createdDate = today;
  try{
     await  hiveDatabase.putByKey<TransactionModel>(indexKey: expenseModel.id,dataModel: expenseModel,boxName: Hive.box(AppBoxes.transactionBox));

   }catch(error){
     print('Error in adding transaction from repeated box to transaction box (confirm) is ${error.toString()}');
 }
}

  /// is it calling from any class less this ??
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
            !checkSameDay(date: lastConfirmedDate)) {
      return true;
    } else {
      return false;
    }
  }

  /// is it calling from any class less this ??
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

  List<TransactionModel> getTodayPayments({required bool isExpense}) {

    List<TransactionModel> todayList = [];

    todayList.addAll(_getTodayDailyExpenses(isExpense: isExpense));
    todayList.addAll(_getTodayWeeklyExpenses(isExpense: isExpense));
    todayList.addAll(_getTodayMonthlyExpenses(isExpense: isExpense));
    todayList.addAll(_getTodayNoRepeatExpenses(isExpense: isExpense));
    return todayList;
  }

  List<TransactionModel> _getTodayDailyExpenses({required bool isExpense}) {
    List<TransactionModel> todaDailyList=[];
    /// Daily Expenses List.
    List<TransactionRepeatDetailsModel> dailyExpenses =
    getRepTransactionsByRep(repeat: AppStrings.daily,isExpense: isExpense);
    for (var item in dailyExpenses) {
      // here we check confirmation date  Slide number 12
     if(dailyShowChecking(item)){
        todaDailyList.add(item.transactionModel);
      }
    }
    return todaDailyList;
  }

  List<TransactionModel> _getTodayWeeklyExpenses({required bool isExpense}) {
    /// Weekly Expenses List.
    List<TransactionModel> todayWeeklyList=[];
    List<TransactionRepeatDetailsModel> weeklyExpenses =
    getRepTransactionsByRep(repeat: AppStrings.weekly,isExpense: isExpense);
    for (var item in weeklyExpenses) {
      // here we check confirmation date  Slide number 12
      if (weeklyShowChecking(item)) {
        todayWeeklyList.add(item.transactionModel);
      }
    }
    return todayWeeklyList;
  }

  List<TransactionModel> _getTodayMonthlyExpenses({required bool isExpense}) {
    /// Monthly Expenses List.
    // List<TransactionRepeatDetailsModel> monthlyExpenses = expenseRepeatTypes.get(2);
    List<TransactionModel> todayMonthlyList=[];

    List<TransactionRepeatDetailsModel> monthlyExpenses = getRepTransactionsByRep(repeat: AppStrings.monthly,isExpense: isExpense);
    for (var item in monthlyExpenses) {

      if(monthlyShowChecking(item)){
        todayMonthlyList.add(item.transactionModel);
      }else{}
    }
    return todayMonthlyList;
  }

  List<TransactionModel> _getTodayNoRepeatExpenses({required bool isExpense}) {
    /// NoRepeat Expenses List.
    List<TransactionModel> todayNoRepeatList=[];
    List<TransactionRepeatDetailsModel> noRepeatExpenses =
    getRepTransactionsByRep(repeat: AppStrings.monthly,isExpense: isExpense);
    for (var item in noRepeatExpenses) {

      if(noRepeatShowChecking(item)) {
        todayNoRepeatList.add(item.transactionModel);
      }
    }
    return todayNoRepeatList;
  }
  bool dailyShowChecking(TransactionRepeatDetailsModel dailyTransacion) {
    if (!checkSameDay(date: dailyTransacion.lastConfirmationDate)) {
      return true;
    } else {
      return false;
    }
  }

  bool weeklyShowChecking(TransactionRepeatDetailsModel weeklyTransaction) {
    if (checkSameDay(date: weeklyTransaction.nextShownDate) &&
            !checkSameDay(date: weeklyTransaction.lastConfirmationDate) ||
        checkNoConfirmedAndWeekly(
            nextShownDate: weeklyTransaction.nextShownDate,
            lastConfirmedDate: weeklyTransaction.lastConfirmationDate,
            expensePayment: weeklyTransaction.transactionModel.paymentDate)) {
      return true;
    } else {
      return false;
    }
  }

  bool monthlyShowChecking(TransactionRepeatDetailsModel monthlyTransaction) {
    if (checkSameDay(date: monthlyTransaction.nextShownDate) &&
        !checkSameDay(date: monthlyTransaction.lastConfirmationDate) ||
        checkNoConfirmedAndMonthly(
            nextShownDate: monthlyTransaction.nextShownDate,
            lastConfirmedDate: monthlyTransaction.lastConfirmationDate,
            expensePayment: monthlyTransaction.transactionModel.paymentDate)) {
      return true;
    } else {
      return false;
    }
  }

  bool noRepeatShowChecking(TransactionRepeatDetailsModel noRepTransaction) {
    if (checkSameDay(date: noRepTransaction.nextShownDate) &&
        !checkSameDay(date: noRepTransaction.lastConfirmationDate)) {
      return true;
    } else {
      return false;
    }
  }


// when Yes

  TransactionRepeatDetailsModel editDailyExpenseLastShown(
      {required TransactionModel addedExpense, required DateTime today}) {
    //TODO check if there is any difference between getting key and loop in ids
    /// this transaction model is fetched from the repeated model So its key is always the same one
    /// with its repeated model as both have same key and id (when adding transaction at first time)
    TransactionRepeatDetailsModel theMatchingDailyExpense =
    Hive.box<TransactionRepeatDetailsModel>(AppBoxes.dailyTransactionsBoxName).get(addedExpense.id)!;
        // Hive.box<TransactionRepeatDetailsModel>(AppBoxes.dailyTransactionsBoxName)
        //     .values
        //     .where((element) => element.transactionModel.id == addedExpense.id)
        //     .single;
    print('Before Edit Daily ${theMatchingDailyExpense.lastConfirmationDate}');
    theMatchingDailyExpense.lastConfirmationDate = today;
    theMatchingDailyExpense.nextShownDate = today.add(const Duration(days: 1));
    theMatchingDailyExpense.lastShownDate = today;
    return theMatchingDailyExpense;
  }

  Future<void> saveDailyExpenseAndAddToRepeatBox(
      TransactionRepeatDetailsModel theMatchingDailyExpense) async {
    await theMatchingDailyExpense.save();
    await addExpenseToBoxFromRepeatedBox(
        currentExpense: theMatchingDailyExpense.transactionModel);
  }

  Future saveDailyExpenseNoConfirm(
      TransactionRepeatDetailsModel theMatchingDailyExpense) async {
    await theMatchingDailyExpense.save();
  }

  Future saveWeeklyExpenseNoConfirm(
      TransactionRepeatDetailsModel theMatchingWeeklyExpenseModel) async {
    await theMatchingWeeklyExpenseModel.save();
  }

  Future saveMonthlyExpenseNoConfirm(
      TransactionRepeatDetailsModel theMatchingMonthlyExpenseModel) async {
    await theMatchingMonthlyExpenseModel.save();
  }

  TransactionRepeatDetailsModel editWeeklyExpenseLastShown(
      {required TransactionModel addedExpense, required DateTime today}) {
    TransactionRepeatDetailsModel theMatchingWeeklyExpenseModel =
    Hive.box<TransactionRepeatDetailsModel>(AppBoxes.weeklyTransactionsBoxName).get(addedExpense.id)!;

    // Hive.box<TransactionRepeatDetailsModel>('ExpenseRepeatDetailsModel')
        //     .values
        //     .where((element) => element.transactionModel.id == addedExpense.id)
        //     .single;

    // the right last confirmation date is below
    theMatchingWeeklyExpenseModel.lastConfirmationDate = today;
    theMatchingWeeklyExpenseModel.nextShownDate =
        today.add(const Duration(days: 7));
    theMatchingWeeklyExpenseModel.lastShownDate = today;
    return theMatchingWeeklyExpenseModel;
  }

  Future saveWeeklyExpenseAndAddToRepeatBox(
      TransactionRepeatDetailsModel theMatchingWeeklyExpenseModel) async {
    await theMatchingWeeklyExpenseModel.save();
    await addExpenseToBoxFromRepeatedBox(
        currentExpense: theMatchingWeeklyExpenseModel.transactionModel);
  }

  TransactionRepeatDetailsModel editMonthlyExpenseLastShown(
      {required TransactionModel addedExpense, required DateTime today}) {
    TransactionRepeatDetailsModel theMatchingMonthlyExpenseModel =
    Hive.box<TransactionRepeatDetailsModel>(AppBoxes.monthlyTransactionsBoxName).get(addedExpense.id)!;

    // Hive.box<TransactionRepeatDetailsModel>('ExpenseRepeatDetailsModel')
        //     .values
        //     .where((element) => element.transactionModel.id == addedExpense.id)
        //     .single;

    theMatchingMonthlyExpenseModel.lastConfirmationDate = today;
    theMatchingMonthlyExpenseModel.nextShownDate =
        today.add(const Duration(days: 30));
    theMatchingMonthlyExpenseModel.lastShownDate = today;
    return theMatchingMonthlyExpenseModel;
  }

  TransactionRepeatDetailsModel editNoRepeatExpenseLastShown(
      {required TransactionModel addedExpense, required DateTime today}) {
    TransactionRepeatDetailsModel theMatchingNoRepExpenseModel =
    Hive.box<TransactionRepeatDetailsModel>(AppBoxes.noRepeaTransactionsBoxName).get(addedExpense.id)!;

    // Hive.box<TransactionRepeatDetailsModel>(AppBoxes.noRepeaTransactionsBoxName)
        //     .values
        //     .where((element) => element.transactionModel.id == addedExpense.id)
        //     .single;
    theMatchingNoRepExpenseModel.lastConfirmationDate = today;
    theMatchingNoRepExpenseModel.lastShownDate = today;
    theMatchingNoRepExpenseModel.nextShownDate = today;
    return theMatchingNoRepExpenseModel;
  }

  Future saveMonthlyExpenseAndAddToRepeatBox(
      TransactionRepeatDetailsModel theMatchingMonthlyExpenseModel) async {
    await theMatchingMonthlyExpenseModel.save();
    await addExpenseToBoxFromRepeatedBox(
        currentExpense: theMatchingMonthlyExpenseModel.transactionModel);
  }

  Future saveNoRepeatExpenseAndDeleteRepeatBox(
      TransactionRepeatDetailsModel theMatchingNoRepExpenseModel) async {
    await addExpenseToBoxFromRepeatedBox(
        currentExpense: theMatchingNoRepExpenseModel.transactionModel);
    theMatchingNoRepExpenseModel.delete();
  }

  @override
  Future deleteNoRepeatTransaction(
      TransactionRepeatDetailsModel theMatchingNoRepExpenseModel) async {
    await theMatchingNoRepExpenseModel.delete();
  }

  @override
  Future<void> onYesConfirmed(
      {required TransactionModel addedExpense}) async {
    print('working yes ..');
    try {
      if (addedExpense.repeatType == 'Daily') {
        TransactionRepeatDetailsModel theEditedDailyExpense =
            editDailyExpenseLastShown(addedExpense: addedExpense, today: today);
        await saveDailyExpenseAndAddToRepeatBox(theEditedDailyExpense);
        // print('After Edit Daily ${theMatchingDailyExpense.lastConfirmationDate}');
      }
      if (addedExpense.repeatType == 'Weekly') {
        TransactionRepeatDetailsModel theEditedWeeklyExpense =
            editWeeklyExpenseLastShown(
                addedExpense: addedExpense, today: today);
        await saveWeeklyExpenseAndAddToRepeatBox(theEditedWeeklyExpense);
      }
      if (addedExpense.repeatType == 'Monthly') {
        TransactionRepeatDetailsModel theEditedMonthlyExpense =
            editMonthlyExpenseLastShown(
                addedExpense: addedExpense, today: today);
        saveMonthlyExpenseAndAddToRepeatBox(theEditedMonthlyExpense);
      }
      if (addedExpense.repeatType == 'No Repeat') {
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
      {
      required TransactionModel addedExpense}) async {
    if (addedExpense.repeatType == 'Daily') {
      TransactionRepeatDetailsModel theEditedDailyExpense =
          editDailyExpenseLastShown(addedExpense: addedExpense, today: today);
      await saveDailyExpenseNoConfirm(theEditedDailyExpense);
    }
    if (addedExpense.repeatType == 'Weekly') {
      TransactionRepeatDetailsModel theMatchingWeeklyExpenseModel =
          editWeeklyExpenseLastShown(addedExpense: addedExpense, today: today);
      await saveWeeklyExpenseNoConfirm(theMatchingWeeklyExpenseModel);
    }
    if (addedExpense.repeatType == 'Monthly') {
      TransactionRepeatDetailsModel theEditedMonthlyExpense =
          editMonthlyExpenseLastShown(addedExpense: addedExpense, today: today);
      await saveMonthlyExpenseNoConfirm(theEditedMonthlyExpense);
    }
    if (addedExpense.repeatType == 'No Repeat') {
      TransactionRepeatDetailsModel theEditedNoRepeatExpense =
          editNoRepeatExpenseLastShown(
              addedExpense: addedExpense, today: today);
      await deleteNoRepeatTransaction(theEditedNoRepeatExpense);
    }
  }
}
