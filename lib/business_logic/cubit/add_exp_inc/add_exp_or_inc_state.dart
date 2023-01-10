part of 'add_exp_or_inc_cubit.dart';

@immutable
abstract class AddExpOrIncState {}

class AddExpOrIncInitial extends AddExpOrIncState {}
class AddExpOrIncLoading extends AddExpOrIncState {}
class AddExpOrIncSuccess extends AddExpOrIncState {}
class AddExpOrIncError extends AddExpOrIncState {}
class ChoosedSubCategoryState extends AddExpOrIncState {}
class ChoosedRepeatState extends AddExpOrIncState {}
class ChoosedPriorityYesState extends AddExpOrIncState {}
class ChoosedPriorityNoState extends AddExpOrIncState {}
class ChoosedMainCategoryState extends AddExpOrIncState {}
class ChoosedDateState extends AddExpOrIncState {}
