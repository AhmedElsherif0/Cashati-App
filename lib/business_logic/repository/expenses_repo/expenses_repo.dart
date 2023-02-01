
import '../../../data/models/transactions/transaction_details_model.dart';
import '../../../data/models/transactions/transaction_model.dart';

abstract class ExpenseRepository {

  Future<void> addExpenseToTransactionBox({
    required TransactionModel transactionModel
  });

  void addTransactions(
      {required TransactionModel expenseModel, required String choseRepeat});

 List<TransactionRepeatDetailsModel> getExpenseTypeList(int currentIndex);

 List<TransactionModel> getExpensesFromTransactionBox();

}
