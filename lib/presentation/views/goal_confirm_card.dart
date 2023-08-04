import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:temp/business_logic/cubit/confirm_payments/confirm_payment_cubit.dart';
import 'package:temp/data/models/goals/goal_model.dart';
import 'package:temp/presentation/views/confirm_paying_goals.dart';
import 'package:temp/presentation/widgets/show_dialog.dart';

import '../../constants/app_presentation_strings.dart';

class GoalConfirmCard extends StatelessWidget with AlertDialogMixin {
  const GoalConfirmCard({Key? key, required this.changedAmount}) : super(key: key);
  final TextEditingController changedAmount;

  @override
  Widget build(BuildContext context) {
    return  Visibility(
      visible: context.read<ConfirmPaymentCubit>().allTodayGoals.isNotEmpty,

      child: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 4.dp),
        itemExtent: 85.w,
        scrollDirection: Axis.horizontal,
        itemCount: context.read<ConfirmPaymentCubit>().allTodayGoals.length,
        itemBuilder: (context, index) {
          GoalModel currentGoal=context.read<ConfirmPaymentCubit>().allTodayGoals[index];
          //index++;
          return Row(
            children: [
              Expanded(
                child: ConfirmPayingGoals(
                  goalModel: context.read<ConfirmPaymentCubit>().allTodayGoals[index],
                  amount: currentGoal.goalSaveAmount.toDouble(),
                  onDelete: () {
                  },
                  onEditAmount: () {
                    changedAmount.text=currentGoal.goalSaveAmount.toString();
                    showDialog(context: context, builder: (ctx)=>newAmountDialog(amount: context.read<ConfirmPaymentCubit>().test[index],onUpdate: (){
                      context.read<ConfirmPaymentCubit>().onChangeAmount(currentGoal.goalSaveAmount.toDouble(),double.parse(changedAmount.text));
                      currentGoal.goalSaveAmount=double.parse(changedAmount.text);
                    },context: ctx,changedAmountCtrl: changedAmount));
                  },
                  index: index,
                  onCancel: () {
                    context.read<ConfirmPaymentCubit>().onNoConfirmedGoal(goalModel: currentGoal);
                  },
                  onConfirm: () {
                    context.read<ConfirmPaymentCubit>().onYesConfirmedGoal(goalModel: currentGoal);

                  },
                  changedAmount: 10000,
                  blockedAmount: currentGoal.goalRemainingAmount.toDouble(),
                  onEditBlockedAmount: () {},
                  onEditChangedAmount: () {},
                ),
              ),
              SizedBox(width: 4.w),
            ],
          );
        },
      ),
      replacement: Center(child: Text(AppPresentationStrings.noGoalsToConfirmEng,),),

    );
  }
}
