import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/business_logic/cubit/confirm_payments/confirm_payment_cubit.dart';
import 'package:temp/data/models/goals/goal_model.dart';
import 'package:temp/presentation/views/confirm_paying_goals.dart';

class GoalConfirmCard extends StatelessWidget {
  const GoalConfirmCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Visibility(
      visible: context.read<ConfirmPaymentCubit>().allTodayGoals.isNotEmpty,

      child: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 4.sp),
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
                  onDelete: () {},
                  onEditAmount: () {},
                  index: index,
                  onCancel: () {},
                  onConfirm: () {},
                  changedAmount: 10000,
                  blockedAmount: 20000,
                  onEditBlockedAmount: () {},
                  onEditChangedAmount: () {},
                ),
              ),
              SizedBox(width: 4.w),
            ],
          );
        },
      ),
      replacement: Center(child: Text("No Goals To confirm",),),

    );
  }
}
