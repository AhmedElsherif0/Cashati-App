import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:temp/business_logic/repository/goals_repo/goals_repeated_repo.dart';
import 'package:temp/business_logic/repository/goals_repo/goals_repo.dart';
import 'package:temp/data/models/goals/goal_model.dart';
import 'package:temp/data/models/goals/repeated_goal_model.dart';
import 'package:temp/data/repository/goals_repo_impl/goals_repeated_impl.dart';
import 'package:temp/data/repository/goals_repo_impl/goals_repo_impl.dart';

part 'goals_state.dart';

class GoalsCubit extends Cubit<GoalsState> {
  GoalsCubit() : super(GoalsInitial());
  String choseRepeat = 'Choose Repeat';
  String choseFilter = 'All';
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
  List<DropdownMenuItem<String>> goalsFilterDropDown = [
    DropdownMenuItem(child: Text('Completed'), value: 'Completed'),
    DropdownMenuItem(child: Text('UnCompleted'), value: 'UnCompleted'),
    DropdownMenuItem(
      child: Text('All'),
      value: 'All',
    ),
  ];

  chooseRepeat(String value) {
    choseRepeat = value;
    emit(ChoosedRepeatState());
  }

  chooseFilter(String value) {
    choseFilter = value;
    fetchAllGoals();
    emit(ChoosedGoalFilterState());
  }

  Future addGoal({required GoalModel goalModel}) async {
    await _goalsRepository.addGoal(goalModel: goalModel);
  }

  void fetchAllGoals() {
    switch (choseFilter) {
      case 'All':
        goals = _goalsRepository.getGoals();
        break;
      case 'Completed':
        goals = _goalsRepository
            .getGoals()
            .where((element) => element.goalRemainingAmount == 0)
            .toList();
        break;
      case 'UnCompleted':
        goals = _goalsRepository
            .getGoals()
            .where((element) => element.goalRemainingAmount != 0)
            .toList();
        break;
    }
    emit(FetchedGoals());
  }

  void fetchRepeatedGoals() {
    goalsRepeated = _goalsRepeatedRepo.getRepeatedGoals();
    emit(FetchedRepeatedGoals());
  }

  int remainingTimes({required num cost, required num dailySaving}) {
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
        return startSavingDate.add(Duration(days: remainingTime * 30));
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

  String transferDateToString(GoalModel goalModel) {
    final completionDate = countCompletionDate(goalModel.goalSaveAmountRepeat,
        goalModel.goalStartSavingDate, goalModel.goalRemainingPeriod);
    return '${completionDate.day}\\${completionDate.month}\\${completionDate.year}';
  }

  String dialogMessage(GoalModel goalModel) {
    return 'You Will Achieve your Goal On ${transferDateToString(goalModel)} ';
  }

  Future<void> deleteGoal(GoalModel goalModel) async {
    await _goalsRepository.deleteGoalFromGoalsBox(goalModel);
    fetchAllGoals();
  }
}
