import 'package:temp/business_logic/repository/goals_repo/goals_repo.dart';
import 'package:temp/constants/app_strings.dart';
import 'package:temp/data/models/goals/goal_model.dart';
import 'package:temp/data/models/goals/repeated_goal_model.dart';
import 'package:temp/data/repository/general_stats_repo_impl/general_stats_repo_impl.dart';
import 'package:temp/data/repository/goals_repo_impl/mixin_goals.dart';

class GoalsRepoImpl with GeneralStatsRepoImpl, MixinGoals implements GoalsRepository {
  @override
  Future<void> addGoal({required GoalModel goalModel}) async {
    if (isEqualToday(date: goalModel.goalStartSavingDate)) {
      print(
          'is equal today in if ?${isEqualToday(date: goalModel.goalStartSavingDate)}');
      // await allExpensesModel.add(expenseModel);
      await goalBox.put(goalModel.id, goalModel).then((_) {
        if (goalModel.goalSaveAmount == goalBox.get(goalModel.id)?.goalSaveAmount) {
          super.minusBalance(amount: goalModel.goalSaveAmount);
        }
      });
      await addGoalToRepeatedBox(goalModel);
      print(
          "name of the value added by  key is ${goalBox.get(goalModel.id)!.goalName} and key is ${goalBox.get(goalModel.id)!.id} \n and Date of today is $today and date of choosen");
    } else {
      print(
          'is  equal today in else  ?${isEqualToday(date: goalModel.goalStartSavingDate)}');
      await addGoalToRepeatedBox(goalModel);
    }
    print('Goals values are ${goalBox.values}');
  }

  @override
  List<GoalModel> getGoals() {
    return getGoalsFromGoalsBox();
  }

  @override
  Future<void> deleteGoalFromGoalsBox(GoalModel goalModel) async {
    try {
     // await goalModel.delete();
      await goalRepeatedBox.delete(goalModel.id);
      await goalBox.delete(goalModel.id);
    } catch (e) {
      print('Error normal ${e.toString()}');
    }
  }

  @override
  Future<void> noConfirmGoal({required GoalModel goalModel, num? newAmount}) async {
    try {
      if (goalModel.goalSaveAmountRepeat == AppStrings.daily) {
        GoalRepeatedDetailsModel theEditedDailyGoal =
            editDailyGoalLastShown(goalModel: goalModel);
        await saveDailyGoalNoConfirm(theEditedDailyGoal);
      }
      if (goalModel.goalSaveAmountRepeat == AppStrings.weekly) {
        GoalRepeatedDetailsModel theMatchingWeeklyGoal =
            editWeeklyGoalLastShown(goalModel: goalModel, today: today);
        await saveWeeklyGoalNoConfirm(theMatchingWeeklyGoal);
      }
      if (goalModel.goalSaveAmountRepeat == AppStrings.monthly) {
        GoalRepeatedDetailsModel theEditedMonthlyGoal =
            editMonthlyGoalLastShown(goalModel: goalModel, today: today);
        await saveMonthlyGoalNoConfirm(theEditedMonthlyGoal);
      }
    } catch (error) {
      print('Error in no confirm goal is ${error.toString()}');
    }
  }

  @override
  Future<void> yesConfirmGoal({required GoalModel goalModel, num? newAmount}) async {
    print('working yes ..');
    try {
      if (goalModel.goalSaveAmountRepeat == AppStrings.daily) {
        GoalRepeatedDetailsModel theEditedDailyGoal =
            editDailyGoalLastShown(goalModel: goalModel);
        await saveDailyGoalAndAddToRepeatBox(
                theMatchingGoalinRep: theEditedDailyGoal, newAmount: newAmount)
            .then((_) {
          print("goal id ${goalModel.id}");
          print("the matching goal  id ${theEditedDailyGoal.goal.id}");
          //TODO remove that condition as save amount can be changed according to user payment
          if (goalModel.goalSaveAmount == goalBox.get(goalModel.id)?.goalSaveAmount) {
            super.minusBalance(amount: goalModel.goalSaveAmount);
          }
        });
        // print('After Edit Daily ${theMatchingDailyExpense.lastConfirmationDate}');
      }
      if (goalModel.goalSaveAmountRepeat == AppStrings.weekly) {
        GoalRepeatedDetailsModel theEditedWeeklyGoal =
            editWeeklyGoalLastShown(goalModel: goalModel, today: today);
        await saveWeeklyGoalAndAddToRepeatBox(
                theMatchingWeeklyExpenseModel: theEditedWeeklyGoal,
                newAmount: newAmount)
            .then((_) {
          if (goalModel.goalSaveAmount == goalBox.get(goalModel.id)?.goalSaveAmount) {
            super.minusBalance(amount: goalModel.goalSaveAmount);
          }
        });
      }
      if (goalModel.goalSaveAmountRepeat == AppStrings.monthly) {
        GoalRepeatedDetailsModel theEditedMonthlyGoal =
            editMonthlyGoalLastShown(goalModel: goalModel, today: today);
        saveMonthlyGoalAndAddToRepeatBox(
                theMatchingMonthlyExpenseModel: theEditedMonthlyGoal,
                NewAmount: newAmount)
            .then((_) {
          if (goalModel.goalSaveAmount == goalBox.get(goalModel.id)?.goalSaveAmount) {
            super.minusBalance(amount: goalModel.goalSaveAmount);
          }
        });
      }
    } catch (error) {
      print('Error in yes confirm goal is ${error.toString()}');
    }
  }

  @override
  List<GoalModel> getTodayGoals() {
    List<GoalModel> todayList = [];

    List<GoalRepeatedDetailsModel> repeatedGoals = getRepeatedGoalsFromRepeatBox();
    for (var item in repeatedGoals) {
      // here we check confirmation date  Slide number 12
      switch (item.goal.goalSaveAmountRepeat) {
        case (AppStrings.daily):
          if (dailyShowChecking(item)) {
            todayList.add(item.goal);
          }
          break;
        case (AppStrings.weekly):
          if (weeklyShowChecking(item)) {
            todayList.add(item.goal);
          }
          break;
        case (AppStrings.monthly):
          if (monthlyShowChecking(item)) {
            todayList.add(item.goal);
          }
          break;
      }
    }
    return todayList;
  }

  @override
  List<GoalRepeatedDetailsModel> fetchRepeatedGoals() {
    return getRepeatedGoalsFromRepeatBox();
  }
}
