import 'package:hive/hive.dart';
import 'package:temp/data/models/transactions/transaction_details_model.dart';


part 'transaction_types_model.g.dart';

@HiveType(typeId: 2)
class TransactionRepeatTypes extends HiveObject{

   TransactionRepeatTypes();

  @HiveField(0)
   List<TransactionRepeatDetailsModel> dailyExpense =[];
  @HiveField(1)
   List<TransactionRepeatDetailsModel> weeklyExpense =[];
  @HiveField(2)
   List<TransactionRepeatDetailsModel> monthlyExpense=[];
  @HiveField(3)
   List<TransactionRepeatDetailsModel> noRepeatExpense=[];
}
