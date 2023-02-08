import 'package:temp/data/models/transactions/transaction_model.dart';
import '../../../data/models/transactions/transaction_details_model.dart';

abstract class ConfirmTransactionRepo {


  List<TransactionModel> getTodayPayments({required bool isExpense});

  Future deleteNoRepeatTransaction(
      TransactionRepeatDetailsModel theMatchingNoRepExpenseModel);

  Future<void> onYesConfirmed(
      { required TransactionModel addedExpense});

  Future<void> onNoConfirmed(
      { required TransactionModel addedExpense});
}
