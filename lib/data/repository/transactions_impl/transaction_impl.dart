import 'package:temp/data/models/transactions/transaction_details_model.dart';
import 'package:temp/data/models/transactions/transaction_model.dart';
import 'package:temp/data/repository/transactions_impl/mixin_transaction.dart';
import '../../local/hive/app_boxes.dart';
import '../../../business_logic/repository/transactions_repo/transactions_interface.dart';

class DailyTransaction extends ITransactions with MixinTransaction  {

  @override
  void addTransactionToRepeatedBox(TransactionModel expenseModel) {

    TransactionRepeatDetailsModel dailyDetails = TransactionRepeatDetailsModel.copyWith(
      lastConfirmationDate: today,
      isLastConfirmed: false,
      creationDate: today,
      transactionModel: expenseModel,
      lastShownDate: putNextShownDate(
          paymentDate: expenseModel.paymentDate, repeatType: 'Daily'),
      nextShownDate: expenseModel.paymentDate,
    );

    final expenseRepeatDailyBox =
        hiveDatabase.getBoxName<TransactionRepeatDetailsModel>(
            boxName: AppBoxes.expenseRepeatDaily);

    expenseRepeatTypes.dailyExpense.add(dailyDetails);

    expenseRepeatDailyBox.add(dailyDetails);
    print("key is ${dailyDetails.key}");

    print('expense Daily List add ${expenseRepeatDailyBox.length}');
    print('box add length ${expenseRepeatTypes.dailyExpense.length}');
  }
  @override
  List<TransactionRepeatDetailsModel> getRepeatedTransactions() {
    /// get dailyExpenseRepeatList from BOX based on key number = 0.
    List<TransactionRepeatDetailsModel> expenseRepeatModel = [];
    try {
      if (expenseRepeatModel.isEmpty) {
        expenseRepeatModel =
            getExpenseDataFromBox(AppBoxes.expenseRepeatDaily);
      }
    } catch (error) {
      print('repo impl daily ${error.toString()}');
    }
    return expenseRepeatModel;
  }




}

class WeeklyTransaction extends ITransactions with MixinTransaction {
  @override
  void addTransactionToRepeatedBox(TransactionModel expenseModel) {
    final TransactionRepeatDetailsModel weeklyDetails =
    TransactionRepeatDetailsModel.copyWith(
      lastConfirmationDate: today,
      isLastConfirmed: false,
      creationDate: today,
      transactionModel: expenseModel,
      lastShownDate: putNextShownDate(
          paymentDate: expenseModel.paymentDate, repeatType: 'Weekly'),
      nextShownDate: expenseModel.paymentDate,
    );

    final expenseRepeatWeeklyBox =
        hiveDatabase.getBoxName<TransactionRepeatDetailsModel>(
            boxName: AppBoxes.expenseRepeatWeekly);

    expenseRepeatTypes.weeklyExpense.add(weeklyDetails);
    expenseRepeatWeeklyBox.add(weeklyDetails);
    print('expense Weekly List add ${expenseRepeatWeeklyBox.length}');
    print('box add length ${expenseRepeatTypes.weeklyExpense.length}');
  }
  @override
  List<TransactionRepeatDetailsModel> getRepeatedTransactions() {
    /// get weeklyExpenseRepeatList from BOX .

    List<TransactionRepeatDetailsModel> expenseRepeatModel = [];
    try {
      if (expenseRepeatModel.isEmpty) {
        expenseRepeatModel =
            getExpenseDataFromBox(AppBoxes.expenseRepeatWeekly);
      }
    } catch (error) {
      print('repo impl weekly ${error.toString()}');
    }
    return expenseRepeatModel;
  }

}

class MonthlyTransaction extends ITransactions with MixinTransaction {
  @override
  void addTransactionToRepeatedBox(TransactionModel expenseModel) {
    final expenseRepeatMonthlyBox =
        hiveDatabase.getBoxName<TransactionRepeatDetailsModel>(
            boxName: AppBoxes.expenseRepeatMonthly);

    final TransactionRepeatDetailsModel monthlyDetails =
    TransactionRepeatDetailsModel.copyWith(
      lastConfirmationDate: today,
      isLastConfirmed: false,
      creationDate: today,
      transactionModel: expenseModel,
      lastShownDate: putNextShownDate(
          paymentDate: expenseModel.paymentDate, repeatType: 'Monthly'),
      nextShownDate: expenseModel.paymentDate,
    );

    expenseRepeatTypes.monthlyExpense.add(monthlyDetails);
    expenseRepeatMonthlyBox.add(monthlyDetails);
    print('expense monthly List add ${expenseRepeatMonthlyBox.length}');
    print('box add length ${expenseRepeatTypes.monthlyExpense.length}');
  }

  @override
  List<TransactionRepeatDetailsModel> getRepeatedTransactions() {
    /// get monthlyExpenseRepeatList from BOX .
    List<TransactionRepeatDetailsModel> expenseRepeatModel = [];

    try {
      expenseRepeatModel =
          getExpenseDataFromBox(AppBoxes.expenseRepeatMonthly);
    } catch (error) {
      print('from RepeatMonthly Impl : ${error.toString()}');
    }
    return expenseRepeatModel;
  }

}

class NoRepeatTransaction extends ITransactions with MixinTransaction {
  @override
  void addTransactionToRepeatedBox(TransactionModel expenseModel) {
    ///
    final expenseNoRepeatBox =
        hiveDatabase.getBoxName<TransactionRepeatDetailsModel>(
            boxName: AppBoxes.expenseNoRepeat);
    ///
    final TransactionRepeatDetailsModel noRepeatDetails =
    TransactionRepeatDetailsModel.copyWith(
      lastConfirmationDate: today,
      isLastConfirmed: false,
      creationDate: today,
      transactionModel: expenseModel,
      lastShownDate: putNextShownDate(
          paymentDate: expenseModel.paymentDate, repeatType: 'No Repeat'),
      nextShownDate: expenseModel.paymentDate,
    );

    ///
    expenseRepeatTypes.noRepeatExpense.add(noRepeatDetails);

    ///
    expenseNoRepeatBox.add(noRepeatDetails);

    print('expense noRepeat List add ${expenseNoRepeatBox.length}');
    print('box add length ${expenseRepeatTypes.noRepeatExpense.length}');
  }

  @override
  List<TransactionRepeatDetailsModel> getRepeatedTransactions() {
    /// get noRepeatExpenseRepeatList from BOX .
    List<TransactionRepeatDetailsModel> expenseRepeatModel = [];
    try {
      expenseRepeatModel = getExpenseDataFromBox(AppBoxes.expenseNoRepeat);
    } catch (error) {
      print('from RepeatNoRepeat Impl : ${error.toString()}');
    }
    return expenseRepeatModel;
  }
}
