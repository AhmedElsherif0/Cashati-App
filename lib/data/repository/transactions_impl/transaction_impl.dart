import 'package:hive/hive.dart';
import 'package:temp/data/models/transactions/transaction_details_model.dart';
import 'package:temp/data/models/transactions/transaction_model.dart';
import 'package:temp/data/repository/transactions_impl/mixin_transaction.dart';
import '../../local/hive/app_boxes.dart';
import '../../../business_logic/repository/transactions_repo/transactions_interface.dart';

class DailyTransaction  extends ITransactions with MixinTransaction {

  @override
  Future<void> addTransactionToRepeatedBox(
      TransactionModel transactionModel) async {
    TransactionRepeatDetailsModel dailyDetails =
        TransactionRepeatDetailsModel.copyWith(
      lastConfirmationDate: today,
      isLastConfirmed: false,
      creationDate: today,
      transactionModel: transactionModel,
      lastShownDate: putNextShownDate(
          paymentDate: transactionModel.paymentDate, repeatType: 'Daily'),
      nextShownDate: transactionModel.paymentDate,
    );

    final Box<TransactionRepeatDetailsModel> expenseRepeatDailyBox =
       hiveDatabase
            .getBoxName<TransactionRepeatDetailsModel>(
                boxName: AppBoxes.dailyTransactionsBoxName);

  expenseRepeatTypes.dailyExpense.add(dailyDetails);
    //TODO test putting they key ( as in repeated boxes the key of the repeated model will be the first id of transaction model added)
    await expenseRepeatDailyBox.put(transactionModel.id, dailyDetails);
    print("key is ${dailyDetails.key}");

    print('expense Daily List add ${expenseRepeatDailyBox.length}');
    print(
        'box add length ${expenseRepeatTypes.dailyExpense.length}');
  }

  @override
  List<TransactionRepeatDetailsModel> getRepeatedTransactions(
      {required bool isExpense}) {
    /// get dailyExpenseRepeatList from BOX based on key number = 0.
    List<TransactionRepeatDetailsModel> dailyTransactionList = [];
    try {
      //TODO check the condition below as expenseRepeatModel should be empty by default .
      if (dailyTransactionList.isEmpty) {
        if (isExpense) {
          dailyTransactionList =
              //getExpenseDataFromBox(AppBoxes.expenseRepeatDaily);

    getRepeatedTransByBoxName(AppBoxes.dailyTransactionsBoxName)
                  .where((element) => element.transactionModel.isExpense)
                  .toList();
        } else {
          dailyTransactionList =
              //getExpenseDataFromBox(AppBoxes.expenseRepeatDaily);

                  getRepeatedTransByBoxName(AppBoxes.dailyTransactionsBoxName)
                  .where((element) => !element.transactionModel.isExpense)
                  .toList();
        }
      }
    } catch (error) {
      print('repo impl daily ${error.toString()}');
    }
    return dailyTransactionList;
  }
}

class WeeklyTransaction extends ITransactions with  MixinTransaction {

  @override
  Future<void> addTransactionToRepeatedBox(
      TransactionModel transactionModel) async {
    final TransactionRepeatDetailsModel weeklyDetails =
        TransactionRepeatDetailsModel.copyWith(
      lastConfirmationDate: today,
      isLastConfirmed: false,
      creationDate: today,
      transactionModel: transactionModel,
      lastShownDate: putNextShownDate(
          paymentDate: transactionModel.paymentDate, repeatType: 'Weekly'),
      nextShownDate: transactionModel.paymentDate,
    );

    final Box<TransactionRepeatDetailsModel> expenseRepeatWeeklyBox =
        hiveDatabase
            .getBoxName<TransactionRepeatDetailsModel>(
                boxName: AppBoxes.weeklyTransactionsBoxName);

expenseRepeatTypes.weeklyExpense.add(weeklyDetails);
    //TODO test putting they key ( as in repeated boxes the key of the repeated model will be the first id of transaction model added)
    await expenseRepeatWeeklyBox.put(transactionModel.id, weeklyDetails);
    // expenseRepeatWeeklyBox.add(weeklyDetails);
    print('expense Weekly List add ${expenseRepeatWeeklyBox.length}');
    print(
        'box add length ${expenseRepeatTypes.weeklyExpense.length}');
  }

  @override
  List<TransactionRepeatDetailsModel> getRepeatedTransactions(
      {required bool isExpense}) {
    /// get dailyExpenseRepeatList from BOX based on key number = 0.
    List<TransactionRepeatDetailsModel> weeklyTransactionsList = [];
    try {
      //TODO check the condition below as expenseRepeatModel should be empty by default .
      if (weeklyTransactionsList.isEmpty) {
        if (isExpense) {
          weeklyTransactionsList =
              //getExpenseDataFromBox(AppBoxes.expenseRepeatDaily);
              getRepeatedTransByBoxName(AppBoxes.weeklyTransactionsBoxName)
                  .where((element) => element.transactionModel.isExpense)
                  .toList();
        } else {
          weeklyTransactionsList =
              //getExpenseDataFromBox(AppBoxes.expenseRepeatDaily);
            getRepeatedTransByBoxName(AppBoxes.weeklyTransactionsBoxName)
                  .where((element) => !element.transactionModel.isExpense)
                  .toList();
        }
      }
    } catch (error) {
      print('repo impl daily ${error.toString()}');
    }
    return weeklyTransactionsList;
  }
}

