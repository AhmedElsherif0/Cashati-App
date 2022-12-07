
import '../../../data/models/transactions/transaction_details_model.dart';
import '../../../data/models/transactions/transaction_model.dart';

abstract class TransactionsRepository {

  Future<void> addExpenseToExpensesBox({
    required String name,
    required num amount,
    required String mainCategory,
    required String subCategory,
    required String comment,
    required String repeat,
    required bool isPriority,
    required bool isPaid,
    required DateTime paymentDate,
    required DateTime createdDate,
  });

  void addTransactions(
      {required TransactionModel expenseModel, required String choseRepeat});

  List<TransactionRepeatDetailsModel> getExpenseTypeList(int currentIndex);

}
