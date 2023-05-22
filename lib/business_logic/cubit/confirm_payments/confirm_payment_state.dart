part of 'confirm_payment_cubit.dart';

@immutable
abstract class ConfirmPaymentState {}

class ConfirmPaymentInitial extends ConfirmPaymentState {}
class ChangeTabIndexState extends ConfirmPaymentState {}
class ChangedAmountState extends ConfirmPaymentState {}
