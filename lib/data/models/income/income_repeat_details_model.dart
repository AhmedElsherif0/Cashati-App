import 'package:hive/hive.dart';
import 'income_model.dart';

part 'income_repeat_details_model.g.dart';

@HiveType(typeId: 4)
class IncomeRepeatDetailsModel {
  IncomeRepeatDetailsModel();

  IncomeRepeatDetailsModel.copyWith({
    required this.incomeModel,
    required this.lastConfirmationDate,
    required this.nextShownDate,
    required this.lastShownDate,
    required this.isLastConfirmed,
    required this.creationDate,
  });

  @HiveField(0)
  late IncomeModel incomeModel;
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
