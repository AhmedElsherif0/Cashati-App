import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/presentation/widgets/under_line_divider.dart';

import '../../../constants/app_icons.dart';
import '../../styles/colors.dart';
import '../custom_text_button.dart';

class ExpensesAndIncomeHeader extends StatelessWidget {
  const ExpensesAndIncomeHeader({
    Key? key,
    this.isExpense = true,
    required this.onPressedIncome,
    required this.onPressedExpense,
    this.incomeOrGoals = 'Income',
    this.isCategory = false,
    this.alignmentExpense = Alignment.centerLeft,
    this.alignmentIncomeOrGoals = Alignment.centerRight,
  }) : super(key: key);

  final bool isExpense;
  final bool isCategory;
  final void Function() onPressedIncome;
  final void Function() onPressedExpense;
  final String incomeOrGoals;
  final Alignment alignmentExpense;
  final Alignment alignmentIncomeOrGoals;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        Expanded(
          flex: 8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              if (isCategory)
                Align(
                  alignment: alignmentExpense,
                  child: SvgPicture.asset(AppIcons.expense,
                      height: 40.sp,
                      width: 40.sp,
                      color: AppColor.primaryColor),
                ),
              CustomTextButton(
                alignment: alignmentExpense,
                isVisible: false,
                text: 'Expenses',
                onPressed: onPressedExpense,
                textStyle: isExpense
                    ? textTheme.headline6
                    : textTheme.headline6
                        ?.copyWith(color: AppColor.pinkishGrey),
              ),
              Divider(
                  color: isExpense ? AppColor.primaryColor : Colors.transparent,
                  height: 1.5.h,
                  thickness: 2.sp,
                  indent: 0,
                  endIndent: 0)
            ],
          ),
        ),
        const Spacer(),
        Expanded(
          flex: 8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              if (isCategory)
                Align(
                  alignment: alignmentIncomeOrGoals,
                  child: SvgPicture.asset(AppIcons.goals,
                      color: AppColor.primaryColor,
                      height: 40.sp,
                      width: 40.sp),
                ),
              CustomTextButton(
                  alignment: alignmentIncomeOrGoals,
                  isVisible: false,
                  text: incomeOrGoals,
                  onPressed: onPressedIncome,
                  textStyle: isExpense
                      ? textTheme.headline6
                          ?.copyWith(color: AppColor.pinkishGrey)
                      : textTheme.headline6),
              Divider(
                  color: isExpense ? Colors.transparent : AppColor.primaryColor,
                  height: 1.5.h,
                  thickness: 2.sp,
                  indent: 0.sp,
                  endIndent: 0.sp)
            ],
          ),
        ),
      ],
    );
  }
}
