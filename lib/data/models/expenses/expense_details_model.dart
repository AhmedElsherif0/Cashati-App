import 'package:hive/hive.dart';
import 'expense_model.dart';

part 'expense_details_model.g.dart';

@HiveType(typeId: 1)
class ExpenseRepeatDetailsModel extends HiveObject{
  ExpenseRepeatDetailsModel();
  ExpenseRepeatDetailsModel.copyWith({
    required this.lastConfirmationDate,
    required this.isLastConfirmed,
    required this.creationDate,
    required this.expenseModel,
    required this.lastShownDate,
    required this.nextShownDate,
});
  @HiveField(0)
  late ExpenseModel expenseModel;
  @HiveField(1)
  late bool isLastConfirmed;
  @HiveField(2)
  late DateTime lastShownDate;
  @HiveField(3)
  late DateTime nextShownDate;
  @HiveField(4)
  late DateTime lastConfirmationDate;
  @HiveField(5)
  late DateTime creationDate;
}
