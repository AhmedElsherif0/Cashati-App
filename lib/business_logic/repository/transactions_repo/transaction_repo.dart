import '../../../data/models/transactions/transaction_model.dart';

abstract class TransactionRepo {
  Future<void> addTransactionToTransactionBox(
      {required TransactionModel transactionModel});

  void addTransactions({required TransactionModel transaction});

  List<TransactionModel> getTransactionTypeList(int currentIndex);

  List<TransactionModel> getTransactionFromTransactionBox({bool isExpense});

  Future<void> deleteTransactionRepo(TransactionModel transaction);

  TransactionModel getTransactionByNameFromRepeated(
      String transactionName, bool isExpense, num amount);
}
