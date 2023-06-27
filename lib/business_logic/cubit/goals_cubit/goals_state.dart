part of 'goals_cubit.dart';

@immutable
abstract class GoalsState {}

class GoalsInitial extends GoalsState {}
class ChoosedRepeatState extends GoalsState {}
class ChoosedGoalFilterState extends GoalsState {}
class ChoseDateState extends GoalsState {}
class GoalsDelete extends GoalsState {}
class FetchedGoals extends GoalsState {}
class FetchedRepeatedGoals extends GoalsState {}
