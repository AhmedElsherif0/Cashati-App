import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/business_logic/cubit/expense_repeat/expense_repeat_cubit.dart';

import '../../constants/enum_classes.dart';
import '../styles/colors.dart';
import 'expenses_and_income_widgets/tab_view_item_decoration.dart';

class ExpenseRepeatHeader extends StatelessWidget {
  const ExpenseRepeatHeader({
    Key? key,
    required this.header,
    required this.currentIndex, required this.repeatCubit,
  }) : super(key: key);

  final List<RepeatTypes> header;
  final int currentIndex;
  final ExpenseRepeatCubit repeatCubit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 10.h,
      width: double.infinity,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 12.sp),
        children: List.generate(
            header.length,
            (index) => Row(
                  children: [
                    SizedBox(
                      width: 30.w,
                      height: 6.h,
                      child: TabBarItem(
                        text: header[index].name,
                        onTap: () =>
                           repeatCubit.changePage(index: index),
                        backGroundColor: currentIndex == index
                            ? AppColor.primaryColor
                            : AppColor.white,
                        textColor: currentIndex != index
                            ? AppColor.primaryColor
                            : AppColor.white,
                      ),
                    ),
                    SizedBox(width: 8.w),
                  ],
                ),
            growable: false),
      ),
    );
  }
}
