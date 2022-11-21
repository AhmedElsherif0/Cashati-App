
import 'package:hive/hive.dart';

import '../../../data/models/expenses/expense_details_model.dart';

abstract class ExpenseRepeatRepo{

 Future<Box>  openExpenseRepeatBox();


 List<ExpenseRepeatDetailsModel> getRepeatDaily();
 List<ExpenseRepeatDetailsModel> getRepeatWeekly();
 List<ExpenseRepeatDetailsModel> getRepeatMonthly();
 List<ExpenseRepeatDetailsModel> getRepeatNoRepeat();

}