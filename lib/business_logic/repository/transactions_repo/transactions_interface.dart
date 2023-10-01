import 'package:temp/data/models/transactions/transaction_model.dart';

abstract class ITransactions {
  Future<void> addTransactionToRepeatedBox(TransactionModel transactionModel);

  List<TransactionModel> getRepeatedTransactions({required bool isExpense});
}
