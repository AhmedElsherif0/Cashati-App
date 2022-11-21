import 'package:hive/hive.dart';
import 'goal_model.dart';

part 'weekly_goal_model.g.dart';

@HiveType(typeId: 11)
class WeeklyGoalModel {
  WeeklyGoalModel();

  WeeklyGoalModel.copyWith({
    required this.weeklyGoalModel,
    required this.nextShownDate,
    required this.goalCreationDate,
    required this.goalIsLastConfirmed,
    required this.goalLastConfirmationDate,
    required this.goalLastShownDate,
    required this.goalStartSavingDate,
  });

  @HiveField(0)
  late GoalModel weeklyGoalModel;
  @HiveField(1)
  late bool goalIsLastConfirmed;
  @HiveField(2)
  late DateTime goalLastShownDate;
  @HiveField(3)
  late DateTime nextShownDate;
  @HiveField(4)
  late DateTime goalLastConfirmationDate;
  @HiveField(5)
  late DateTime goalCreationDate;
  @HiveField(6)
  late DateTime goalStartSavingDate;
}
