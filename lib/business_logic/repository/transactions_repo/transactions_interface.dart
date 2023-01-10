import 'package:temp/data/models/transactions/transaction_model.dart';
import '../../../data/models/transactions/transaction_details_model.dart';

abstract class ITransactions {

  void addTransactionToRepeatedBox(TransactionModel expenseModel);
  List<TransactionRepeatDetailsModel> getRepeatedTransactions();

}
