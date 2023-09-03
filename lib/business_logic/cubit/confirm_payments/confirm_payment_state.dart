part of 'confirm_payment_cubit.dart';

@immutable
abstract class ConfirmPaymentState {}

class ConfirmPaymentInitial extends ConfirmPaymentState {}

class ChangeTabIndexState extends ConfirmPaymentState {}

class ChangedAmountState extends ConfirmPaymentState {}

class YesConfirmedState extends ConfirmPaymentState {}

class NoConfirmedState extends ConfirmPaymentState {}

class DeletedTransactionSuccess extends ConfirmPaymentState {}

class DeletedTransactionFailure extends ConfirmPaymentState {}
