
import 'package:temp/data/models/goals/goal_model.dart';
import 'package:temp/data/models/goals/repeated_goal_model.dart';

abstract class GoalsRepeatedRepo {

  Future<void> addGoalToRepeatedBox(GoalModel goalModel);
  List<GoalRepeatedDetailsModel> getRepeatedGoals();

}