part of 'income_repeat_cubit.dart';

@immutable
abstract class IncomeRepeatCubitStates {}

class IncomeRepeatCubitInitial extends IncomeRepeatCubitStates {}

class IncomeRepeatLoading extends IncomeRepeatCubitStates {}
class FetchedRepeatedIncomeTransactions extends IncomeRepeatCubitStates {}

class IncomeRepeatSuccess extends IncomeRepeatCubitStates {}
class IncomeRepeatScreenState extends IncomeRepeatCubitStates {}

class IncomeRepeatError extends IncomeRepeatCubitStates {
  final String message;

  IncomeRepeatError(this.message);
}