class MonthlyTransaction extends ITransactions with MixinTransaction{

  @override
  Future<void> addTransactionToRepeatedBox(
      TransactionModel transactionModel) async {
    final Box<TransactionRepeatDetailsModel> expenseRepeatMonthlyBox =
       hiveDatabase.getBoxName<TransactionRepeatDetailsModel>(
            boxName: AppBoxes.monthlyTransactionsBoxName);

    final TransactionRepeatDetailsModel monthlyDetails =
        TransactionRepeatDetailsModel.copyWith(
      lastConfirmationDate:today,
      isLastConfirmed: false,
      creationDate: today,
      transactionModel: transactionModel,
      lastShownDate: putNextShownDate(
          paymentDate: transactionModel.paymentDate, repeatType: 'Monthly'),
      nextShownDate: transactionModel.paymentDate,
    );

    expenseRepeatTypes.monthlyExpense.add(monthlyDetails);
    //TODO test putting they key ( as in repeated boxes the key of the repeated model will be the first id of transaction model added)
    await expenseRepeatMonthlyBox.put(transactionModel.id, monthlyDetails);
    print('expense monthly List add ${expenseRepeatMonthlyBox.length}');
    print('box add length ${
        expenseRepeatTypes.monthlyExpense.length}');
  }

  @override
  List<TransactionRepeatDetailsModel> getRepeatedTransactions(
      {required bool isExpense}) {
    /// get dailyExpenseRepeatList from BOX based on key number = 0.
    List<TransactionRepeatDetailsModel> monthlyTransactionsList = [];
    try {
      //TODO check the condition below as expenseRepeatModel should be empty by default .
      if (monthlyTransactionsList.isEmpty) {
        if (isExpense) {
          monthlyTransactionsList =
              //getExpenseDataFromBox(AppBoxes.expenseRepeatDaily);
            getRepeatedTransByBoxName(AppBoxes.monthlyTransactionsBoxName)
                  .where((element) => element.transactionModel.isExpense)
                  .toList();
        } else {
          monthlyTransactionsList =
              //getExpenseDataFromBox(AppBoxes.expenseRepeatDaily);
            getRepeatedTransByBoxName(AppBoxes.monthlyTransactionsBoxName)
                  .where((element) => !element.transactionModel.isExpense)
                  .toList();
        }
      }
    } catch (error) {
      print('repo impl daily ${error.toString()}');
    }
    return monthlyTransactionsList;
  }
}

class NoRepeatTransaction extends ITransactions with MixinTransaction{

  @override
  Future<void> addTransactionToRepeatedBox(
      TransactionModel transactionModel) async {
    ///
    final Box<TransactionRepeatDetailsModel> expenseNoRepeatBox =
        hiveDatabase.getBoxName<TransactionRepeatDetailsModel>(
            boxName: AppBoxes.noRepeaTransactionsBoxName);

    ///
    final TransactionRepeatDetailsModel noRepeatDetails =
        TransactionRepeatDetailsModel.copyWith(
      lastConfirmationDate: today,
      isLastConfirmed: false,
      creationDate:  today,
      transactionModel: transactionModel,
      lastShownDate:putNextShownDate(
          paymentDate: transactionModel.paymentDate, repeatType: 'No Repeat'),
      nextShownDate: transactionModel.paymentDate,
    );

    expenseRepeatTypes.noRepeatExpense.add(noRepeatDetails);

    ///
    //expenseNoRepeatBox.add(noRepeatDetails);
    //TODO test putting they key ( as in repeated boxes the key of the repeated model will be the first id of transaction model added)
    await expenseNoRepeatBox.put(transactionModel.id, noRepeatDetails);

    print('expense noRepeat List add ${expenseNoRepeatBox.length}');
    print('box add length ${ expenseRepeatTypes.noRepeatExpense.length}');
  }

  @override
  List<TransactionRepeatDetailsModel> getRepeatedTransactions(
      {required bool isExpense}) {
    /// get dailyExpenseRepeatList from BOX based on key number = 0.
    List<TransactionRepeatDetailsModel> noRepeatTransactionsList = [];
    try {
      //TODO check the condition below as expenseRepeatModel should be empty by default .
      if (noRepeatTransactionsList.isEmpty) {
        if (isExpense) {
          noRepeatTransactionsList =
              //getExpenseDataFromBox(AppBoxes.expenseRepeatDaily);
          getRepeatedTransByBoxName(AppBoxes.noRepeaTransactionsBoxName)
                  .where((element) => element.transactionModel.isExpense)
                  .toList();
        } else {
          noRepeatTransactionsList =
              //getExpenseDataFromBox(AppBoxes.expenseRepeatDaily);
            getRepeatedTransByBoxName(AppBoxes.noRepeaTransactionsBoxName)
                  .where((element) => !element.transactionModel.isExpense)
                  .toList();
        }
      }
    } catch (error) {
      print('repo impl daily ${error.toString()}');
    }
    return noRepeatTransactionsList;
  }
}
