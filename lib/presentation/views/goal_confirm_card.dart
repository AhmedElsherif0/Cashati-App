import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:temp/business_logic/cubit/confirm_payments/confirm_payment_cubit.dart';
import 'package:temp/data/models/goals/goal_model.dart';
import 'package:temp/data/repository/helper_class.dart';
import 'package:temp/presentation/utils/extensions.dart';
import 'package:temp/presentation/views/confirm_paying_goals.dart';
import 'package:temp/presentation/widgets/show_dialog.dart';

import '../../business_logic/cubit/goals_cubit/goals_cubit.dart';
import '../../business_logic/cubit/home_cubit/home_cubit.dart';
import '../../constants/app_strings.dart';

class GoalConfirmCard extends StatelessWidget with AlertDialogMixin,HelperClass {
  const GoalConfirmCard({Key? key, required this.changedAmount}) : super(key: key);
  final TextEditingController changedAmount;

  _deleteGoal(GoalModel goalModel,BuildContext context){
    BlocProvider.of<GoalsCubit>(context).deleteGoal(goalModel);
    BlocProvider.of<HomeCubit>(context).onRemoveNotificationForDeletedTransaction(goalModel.goalName);
    BlocProvider.of<HomeCubit>(context).getNotificationList();
    BlocProvider.of<ConfirmPaymentCubit>(context).onDeleteGoal(goalModel);
  }
  @override
  Widget build(BuildContext context) {
    final cubitConfirm = context.read<ConfirmPaymentCubit>();
    return Visibility(
      visible: cubitConfirm.allTodayGoals.isNotEmpty,
      replacement: Center(child: Text(AppStrings.noGoalsToConfirm.tr())),
      child: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 4.dp),
        itemExtent: 85.w,
        scrollDirection: Axis.horizontal,
        itemCount: cubitConfirm.allTodayGoals.length,
        itemBuilder: (context, index) {
          GoalModel currentGoal = cubitConfirm.allTodayGoals[index];
          //index++;
          return Row(
            children: [
              Expanded(
                child: ConfirmPayingGoals(
                  goalModel: currentGoal,
                  amount: currentGoal.goalSaveAmount.toDouble(),
                  //Todo: Doesn't work yet.
                  onDelete: () =>showYesOrNoDialog(
                      title: AppStrings.deleteGoal.tr(),
                      message: getMsg(currentGoal.goalName),
                      onYes: ()=>_deleteGoal(currentGoal,context), context: context),
                  onEditAmount: () {
                    changedAmount.text = currentGoal.goalSaveAmount.toString();
                    newAmountDialog(
                        amount: cubitConfirm.tests[index],
                        onUpdate: () {
                          cubitConfirm.onChangeAmount(
                              currentGoal.goalSaveAmount.toDouble(),
                              changedAmount.text.toDouble());
                          currentGoal.goalSaveAmount = changedAmount.text.toDouble();
                        },
                        context: context,
                        changedAmountCtrl: changedAmount);
                  },
                  index: index,
                  onCancel: () =>
                      cubitConfirm.onNoConfirmedGoal(goalModel: currentGoal),
                  onConfirm: () =>
                      cubitConfirm.onYesConfirmedGoal(goalModel: currentGoal),
                  changedAmount: 10000,
                  blockedAmount: currentGoal.goalRemainingAmount.toDouble(),
                  // Todo: what this events For ??!!.
                  onEditBlockedAmount: () {},
                  onEditChangedAmount: () {},
                ),
              ),
              SizedBox(width: 4.w),
            ],
          );
        },
      ),
    );
  }
}
