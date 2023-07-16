import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/business_logic/cubit/confirm_payments/confirm_payment_cubit.dart';
import 'package:temp/presentation/screens/shared/empty_screen.dart';
import 'package:temp/presentation/views/confirm_paying_expense.dart';
import 'package:temp/presentation/widgets/show_dialog.dart';

class TransactionConfirmCard extends StatelessWidget with AlertDialogMixin {
  const TransactionConfirmCard({Key? key, required this.changedAmount}) : super(key: key);
  final TextEditingController changedAmount;


  @override
  Widget build(BuildContext context) {
    var w;
    return Visibility(
      visible: context.read<ConfirmPaymentCubit>().currentIndex==0,
      child: Visibility(
        visible: context.read<ConfirmPaymentCubit>().allTodayList.isNotEmpty,
        child: ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 4.sp),
          itemExtent: 85.w,
          scrollDirection: Axis.horizontal,
          itemCount: context.read<ConfirmPaymentCubit>().allTodayList.length,
          itemBuilder: (context, index) {
            var curentTransaction = context.read<ConfirmPaymentCubit>().allTodayList[index];
            // index++;
            return Row(
              children: [
                Expanded(
                  child: ConfirmPayingExpense(

                    date: DateTime.now().toString(),
                    transactionModel:curentTransaction,
                    onDetails: () {},
                    amount: curentTransaction.amount.toDouble(),
                    onDelete: () {
                      yesAndNoDialog(title: "Delete Transction",infoMessage: "are you sure you want to delete this transaction permanently?",
                      context: context,
                        onPressedYesFunction: (){
                          context.read<ConfirmPaymentCubit>().confirmDeleteTransaction(curentTransaction);
                        Navigator.pop(context);
                        }
                      );
                    },
                    onEditAmount: () {
                      changedAmount.text=curentTransaction.amount.toString();
                      showDialog(context: context, builder: (ctx)=>newAmountDialog(amount: context.read<ConfirmPaymentCubit>().test[index],onUpdate: (){
                        context.read<ConfirmPaymentCubit>().onChangeAmount(curentTransaction.amount.toDouble(),double.parse(changedAmount.text));
                        curentTransaction.amount=double.parse(changedAmount.text);
                      },context: ctx,changedAmountCtrl: changedAmount));
                    },
                    index: index,
                    onCancel: (){
                      context.read<ConfirmPaymentCubit>().onNoConfirmed(theAddedExpense: curentTransaction);
                    },
                    onConfirm: (){
                      context.read<ConfirmPaymentCubit>().onYesConfirmed(theAddedExpense:curentTransaction );

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
        replacement: Center(child: Text("No Data To confirm"),),
      ),
      replacement:Visibility(
        visible: context.read<ConfirmPaymentCubit>().allTodayListIncome.isNotEmpty,

        child: ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 4.sp),
          itemExtent: 85.w,
          scrollDirection: Axis.horizontal,
          itemCount: context.read<ConfirmPaymentCubit>().allTodayListIncome.length,
          itemBuilder: (context, index) {
            var curentIncome = context.read<ConfirmPaymentCubit>().allTodayListIncome[index];
            // index++;
            return Row(
              children: [
                Expanded(
                  child: ConfirmPayingExpense(

                    date: DateTime.now().toString(),
                    transactionModel:curentIncome,
                    onDetails: () {},
                    amount: curentIncome.amount.toDouble(),
                    onDelete: () {},
                    onEditAmount: () {
                      changedAmount.text=curentIncome.amount.toString();
                      showDialog(context: context, builder: (ctx)=>newAmountDialog(amount: context.read<ConfirmPaymentCubit>().test[index],onUpdate: (){
                        context.read<ConfirmPaymentCubit>().onChangeAmount(curentIncome.amount.toDouble(),double.parse(changedAmount.text));
                        curentIncome.amount=double.parse(changedAmount.text);
                      },context: ctx,changedAmountCtrl: changedAmount));
                    },
                    index: index,
                    onCancel: (){
                      context.read<ConfirmPaymentCubit>().onNoConfirmed(theAddedExpense: curentIncome);
                    },
                    onConfirm: (){
                      context.read<ConfirmPaymentCubit>().onYesConfirmed(theAddedExpense:curentIncome );

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
        replacement: Center(child: Text("No Data To confirm"),),

      ) ,
    );
  }
}
