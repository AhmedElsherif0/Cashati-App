part of 'add_exp_or_inc_cubit.dart';

@immutable
abstract class AddExpOrIncState {}

class AddExpOrIncInitial extends AddExpOrIncState {}
class AddExpOrIncLoading extends AddExpOrIncState {}
class AddExpOrIncSuccess extends AddExpOrIncState {}
class AddExpOrIncError extends AddExpOrIncState {}
