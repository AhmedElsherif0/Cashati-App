import 'package:hive/hive.dart';
import 'goal_model.dart';

part 'repeated_goal_model.g.dart';

@HiveType(typeId: 10)
class GoalRepeatedDetailsModel extends HiveObject{
  GoalRepeatedDetailsModel();

  GoalRepeatedDetailsModel.copyWith({
    required this.goal,
    required this.nextShownDate,
    required this.goalIsLastConfirmed,
    required this.goalLastConfirmationDate,
    required this.goalLastShownDate,
  });

  @HiveField(0)
  late GoalModel goal;
  @HiveField(1)
  late bool goalIsLastConfirmed;
  @HiveField(2)
  late DateTime goalLastShownDate;
  @HiveField(3)
  late DateTime nextShownDate;
  @HiveField(4)
  late DateTime goalLastConfirmationDate;


}
