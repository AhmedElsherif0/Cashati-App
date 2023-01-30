import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:temp/business_logic/repository/goals_repo/goals_repeated_repo.dart';
import 'package:temp/business_logic/repository/goals_repo/goals_repo.dart';
import 'package:temp/constants/app_strings.dart';
import 'package:temp/data/models/goals/goal_model.dart';
import 'package:temp/data/models/goals/repeated_goal_model.dart';
import 'package:temp/data/repository/goals_repo_impl/goals_repeated_impl.dart';
import 'package:temp/data/repository/goals_repo_impl/goals_repo_impl.dart';

part 'goals_state.dart';

class GoalsCubit extends Cubit<GoalsState> {
  GoalsCubit() : super(GoalsInitial());
  String choseRepeat = 'Choose Repeat';
  DateTime? chosenDate;

  GoalsRepeatedRepo _goalsRepeatedRepo = GoalsRepeatedImpl();
  GoalsRepository _goalsRepository = GoalsRepoImpl();
  List<GoalModel> goals = [];
  List<GoalRepeatedDetailsModel> goalsRepeated = [];

  List<DropdownMenuItem<String>> dropDownChannelItems = [
    DropdownMenuItem(child: Text('Daily'), value: 'Daily'),
    DropdownMenuItem(child: Text('Weekly'), value: 'Weekly'),
    DropdownMenuItem(
      child: Text('Monthly'),
      value: 'Monthly',
    ),
  ];

  chooseRepeat(String value) {
    choseRepeat = value;
    emit(ChoosedRepeatState());
  }

  Future addGoal({required GoalModel goalModel}) async {
    await _goalsRepository.addGoal(goalModel: goalModel);
  }

  void fetchAllGoals() {
    goals = _goalsRepository.getGoals();
    emit(FetchedGoals());
  }

  void fetchRepeatedGoals() {
    goalsRepeated = _goalsRepeatedRepo.getRepeatedGoals();
    emit(FetchedRepeatedGoals());
  }

  int remainingTimes({
    required num cost,
    required num dailySaving,
  }) {
    return (cost / dailySaving).toInt();
  }

  DateTime getCompletionDate(
      {required num cost,
      required num dailySavings,
      required String repeat,
      required DateTime startSavingDate}) {
    final remainingTime =
        remainingTimes(cost: cost, dailySaving: dailySavings).toInt();
    return countCompletionDate(repeat, startSavingDate, remainingTime);
  }

  DateTime countCompletionDate(
      String repeat, DateTime startSavingDate, int remainingTime) {
    switch (repeat) {
      case 'Daily':
        return startSavingDate.add(Duration(days: remainingTime));
      case 'Weekly':
        return startSavingDate.add(Duration(days: remainingTime * 7));
      case 'Monthly':
        return startSavingDate
            .add(Duration(days: remainingTime * DateTime.now().month));
      default:
        return startSavingDate.add(Duration(days: remainingTime));
    }
  }

  Future<void> changeDate(BuildContext context) async {
    chosenDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    emit(ChoseDateState());
  }
  String transferDateToString(GoalModel goalModel){
    final completionDate=countCompletionDate(goalModel.goalSaveAmountRepeat, goalModel.goalStartSavingDate,goalModel.goalRemainingPeriod);
    return '${completionDate.day}\\${completionDate.month}\\${completionDate.year}';
  }

  String dialogMessage(GoalModel goalModel) {
    switch (goalModel.goalSaveAmountRepeat) {
      case AppStrings.daily:
        //  return 'You Will Achieve your Goal After ${goalModel.goalRemainingPeriod} Days';
        // return 'You Will Achieve your Goal On ${DateTime.now().add(Duration(days: goalModel.goalRemainingPeriod))} Days';
        return 'You Will Achieve your Goal On ${transferDateToString(goalModel)} ';
      case AppStrings.weekly:
        return 'You Will Achieve your Goal After ${goalModel.goalRemainingPeriod} Weeks';
      case AppStrings.monthly:
        return 'You Will Achieve your Goal After ${goalModel.goalRemainingPeriod} Months';
      default:
        return 'You Will Achieve your Goal After ${goalModel.goalRemainingPeriod} Days';
    }
  }
}
