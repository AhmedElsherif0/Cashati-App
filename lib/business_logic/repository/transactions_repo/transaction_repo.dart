
import '../../../data/models/transactions/transaction_details_model.dart';
import '../../../data/models/transactions/transaction_model.dart';

abstract class TransactionRepo {

  Future<void> addTransactionToTransactionBox({
    required TransactionModel transactionModel
  });

  void addTransactions(
      {required TransactionModel transaction});

 List<TransactionRepeatDetailsModel> getTransactionTypeList(int currentIndex);

 List<TransactionModel> getTransactionFromTransactionBox({bool isExpense});

}
