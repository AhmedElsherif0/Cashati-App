import 'package:temp/data/models/goals/goal_model.dart';

abstract class GoalsRepository {


  Future<void>  addGoal(
      {required GoalModel goalModel});

  List<GoalModel> getGoals();
  Future<void> deleteGoalFromGoalsBox(GoalModel goalModel);

  List<GoalModel> getTodayGoals();

  Future<void> yesConfirmGoal({required GoalModel goalModel,num? newAmount});
  Future<void> noConfirmGoal({required GoalModel goalModel,num? newAmount});


}