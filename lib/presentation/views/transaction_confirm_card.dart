import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:temp/business_logic/cubit/confirm_payments/confirm_payment_cubit.dart';
import 'package:temp/constants/app_presentation_strings.dart';
import 'package:temp/data/repository/helper_class.dart';

import 'package:temp/presentation/views/confirm_paying_expense.dart';
import 'package:temp/presentation/widgets/show_dialog.dart';

class TransactionConfirmCard extends StatelessWidget
    with AlertDialogMixin, HelperClass {
  const TransactionConfirmCard({Key? key, required this.changedAmount})
      : super(key: key);
  final TextEditingController changedAmount;

  @override
  Widget build(BuildContext context) {
    var w;
    return Visibility(
      visible: context.read<ConfirmPaymentCubit>().currentIndex == 0,
      child: Visibility(
        visible: context.read<ConfirmPaymentCubit>().allTodayList.isNotEmpty,
        child: ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 4.dp),
          itemExtent: 85.w,
          scrollDirection: Axis.horizontal,
          itemCount: context.read<ConfirmPaymentCubit>().allTodayList.length,
          itemBuilder: (context, index) {
            var curentExpense =
                context.read<ConfirmPaymentCubit>().allTodayList[index];
            // index++;
            return Row(
              children: [
                Expanded(
                  child: ConfirmPayingExpense(
                    date: formatDayDate(curentExpense.createdDate),
                    transactionModel: curentExpense,
                    onDetails: () {},
                    amount: curentExpense.amount.toDouble(),
                    onDelete: () {
                      showDialog(
                          context: context,
                          builder: (ctx) => showYesOrNoDialog(
                              title: AppPresentationStrings.deleteExpenseEng,
                              message:
                                  "${AppPresentationStrings.areYouSureDeleteEng} ${curentExpense.name} ${AppPresentationStrings.permanentlyEng} ?",
                              onYes: () {
                                context
                                    .read<ConfirmPaymentCubit>()
                                    .onDeleteTransaction(curentExpense, context);
                              },
                              onNo: () {},
                              context: context));
                    },
                    onEditAmount: () {
                      changedAmount.text = curentExpense.amount.toString();
                      showDialog(
                          context: context,
                          builder: (ctx) => newAmountDialog(
                              amount: context.read<ConfirmPaymentCubit>().test[index],
                              onUpdate: () {
                                context.read<ConfirmPaymentCubit>().onChangeAmount(
                                    curentExpense.amount.toDouble(),
                                    double.parse(changedAmount.text));
                                curentExpense.amount =
                                    double.parse(changedAmount.text);
                              },
                              context: ctx,
                              changedAmountCtrl: changedAmount));
                    },
                    index: index,
                    onCancel: () {
                      context
                          .read<ConfirmPaymentCubit>()
                          .onNoConfirmed(theAddedExpense: curentExpense);
                    },
                    onConfirm: () {
                      context
                          .read<ConfirmPaymentCubit>()
                          .onYesConfirmed(theAddedExpense: curentExpense);
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
        replacement: Center(
          child: Text(AppPresentationStrings.noDataToConfirmEng),
        ),
      ),
      replacement: Visibility(
        visible: context.read<ConfirmPaymentCubit>().allTodayListIncome.isNotEmpty,
        child: ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 4.dp),
          itemExtent: 85.w,
          scrollDirection: Axis.horizontal,
          itemCount: context.read<ConfirmPaymentCubit>().allTodayListIncome.length,
          itemBuilder: (context, index) {
            var curentIncome =
                context.read<ConfirmPaymentCubit>().allTodayListIncome[index];
            // index++;
            return Row(
              children: [
                Expanded(
                  child: ConfirmPayingExpense(
                    date: DateTime.now().toString(),
                    transactionModel: curentIncome,
                    onDetails: () {},
                    amount: curentIncome.amount.toDouble(),
                    onDelete: () {
                      showDialog(
                          context: context,
                          builder: (ctx) => showYesOrNoDialog(
                              title: AppPresentationStrings.deleteIncomeEng,
                              message:
                                  "${AppPresentationStrings.areYouSureDeleteEng} ${curentIncome.name} ${AppPresentationStrings.permanentlyEng} ? \n ${AppPresentationStrings.youCanPressCancelEng}",
                              onYes: () {
                                context
                                    .read<ConfirmPaymentCubit>()
                                    .onDeleteTransaction(curentIncome, context);
                              },
                              onNo: () {},
                              context: context));
                    },
                    onEditAmount: () {
                      changedAmount.text = curentIncome.amount.toString();
                      showDialog(
                          context: context,
                          builder: (ctx) => newAmountDialog(
                              amount: context.read<ConfirmPaymentCubit>().test[index],
                              onUpdate: () {
                                context.read<ConfirmPaymentCubit>().onChangeAmount(
                                    curentIncome.amount.toDouble(),
                                    double.parse(changedAmount.text));
                                curentIncome.amount = double.parse(changedAmount.text);
                              },
                              context: ctx,
                              changedAmountCtrl: changedAmount));
                    },
                    index: index,
                    onCancel: () {
                      context
                          .read<ConfirmPaymentCubit>()
                          .onNoConfirmed(theAddedExpense: curentIncome);
                    },
                    onConfirm: () {
                      context
                          .read<ConfirmPaymentCubit>()
                          .onYesConfirmed(theAddedExpense: curentIncome);
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
        replacement: Center(
          child: Text(AppPresentationStrings.noDataToConfirmEng),
        ),
      ),
    );
  }
}
