import 'package:hive/hive.dart';
import 'income_repeat_details_model.dart';

part 'income_types_model.g.dart';

@HiveType(typeId: 5)
class MonthlyIncomeModel {
  MonthlyIncomeModel();

  @HiveField(0)
  late List<IncomeRepeatDetailsModel> dailyExpense;
  @HiveField(1)
  late List<IncomeRepeatDetailsModel> weeklyExpense;
  @HiveField(2)
  late List<IncomeRepeatDetailsModel> monthlyExpense;
  @HiveField(3)
  late List<IncomeRepeatDetailsModel> noRepeatExpense;
}
