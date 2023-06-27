import 'package:hive/hive.dart';
import 'package:temp/data/local/hive/app_boxes.dart';
import 'package:temp/data/local/hive/hive_database.dart';
import 'package:temp/data/repository/general_stats_repo_impl/general_stats_repo_impl.dart';
import 'package:temp/data/repository/transactions_impl/mixin_transaction.dart';

import '../../../business_logic/repository/transactions_repo/transaction_repo.dart';
import '../../models/transactions/transaction_details_model.dart';
import '../../models/transactions/transaction_model.dart';
import '../transactions_impl/transaction_impl.dart';

class ExpensesRepositoryImpl
    with GeneralStatsRepoImpl, MixinTransaction
    implements TransactionRepo {
  ExpensesRepositoryImpl();

  @override
  Future<void> addTransactionToTransactionBox(
      {required TransactionModel transactionModel}) async {
    final Box<TransactionModel> allExpensesModel =
        hiveDatabase.getBoxName<TransactionModel>(boxName: AppBoxes.transactionBox);
    if (isEqualToday(date: transactionModel.paymentDate)) {
      print('is equal today in if ?'
          '${isEqualToday(date: transactionModel.paymentDate)}');
      // await allExpensesModel.add(expenseModel);

      addTransactions(transaction: transactionModel);
      await allExpensesModel.put(transactionModel.id, transactionModel).then((_) {
        if (transactionModel.amount ==
            allExpensesModel.get(transactionModel.id)?.amount) {
          super.minusBalance(amount: transactionModel.amount);
        }
      });
      print("name of the value added by  key is "
          "${allExpensesModel.get(transactionModel.id)!.name} "
          "and key is ${allExpensesModel.get(transactionModel.id)!.id}");
    } else {
      print(
          'is  equal today in else  ?${isEqualToday(date: transactionModel.paymentDate)}');
      addTransactions(transaction: transactionModel);
    }
    print('Expenses values are ${allExpensesModel.values}');
  }

  @override
  void addTransactions({required TransactionModel transaction}) {
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
  List<TransactionModel> getTransactionTypeList(int currentIndex) {
    List<List<TransactionModel>> expenseTypesList = [];
    expenseTypesList = [
      DailyTransaction().getRepeatedTransactions(isExpense: true),
      WeeklyTransaction().getRepeatedTransactions(isExpense: true),
      MonthlyTransaction().getRepeatedTransactions(isExpense: true),
      NoRepeatTransaction().getRepeatedTransactions(isExpense: true),
    ];
    return expenseTypesList[currentIndex];
  }

  @override
  List<TransactionModel> getTransactionFromTransactionBox({bool isExpense = true}) {
    return HiveHelper()
        .getBoxName<TransactionModel>(boxName: AppBoxes.transactionBox)
        .values
        .cast<TransactionModel>()
        .where((element) => element.isExpense == isExpense)
        .toList();
  }
}
