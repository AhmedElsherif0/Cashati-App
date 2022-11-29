import 'package:hive/hive.dart';
import 'package:temp/data/local/hive/app_boxes.dart';
import 'package:temp/data/local/hive/hive_database.dart';
import 'package:temp/data/models/expenses/expense_details_model.dart';
import 'package:temp/data/models/expenses/expense_types_model.dart';

import '../../../business_logic/repository/expenses_repo/expenses_repo.dart';
import '../../local/hive/id_generator.dart';
import '../../models/expenses/expense_model.dart';

class ExpensesRepositoryImpl implements ExpensesRepository {
  DateTime today = DateTime.now();
  final HiveHelper _hiveDatabase = HiveHelper();
  ExpenseRepeatTypes expenseRepeatTypes = ExpenseRepeatTypes();

  @override
  Future<void> addExpenseToExpensesBox({
    required String expenseName,
    required num expenseAmount,
    required String expenseMainCateg,
    required String expenseSubCateg,
    required String expenseComment,
    required String expenseRepeat,
    required bool expensePriority,
    required bool isExpensePaid,
    required DateTime expensePaymentDate,
    required DateTime expenseCreatedDate,
  }) async {
    final expenseModel = ExpenseModel.copyWith(
        amount: expenseAmount,
        comment: expenseComment,
        id: GUIDGen.generate(),
        name: expenseName,
        repeatType: expenseRepeat,
        mainCategory: expenseMainCateg,
        isAddAuto: false,
        isPriority: expensePriority,
        subCategory: expenseSubCateg,
        isReceiveNotification: false,
        isPaid: isEqualToday(date: expensePaymentDate),
        createdDate: DateTime.now(),
        paymentDate: expensePaymentDate);

    final allExpensesModel =
        _hiveDatabase.getBox(boxName: AppBoxes.expenseModel);
    if (isEqualToday(date: expenseModel.paymentDate)) {
      await allExpensesModel.add(expenseModel);
      await addToRepeatedBoxes(expenseModel.repeatType, expenseModel);
    } else {
      await addToRepeatedBoxes(expenseModel.repeatType, expenseModel);
    }
    print('Expenses values are ${allExpensesModel.values}');
  }

  @override
  Future<void> addToRepeatedBoxes(
      String repeat, ExpenseModel expenseModel) async {
    if (repeat == 'daily') {
      addDailyExpenseToRepeatedBox(expenseModel);
    } else if (repeat == 'weekly') {
      addWeeklyExpenseToRepeatedBox(expenseModel);
    } else if (repeat == 'monthly') {
      addMonthlyExpenseToRepeatedBox(expenseModel);
    } else if (repeat == 'noRepeat') {
      addNoRepeatExpenseToRepeatedBox(expenseModel);
    }
  }

  @override
  DateTime putNextShownDate(
      {required DateTime expensePaymentDate, required String repeatType}) {
    switch (repeatType) {
      case 'Daily':
        return expensePaymentDate;
      case 'Weekly':
        //if(expensePaymentDate.day==today.day&&expensePaymentDate.month==today.month&&expensePaymentDate.year==today.year){
        if (
            // expensePaymentDate.difference(today).inDays==0
            checkSameDay(date: expensePaymentDate)) {
          return expensePaymentDate.add(const Duration(days: 7));
        } else {
          // return expensePaymentDate.add(Duration(days: 7));
          // the right return is below
          return expensePaymentDate;
        }
      case 'Monthly':
        if (
            //expensePaymentDate.difference(today).inDays==0
            checkSameDay(date: expensePaymentDate)) {
          return expensePaymentDate.add(const Duration(days: 30));
        } else {
          return expensePaymentDate;
        }
      case 'No Repeat':
        return expensePaymentDate;

      default:
        return today;
    }
  }

  @override
  bool isEqualToday({required DateTime date}) {
    //DateTime today=DateTime(2022,12,5);

    // if(today.difference(date).inDays==0){

    // Todo :: this function will return false any way..
    // Todo ::  return the condition instead of " false ".
    (today.day == date.day &&
            today.month == today.month &&
            today.year == date.year)
        ? true
        : false;
    return false;
  }

  /// something missed.
  @override
  Future addDailyExpenseToRepeatedBox(ExpenseModel expenseModel) async {

    ExpenseRepeatDetailsModel dailyExpenseModel = ExpenseRepeatDetailsModel.copyWith(
      lastConfirmationDate: today,
      isLastConfirmed: false,
      creationDate: today,
      expenseModel: expenseModel,
      lastShownDate: putNextShownDate(
          expensePaymentDate: expenseModel.paymentDate, repeatType: 'Daily'),
      nextShownDate: expenseModel.paymentDate,
    );
    expenseRepeatTypes.dailyExpense.add(dailyExpenseModel);

    /// the IndexKey refer to the Index of the HiveField in the DataModel.
    await _hiveDatabase.putByIndexKey(
        indexKey: 0,
        boxName: _hiveDatabase.getBox(boxName: AppBoxes.expenseRepeatTypes),
        dataModel: dailyExpenseModel);
  }

  @override
  Future addWeeklyExpenseToRepeatedBox(ExpenseModel expenseModel) async {
    final weeklyExpensesBox =
        _hiveDatabase.getBox(boxName: AppBoxes.expenseRepeatTypes);

    final ExpenseRepeatDetailsModel weeklyExpenseModel =
        ExpenseRepeatDetailsModel.copyWith(
      lastConfirmationDate: today,
      isLastConfirmed: false,
      creationDate: today,
      expenseModel: expenseModel,
      lastShownDate: putNextShownDate(
          expensePaymentDate: expenseModel.paymentDate, repeatType: 'Weekly'),
      nextShownDate: expenseModel.paymentDate,
    );
    await weeklyExpensesBox.add(weeklyExpenseModel);
  }

  @override
  Future addMonthlyExpenseToRepeatedBox(ExpenseModel expenseModel) async {
    final monthlyBox =
        _hiveDatabase.getBox(boxName: AppBoxes.expenseRepeatTypes);
    final ExpenseRepeatDetailsModel monthlyExpenseModel =
        ExpenseRepeatDetailsModel.copyWith(
      lastConfirmationDate: today,
      isLastConfirmed: false,
      creationDate: today,
      expenseModel: expenseModel,
      lastShownDate: putNextShownDate(
          expensePaymentDate: expenseModel.paymentDate, repeatType: 'Monthly'),
      nextShownDate: expenseModel.paymentDate,
    );
    await monthlyBox.add(monthlyExpenseModel);
  }

  @override
  Future addNoRepeatExpenseToRepeatedBox(ExpenseModel expenseModel) async {
    Box noRepeatBox =
        _hiveDatabase.getBox(boxName: AppBoxes.expenseRepeatTypes);
    final ExpenseRepeatDetailsModel noRepeatExpenseModel =
        ExpenseRepeatDetailsModel.copyWith(
      lastConfirmationDate: today,
      isLastConfirmed: false,
      creationDate: today,
      expenseModel: expenseModel,
      lastShownDate: putNextShownDate(
          expensePaymentDate: expenseModel.paymentDate,
          repeatType: 'No Repeat'),
      nextShownDate: expenseModel.paymentDate,
    );
    await noRepeatBox.add(noRepeatExpenseModel);
  }

  @override
  bool checkSameDay({required DateTime date}) {
    // TODO: implement checkSameDay
    throw UnimplementedError();
  }
}
