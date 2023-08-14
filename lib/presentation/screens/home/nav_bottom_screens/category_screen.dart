import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:temp/business_logic/cubit/confirm_payments/confirm_payment_cubit.dart';
import 'package:temp/presentation/views/goal_confirm_card.dart';
import 'package:temp/presentation/views/transaction_confirm_card.dart';
import 'package:temp/presentation/widgets/show_dialog.dart';

import '../../../views/confirm_payment_tab_bar.dart';

class ConfirmPayingScreen extends StatefulWidget {
  const ConfirmPayingScreen({Key? key}) : super(key: key);

  @override
  State<ConfirmPayingScreen> createState() => _ConfirmPayingScreenState();
}

class _ConfirmPayingScreenState extends State<ConfirmPayingScreen>
    with AlertDialogMixin {
  final TextEditingController changedAmount = TextEditingController();

  @override
  void initState() {
    context.read<ConfirmPaymentCubit>().allTodayList = List.from(context
        .read<ConfirmPaymentCubit>()
        .transactionRep
        .getTodayPayments(isExpense: true));
    print('all expenses are ${context.read<ConfirmPaymentCubit>().allTodayList}');
    context.read<ConfirmPaymentCubit>().allTodayListIncome = List.from(context
        .read<ConfirmPaymentCubit>()
        .transactionRep
        .getTodayPayments(isExpense: false));
    print('all income are ${context.read<ConfirmPaymentCubit>().allTodayListIncome}');
    context.read<ConfirmPaymentCubit>().allTodayGoals =
        List.from(context.read<ConfirmPaymentCubit>().goalsRepository.getTodayGoals());
    print('all Today Goals are ${context.read<ConfirmPaymentCubit>().allTodayGoals}');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ConfirmPaymentCubit, ConfirmPaymentState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.dp),
                  child: ConfirmPaymentTabBar(
                    tabBarIndex: context.read<ConfirmPaymentCubit>().currentIndex,
                    onChangeIndex: (index) {
                      context.read<ConfirmPaymentCubit>().onChangeIndex(index);
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 11,
                child: SizedBox(
                  width: 95.w,
                  child: Visibility(
                    visible: context.read<ConfirmPaymentCubit>().currentIndex != 2,
                    replacement: GoalConfirmCard(changedAmount: changedAmount),
                    child: TransactionConfirmCard(changedAmount: changedAmount),
                  ),
                ),
              ),
              const Spacer(),
            ],
          );
        },
      ),
    );
  }
}
