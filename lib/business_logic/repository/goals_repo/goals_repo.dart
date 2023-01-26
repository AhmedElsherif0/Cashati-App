import 'package:temp/data/models/goals/goal_model.dart';

abstract class GoalsRepository {


  Future<void>  addGoal(
      {required GoalModel goalModel});

  List<GoalModel> getGoals();


}