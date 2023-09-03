import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:temp/business_logic/cubit/confirm_payments/confirm_payment_cubit.dart';
import 'package:temp/constants/app_strings.dart';
import 'package:temp/data/models/transactions/transaction_model.dart';
import 'package:temp/data/repository/helper_class.dart';

import 'package:temp/presentation/views/confirm_paying_expense.dart';
import 'package:temp/presentation/widgets/show_dialog.dart';

import '../../business_logic/cubit/home_cubit/home_cubit.dart';

class TransactionConfirmCard extends StatelessWidget
    with AlertDialogMixin, HelperClass {
  const TransactionConfirmCard({Key? key, required this.changedAmount})
      : super(key: key);
  final TextEditingController changedAmount;

  @override
  Widget build(BuildContext context) {
    final confirmCubit = context.read<ConfirmPaymentCubit>();
    return BlocBuilder<ConfirmPaymentCubit, ConfirmPaymentState>(
        builder: (context, state) => Visibility(
              visible: confirmCubit.currentIndex == 0,
              replacement: Visibility(
                visible: confirmCubit.allTodayListIncome.isNotEmpty,
                replacement: Center(child: Text(AppStrings.noDataToConfirm.tr())),
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 4.dp),
                  itemExtent: 85.w,
                  scrollDirection: Axis.horizontal,
                  itemCount: confirmCubit.allTodayListIncome.length,
                  itemBuilder: (context, index) {
                    var currentIncome = confirmCubit.allTodayListIncome[index];
                    // index++;
                    return Row(
                      children: [
                        Expanded(
                          child: ConfirmPayingExpense(
                            date: formatDayDate(
                                DateTime.now(), translator.activeLanguageCode),
                            transactionModel: currentIncome,
                            onDetails: () {},
                            amount: currentIncome.amount.toDouble(),
                            onDelete: () =>
                              showYesOrNoDialog(
                                  title: AppStrings.deleteIncome.tr(),
                                  message:
                                      '${getMsg(currentIncome)}\n'
                                          '${AppStrings.availabilityToCancelTransaction}',
                                  onYes: () async => await confirmCubit
                                      .onDeleteTransaction(currentIncome),
                                  context: context),
                            onEditAmount: () {
                              changedAmount.text = currentIncome.amount.toString();
                              newAmountDialog(
                                  amount: confirmCubit.test[index],
                                  onUpdate: () {
                                    confirmCubit.onChangeAmount(
                                        currentIncome.amount.toDouble(),
                                        double.parse(changedAmount.text));
                                    currentIncome.amount =
                                        double.parse(changedAmount.text);
                                  },
                                  context: context,
                                  changedAmountCtrl: changedAmount);
                            },
                            index: index,
                            onCancel: () {
                              confirmCubit.onNoConfirmed(
                                  theAddedExpense: currentIncome);
                            },
                            onConfirm: () {
                              confirmCubit.onYesConfirmed(
                                  theAddedExpense: currentIncome);
                            },
                            // changedAmount: 10000,
                            // blockedAmount: 20000,
                            // onEditBlockedAmount: () {},
                            // onEditChangedAmount: () {},
                          ),
                        ),
                        SizedBox(width: 4.w),
                      ],
                    );
                  },
                ),
              ),
              child: Visibility(
                visible: confirmCubit.allTodayList.isNotEmpty,
                replacement: const Center(child: Text(AppStrings.noDataToConfirm)),
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 4.dp),
                  itemExtent: 85.w,
                  scrollDirection: Axis.horizontal,
                  itemCount: confirmCubit.allTodayList.length,
                  itemBuilder: (context, index) {
                    var currentExpense = confirmCubit.allTodayList[index];
                    // index++;
                    return Row(
                      children: [
                        Expanded(
                          child: ConfirmPayingExpense(
                            date: formatDayDate(currentExpense.createdDate,
                                translator.activeLanguageCode),
                            transactionModel: currentExpense,
                            onDetails: () {},
                            amount: currentExpense.amount.toDouble(),
                            onDelete: () {
                              showYesOrNoDialog(
                                  title: AppStrings.deleteExpense.tr(),
                                  message: getMsg(currentExpense),
                                  onYes: () =>
                                      confirmCubit.onDeleteTransaction(currentExpense),
                                  context: context);
                            },
                            onEditAmount: () {
                              changedAmount.text = currentExpense.amount.toString();
                              newAmountDialog(
                                  amount: confirmCubit.test[index],
                                  onUpdate: () {
                                    confirmCubit.onChangeAmount(
                                        currentExpense.amount.toDouble(),
                                        double.parse(changedAmount.text));
                                    currentExpense.amount =
                                        double.parse(changedAmount.text);
                                  },
                                  context: context,
                                  changedAmountCtrl: changedAmount);
                            },
                            index: index,
                            onCancel: () => confirmCubit.onNoConfirmed(
                                theAddedExpense: currentExpense),
                            onConfirm: () => confirmCubit.onYesConfirmed(
                                theAddedExpense: currentExpense),
                            // changedAmount: 10000,
                            // blockedAmount: 20000,
                            // onEditBlockedAmount: () {},
                            // onEditChangedAmount: () {},
                          ),
                        ),
                        SizedBox(width: 4.w),
                      ],
                    );
                  },
                ),
              ),
            ));
  }
}
