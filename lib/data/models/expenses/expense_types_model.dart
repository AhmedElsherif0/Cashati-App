import 'package:hive/hive.dart';

import 'expense_details_model.dart';

part 'expense_types_model.g.dart';

@HiveType(typeId: 2)
class ExpenseRepeatTypes extends HiveObject {

   ExpenseRepeatTypes();

  @HiveField(0)
   List<ExpenseRepeatDetailsModel> dailyExpense =[];
  @HiveField(1)
   List<ExpenseRepeatDetailsModel> weeklyExpense =[];
  @HiveField(2)
   List<ExpenseRepeatDetailsModel> monthlyExpense=[];
  @HiveField(3)
   List<ExpenseRepeatDetailsModel> noRepeatExpense=[];
}
