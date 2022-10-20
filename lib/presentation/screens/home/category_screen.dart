import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/presentation/widgets/expenses_and_income_widgets/expenses_income_header.dart';

import '../../../constants/app_icons.dart';
import '../../styles/colors.dart';
import '../../views/confirm_paying_expense.dart';
import '../../views/confirm_paying_goals.dart';
import '../../widgets/custom_app_bar.dart';

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
            flex: 10,
            child: SizedBox(
              width: 100.w - 5.w,
              child: ListView.builder(
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
