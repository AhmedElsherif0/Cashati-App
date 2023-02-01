import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:temp/data/local/hive/app_boxes.dart';
import 'package:temp/data/local/hive/hive_database.dart';
import 'package:temp/data/models/goals/goal_model.dart';
import 'package:temp/data/models/goals/repeated_goal_model.dart';
import 'package:temp/data/repository/goals_repo_impl/goals_repeated_impl.dart';

mixin MixinGoals{

  final HiveHelper _hiveDatabase = HiveHelper();
  final DateTime _today = DateTime.now();

  get hiveDatabase => _hiveDatabase;


  get today => _today;

  get putNextShownDate => _putNextShownDate;
  DateTime _putNextShownDate(
      {required DateTime startSavingDate, required String repeatType}) {
    switch (repeatType) {
    //TODO when we reach confirm stage , we need to check this case as it is supposed to be +1

      case 'Daily':
        return startSavingDate;
      case 'Weekly':

        if (
        //TODO when we reach confirm stage , we need to check this case as check same day only compares day

        checkSameDay(date: startSavingDate)) {
          return startSavingDate.add(const Duration(days: 7));
        } else {
          // return expensePaymentDate.add(Duration(days: 7));
          // the right return is below
          return startSavingDate;
        }
      case 'Monthly':
        if (
        //expensePaymentDate.difference(today).inDays==0
        checkSameDay(date: startSavingDate)) {
          return startSavingDate.add(const Duration(days: 30));
        } else {
          return startSavingDate;
        }
      case 'No Repeat':
        return startSavingDate;

      default:
        return _today;
    }
  }

  bool isEqualToday({required DateTime date}) {
    return (today.day == date.day &&
        today.month == date.month &&
        today.year == date.year)
        ? true
        : false;
  }

  bool checkSameDay({required DateTime date}) {
    int currentTime = DateTime.now().day;
    return date.day == currentTime ? true : false;
  }

  List<GoalRepeatedDetailsModel> getRepeatedGoalsByBoxName(String boxName) {
    List<GoalRepeatedDetailsModel> repeatedGoals = [];
    try {
      ///get box name first
      Box<GoalRepeatedDetailsModel> expenseBox = _hiveDatabase
          .getBoxName<GoalRepeatedDetailsModel>(boxName: boxName);

      /// get data from box and assign it to dailyExpense List.
      repeatedGoals = expenseBox.values.toList();
      print('the length :${repeatedGoals.length}');
    } catch (error) {
      print('new error ${error.toString()}');
    }
    return repeatedGoals;
  }
  List<GoalModel> getGoalsFromGoalsBox() {
    List<GoalModel> goalsGroup = [];
    try {
      ///get box name first
      Box<GoalModel> goalsBox = _hiveDatabase
          .getBoxName<GoalModel>(boxName: AppBoxes.goalModel);

      /// get data from box and assign it to dailyExpense List.
      goalsGroup = goalsBox.values.toList();
      print('the length :${goalsBox.length}');
    } catch (error) {
      print('new error ${error.toString()}');
    }
    return goalsGroup;
  }


  Future<void> filterAndAddGoalsByRepeat(
      {required GoalModel goalModel})async {
    await GoalsRepeatedImpl().addGoalToRepeatedBox(goalModel);

    // switch (goalModel.goalSaveAmountRepeat) {
    //   case 'Daily':
    //     GoalsRepeatedImpl().addGoalToRepeatedBox(goalModel);
    //     break;
    //   case 'Weekly':
    //     GoalsRepeatedImpl().addGoalToRepeatedBox(goalModel);
    //     break;
    //   case 'Monthly':
    //     GoalsRepeatedImpl().addGoalToRepeatedBox(goalModel);
    //     break;
    //   case 'No Repeat':
    //     GoalsRepeatedImpl().addGoalToRepeatedBox(goalModel);
    //     break;
    // }
  }

}