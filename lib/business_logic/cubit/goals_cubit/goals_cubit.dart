import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:temp/business_logic/repository/goals_repo/goals_repo.dart';
import 'package:temp/data/models/goals/goal_model.dart';
import 'package:temp/data/models/goals/repeated_goal_model.dart';
import 'package:temp/data/repository/goals_repo_impl/goals_repo_impl.dart';

import '../../../constants/app_strings.dart';

part 'goals_state.dart';

class GoalsCubit extends Cubit<GoalsState> {
  GoalsCubit() : super(GoalsInitial());
  String choseRepeat = AppStrings.day.tr();
  String choseFilter = AppStrings.all.tr();
  DateTime? chosenDate;
  final DateTime today = DateTime.now();

  final GoalsRepository _goalsRepository = GoalsRepoImpl();
  List<GoalModel> goals = [];
  List<GoalRepeatedDetailsModel> goalsRepeated = [];
  List<GoalRepeatedDetailsModel> registeredGoals = [];

  List<DropdownMenuItem<String>> dropDownChannelItems = [
    DropdownMenuItem(value: AppStrings.day.tr(), child: Text(AppStrings.day.tr())),
    DropdownMenuItem(value: AppStrings.week.tr(), child: Text(AppStrings.week.tr())),
    DropdownMenuItem(value: AppStrings.month.tr(), child: Text(AppStrings.month.tr()))
  ];
  List<DropdownMenuItem<String>> goalsFilterDropDown = [
    DropdownMenuItem(
        value: AppStrings.completed.tr(), child: Text(AppStrings.completed.tr())),
    DropdownMenuItem(
        value: AppStrings.unCompleted.tr(), child: Text(AppStrings.unCompleted.tr())),
    DropdownMenuItem(value: AppStrings.all.tr(), child: Text(AppStrings.all.tr())),
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
    //TODO remove normal goals from the function as screen depends on repeated goals and check after confirm
    switch (choseFilter) {
      case 'All':
      case 'الكل':
        goals = _goalsRepository.getGoals();
        registeredGoals = _goalsRepository.fetchRepeatedGoals();
        break;
      case 'Completed':
      case 'المكتمل':
        goals = _goalsRepository
            .getGoals()
            .where((element) => element.goalRemainingAmount == 0)
            .toList();
        registeredGoals = _goalsRepository
            .fetchRepeatedGoals()
            .where((element) => element.goal.goalRemainingAmount == 0)
            .toList();

        break;
      case 'UnCompleted':
      case 'الغير مكتملة':
        goals = _goalsRepository
            .getGoals()
            .where((element) => element.goalRemainingAmount != 0)
            .toList();
        registeredGoals = _goalsRepository
            .fetchRepeatedGoals()
            .where((element) => element.goal.goalRemainingAmount != 0)
            .toList();
        break;
    }
    emit(FetchedGoals());
  }

  void fetchRepeatedGoals() {
    goalsRepeated = _goalsRepository.fetchRepeatedGoals();
    emit(FetchedRepeatedGoals());
  }

  int remainingTimes({required num cost, required num dailySaving}) =>
      cost ~/ dailySaving;

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
      case 'اليومية':
        return startSavingDate.add(Duration(days: remainingTime));
      case 'Weekly':
      case 'الاسبوعية':
        return startSavingDate.add(Duration(days: remainingTime * 7));
      case 'Monthly':
      case 'الشهرية':
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

  String dialogMessage({required num cost, required num dailySaving}) {
    switch (choseRepeat) {
      case 'Daily':
        return 'Days';
      case 'اليومية':
        return 'يوم';
      case 'Weekly':
        return 'Weeks';
      case 'الاسبوعية':
        return 'اسبوع';
      case 'Monthly':
        return 'Months';
      case 'الشهرية':
        return 'شهر';
    }
    return '${cost ~/ dailySaving} $choseRepeat';
  }

  String transferDateToString(GoalModel goalModel) {
    final completionDate = countCompletionDate(goalModel.goalSaveAmountRepeat,
        goalModel.goalStartSavingDate, goalModel.goalRemainingPeriod);
    return '${completionDate.day}\\${completionDate.month}\\${completionDate.year}';
  }

  Future<void> deleteGoal(GoalModel goalModel) async {
    registeredGoals.remove(goalModel);
    await _goalsRepository.deleteGoalFromGoalsBox(goalModel);
    fetchAllGoals();
    emit(GoalsDelete());
  }

  num countRemainingAmount(num totalCost, num saveAmount) {
    if (chosenDate!.day == today.day &&
        chosenDate!.month == today.month &&
        chosenDate!.year == today.year) {
      return totalCost - saveAmount;
    } else {
      return totalCost;
    }
  }
}
