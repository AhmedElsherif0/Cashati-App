import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/presentation/widgets/buttons/dotted_button.dart';
import 'package:temp/presentation/widgets/expenses_and_income_widgets/underline_text_button.dart';

import '../styles/colors.dart';

class CardHome extends StatelessWidget {
  const CardHome(
      {Key? key,
      required this.title,
      required this.onPressedShow,
      required this.onPressedAdd,
      required this.onPressedTop})
      : super(key: key);

  final String title;
  final Function() onPressedShow;
  final Function() onPressedAdd;
  final Function() onPressedTop;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Stack(
      children: [
        /// Show Expense or Income.
        Padding(
          padding: EdgeInsets.only(top: 40.sp),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: AppColor.primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.sp),
                topRight: Radius.circular(40.sp),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(right: 14.sp, bottom: 8.sp),
              child: Align(
                alignment: Alignment.bottomRight,
                child: UnderLineTextButton(
                  text: 'Show $title',
                  onPressed: onPressedShow,
                  textStyle: TextStyle(fontSize: 14.sp, color: AppColor.white),
                  decorationColor: AppColor.white,
                ),
              ),
            ),
          ),
        ),

        ///  Stacked Balance Widget.
        Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            height: 14.h,
            width: 40.w,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.sp),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 50,
                    offset: const Offset(0, 4), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 12.sp, right: 5.w, left: 5.w),
                child: Column(
                  children: [
                    SvgPicture.asset('assets/icons/download.svg',
                        height: 20.sp, width: 20.sp),
                    SizedBox(height: 2.h),
                    Text('Balance', style: textTheme.headline6),
                  ],
                ),
              ),
            ),
          ),
        ),

        /// Dotted Widget
        Padding(
          padding: EdgeInsets.only(top: 22.h),
          child: Column(
            children: [
              DottedButton(text: 'Top', title: title, onPressed: onPressedTop),
              SizedBox(height: 2.h),
              DottedButton(text: 'Add', title: title, onPressed: onPressedAdd),
            ],
          ),
        ),
      ],
    );
  }
}
