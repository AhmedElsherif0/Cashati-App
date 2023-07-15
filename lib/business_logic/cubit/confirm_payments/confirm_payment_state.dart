part of 'confirm_payment_cubit.dart';

@immutable
abstract class ConfirmPaymentState {
  const ConfirmPaymentState();
}

class ConfirmPaymentInitial extends ConfirmPaymentState {}
class ChangeTabIndexState extends ConfirmPaymentState {}
class ChangedAmountState extends ConfirmPaymentState {}
class YesConfirmedState extends ConfirmPaymentState {}
class NoConfirmedState extends ConfirmPaymentState {}
class DeleteTransactionSuccessState extends ConfirmPaymentState {}
class DeleteTransactionFailureState extends ConfirmPaymentState {
  final String errorMessage;

 const DeleteTransactionFailureState(this.errorMessage);
}
