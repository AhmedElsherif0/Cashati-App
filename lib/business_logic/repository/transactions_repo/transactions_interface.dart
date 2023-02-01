import 'package:temp/data/models/transactions/transaction_model.dart';
import '../../../data/models/transactions/transaction_details_model.dart';

abstract class ITransactions {
  Future<void> addTransactionToRepeatedBox(TransactionModel transactionModel);

  List<TransactionRepeatDetailsModel> getRepeatedTransactions(
      {required bool isExpense});
}
