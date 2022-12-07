
import '../../../data/models/transactions/transaction_model.dart';

abstract class IncomeRepository {

Future<void> addIncomeToIncomeBox({
  required String name,
  required num amount,
  required String mainCategory,
  required String subCategory,
  required String comment,
  required String repeat,
  required DateTime paymentDate,
  required DateTime createdDate,
});
Future<void> addToRepeatedBoxes(String repeat,TransactionModel incomeModel);

Future addDailyIncomeToRepeatedBox(TransactionModel incomeModel);
Future addWeeklyIncomeToRepeatedBox(TransactionModel incomeModel);
Future addMonthlyIncomeToRepeatedBox(TransactionModel incomeModel);
Future addNoRepeatIncomeToRepeatedBox(TransactionModel incomeModel);

}