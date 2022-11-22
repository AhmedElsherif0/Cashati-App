
import 'package:hive/hive.dart';

import '../../../data/models/expenses/expense_details_model.dart';

abstract class ExpenseRepeatRepo{

 Future<Box>  openExpenseRepeatBox(String boxName);

 List<ExpenseRepeatDetailsModel> getExpenseTypeList(int currentIndex);

}