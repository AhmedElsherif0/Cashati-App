import 'package:flutter/material.dart';
import 'package:temp/presentation/widgets/under_line_divider.dart';

import '../styles/colors.dart';
import 'custom_text_button.dart';


class ExpensesAndIncomeHeader extends StatelessWidget {
  const ExpensesAndIncomeHeader(
      {Key? key,
      this.isSignUp = true,
     required this.onPressedSignIn,
      required this.onPressedSignUp})
      : super(key: key);

  final bool isSignUp;
  final void Function() onPressedSignIn;
  final void Function() onPressedSignUp;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              CustomTextButton(
                text: 'Expenses',
                onPressed: onPressedSignUp,
                textStyle: isSignUp ? textTheme.headline5 : textTheme.headline6,
              ),
              UnderLineDivider(
                  color: isSignUp ? AppColor.primaryColor : AppColor.white)
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              CustomTextButton(
                  text: 'Income',
                  onPressed: onPressedSignIn,
                  textStyle:
                      isSignUp ? textTheme.headline6 : textTheme.headline5),
              UnderLineDivider(
                  color: isSignUp ? AppColor.white : AppColor.primaryColor),
            ],
          ),
        ),
      ],
    );
  }
}
