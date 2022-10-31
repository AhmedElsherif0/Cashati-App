import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/presentation/widgets/expenses_and_income_widgets/expenses_income_header.dart';
import '../../../views/confirm_paying_goals.dart';
import '../../../widgets/custom_app_bar.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomAppBar(
            title: 'Confirm Paying Today',
            onTanNotification: () {},
            onTapFirstIcon: () {},
            firstIcon: Icons.menu,
            textStyle: Theme.of(context)
                .textTheme
                .headline3
                ?.copyWith(fontSize: 14.sp),
          ),
          const Spacer(flex: 2),
          Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.sp),
              child: ExpensesAndIncomeHeader(
                onPressedIncome: () {},
                onPressedExpense: () {},
                incomeOrGoals: 'Goals',
                isCategory: true,
                alignmentExpense: Alignment.center,
                alignmentIncomeOrGoals: Alignment.center,
              ),
            ),
          ),
          Expanded(
            flex: 11,
            child: SizedBox(
              width: 95.w,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 4.sp),
                itemExtent: 85.w,
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (context, index) {
                  index++;
                  return Row(
                    children: [
                      Expanded(
                        child: ConfirmPayingGoals(
                          amount: 300,
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
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
