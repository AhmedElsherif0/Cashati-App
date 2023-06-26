import 'package:temp/data/models/transactions/transaction_model.dart';
import '../../../data/models/transactions/transaction_details_model.dart';

abstract class ITransactions {
  Future<void> addTransactionToRepeatedBox(TransactionModel transactionModel);

  List<TransactionModel> getRepeatedTransactions(
      {required bool isExpense});
}
