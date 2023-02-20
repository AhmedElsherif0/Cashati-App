import 'package:hive/hive.dart';
import 'package:temp/business_logic/repository/transactions_repo/transaction_repo.dart';
import 'package:temp/data/local/hive/app_boxes.dart';
import 'package:temp/data/local/hive/hive_database.dart';
import 'package:temp/data/models/transactions/transaction_details_model.dart';
import 'package:temp/data/repository/general_stats_repo_impl/general_stats_repo_impl.dart';
import 'package:temp/data/repository/transactions_impl/mixin_transaction.dart';

import '../../models/transactions/transaction_model.dart';
import '../transactions_impl/transaction_impl.dart';

class IncomeRepositoryImpl extends GeneralStatsRepoImpl with MixinTransaction  implements TransactionRepo {

  IncomeRepositoryImpl();

  @override
  void addTransactions(
      {required TransactionModel transaction}) {
    switch (transaction.repeatType) {
      case 'Daily':
        DailyTransaction().addTransactionToRepeatedBox(transaction);
        break;
      case 'Weekly':
        WeeklyTransaction().addTransactionToRepeatedBox(transaction);
        break;
      case 'Monthly':
        MonthlyTransaction().addTransactionToRepeatedBox(transaction);
        break;
      case 'No Repeat':
        NoRepeatTransaction().addTransactionToRepeatedBox(transaction);
        break;
    }
  }




  @override
  Future<void> addTransactionToTransactionBox({required TransactionModel transactionModel})async {


    // final Box<TransactionModel> allExpensesModel = hiveDatabase.getBoxName<TransactionModel>(boxName: AppBoxes.transactionBox);
    final Box<TransactionModel> allIncomeBox = hiveDatabase.getBoxName<TransactionModel>(boxName: AppBoxes.transactionBox);
    if (isEqualToday(date: transactionModel.paymentDate)) {
      print('is equal today in if ?${isEqualToday(date: transactionModel.paymentDate)}');
      // await allExpensesModel.add(expenseModel);
      await allIncomeBox.put(transactionModel.id,transactionModel).then(
              (_) {
            if(transactionModel.amount==allIncomeBox.get(transactionModel.id)?.amount){
              super.plusBalance(amount:transactionModel.amount!);
            }
          });
      print("name of the value added by  key is ${allIncomeBox.get(transactionModel.id)!.name} and key is ${allIncomeBox.get(transactionModel.id)!.id}");

      addTransactions(
          transaction: transactionModel);
    } else {
      print('is  equal today in else  ?${isEqualToday(date: transactionModel.paymentDate)}');

      addTransactions(
          transaction: transactionModel);
    }
    print('Income values are ${allIncomeBox.values}');
  }

  @override
  List<TransactionModel> getTransactionFromTransactionBox(bool isExpense) {
    return HiveHelper().getBoxName<TransactionModel>(boxName: AppBoxes.transactionBox)
        .values
        .cast<TransactionModel>().where((element) => element.isExpense==isExpense).toList();
  }

  @override
  List<TransactionRepeatDetailsModel> getTransactionTypeList(int currentIndex) {
    List<List<TransactionRepeatDetailsModel>> expenseTypesList = [];
    expenseTypesList = [
      DailyTransaction().getRepeatedTransactions(isExpense: false),
      WeeklyTransaction().getRepeatedTransactions(isExpense: false),
      MonthlyTransaction().getRepeatedTransactions(isExpense: false),
      NoRepeatTransaction().getRepeatedTransactions(isExpense: false),
    ];

    return expenseTypesList[currentIndex];
  }
}
