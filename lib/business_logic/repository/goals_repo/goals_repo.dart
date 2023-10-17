import 'package:temp/data/models/goals/goal_model.dart';
import 'package:temp/data/models/goals/repeated_goal_model.dart';
import 'package:temp/data/models/notification/notification_model.dart';

abstract class GoalsRepository {


  Future<void>  addGoal(
      {required GoalModel goalModel});

  List<GoalModel> getGoals();
  Future<void> deleteGoalFromGoalsBox(GoalModel goalModel);

  List<GoalModel> getTodayGoals();
  List<GoalRepeatedDetailsModel> fetchRepeatedGoals();

  Future<void> yesConfirmGoal({required GoalModel goalModel,num? newAmount});
  Future<void> yesConfirmGoalFromNotification({required NotificationModel notificationModel});
  Future<void> noConfirmGoal({required GoalModel goalModel,num? newAmount});


}