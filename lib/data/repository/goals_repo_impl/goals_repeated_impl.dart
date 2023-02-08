import 'package:hive/hive.dart';
import 'package:temp/business_logic/repository/goals_repo/goals_repeated_repo.dart';
import 'package:temp/data/local/hive/app_boxes.dart';
import 'package:temp/data/models/goals/goal_model.dart';
import 'package:temp/data/models/goals/repeated_goal_model.dart';
import 'package:temp/data/repository/goals_repo_impl/mixin_goals.dart';

class GoalsRepeatedImpl extends GoalsRepeatedRepo with MixinGoals{
  @override
  Future<void> addGoalToRepeatedBox(GoalModel goalModel)async {
    GoalRepeatedDetailsModel dailyDetails =
    GoalRepeatedDetailsModel.copyWith(
      goalLastConfirmationDate: today,
      goalIsLastConfirmed: false,
      goal: goalModel,
      goalLastShownDate:today ,
      nextShownDate: putNextShownDateFirstAdd(
          startSavingDate: goalModel.goalStartSavingDate, repeatType: goalModel.goalSaveAmountRepeat),
    );

    final Box<GoalRepeatedDetailsModel> goalRepeatedBox =
    hiveDatabase.getBoxName<GoalRepeatedDetailsModel>(
        boxName: AppBoxes.goalRepeatedBox);

    await goalRepeatedBox.put(goalModel.id, dailyDetails);

    print("key is ${dailyDetails.key}");

    print('goal Daily List add ${goalRepeatedBox.length}');
  }

  @override
  List<GoalRepeatedDetailsModel> getRepeatedGoals() {

    return getRepeatedGoalsFromRepeatBox();

  }

  @override
  Future<void> deleteGoalToRepeatedBox(GoalModel goalModel) async{
  await goalModel.delete();
  }

}

