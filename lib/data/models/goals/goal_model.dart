import 'package:hive/hive.dart';

part 'goal_model.g.dart';

@HiveType(typeId: 3)
class GoalModel extends HiveObject{
  GoalModel();

  GoalModel.copyWith({
    required this.goalComment,
    required this.goalCreatedDay,
    required this.id,
    required this.goalName,
    required this.goalRemainingAmount,
    required this.goalRemainingPeriod,
    required this.goalSaveAmount,
    required this.goalSaveAmountRepeat,
    required this.goalTotalAmount,
    required this.goalStartSavingDate,
    required this.goalCompletionDate,

  });

  @HiveField(0)
  late String id;
  @HiveField(1)
  late String goalName;
  @HiveField(2)
  late num goalTotalAmount;
  @HiveField(3)
  late num goalSaveAmount;
  @HiveField(4)
  late num goalRemainingAmount;
  @HiveField(5)
  late String goalSaveAmountRepeat;
  @HiveField(6)
  late String goalComment;
  @HiveField(7)
  late int goalRemainingPeriod;
  @HiveField(8)
  late DateTime goalCreatedDay;
  @HiveField(9)
  late DateTime goalStartSavingDate;
  @HiveField(10)
  late DateTime goalCompletionDate;
}
