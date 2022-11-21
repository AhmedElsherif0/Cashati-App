part of 'expense_repeat_cubit.dart';

@immutable
abstract class ExpenseRepeatState {}

class ExpenseRepeatInitial extends ExpenseRepeatState {}

class ExpenseRepeatLoading extends ExpenseRepeatState {}

class ExpenseRepeatSuccess extends ExpenseRepeatState {}
class ExpenseRepeatScreenState extends ExpenseRepeatState {}

class ExpenseRepeatError extends ExpenseRepeatState {
  final String message;

  ExpenseRepeatError(this.message);
}
