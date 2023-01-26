import 'package:hive/hive.dart';
import 'package:temp/business_logic/repository/goals_repo/goals_repo.dart';
import 'package:temp/data/local/hive/app_boxes.dart';
import 'package:temp/data/models/goals/goal_model.dart';
import 'package:temp/data/repository/goals_repo_impl/mixin_goals.dart';

class GoalsRepoImpl with MixinGoals implements GoalsRepository {
  GoalsRepoImpl();

  @override
  Future<void> addGoal({required GoalModel goalModel}) async {
    final Box<GoalModel> goalsBox =
        hiveDatabase.getBoxName<GoalModel>(boxName: AppBoxes.goalModel);
    if (isEqualToday(date: goalModel.goalStartSavingDate)) {
      print(
          'is equal today in if ?${isEqualToday(date: goalModel.goalStartSavingDate)}');
      // await allExpensesModel.add(expenseModel);
      await goalsBox.put(goalModel.id, goalModel);
      await filterAndAddGoalsByRepeat(goalModel: goalModel);
      print(
          "name of the value added by  key is ${goalsBox.get(goalModel.id)!.goalName} and key is ${goalsBox.get(goalModel.id)!.id} \n and Date of today is ${today} and date of choosen");
    } else {
      print(
          'is  equal today in else  ?${isEqualToday(date: goalModel.goalStartSavingDate)}');
      await filterAndAddGoalsByRepeat(goalModel: goalModel);
    }
    print('Goals values are ${goalsBox.values}');
  }

  @override
  List<GoalModel> getGoals() {
    return getGoalsFromGoalsBox();
  }
}
