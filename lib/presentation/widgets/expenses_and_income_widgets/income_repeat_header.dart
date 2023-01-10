import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/business_logic/cubit/expense_repeat/expense_repeat_cubit.dart';
import 'package:temp/presentation/widgets/expenses_and_income_widgets/tab_view_item_decoration.dart';

import '../../../business_logic/cubit/income_repeat/income_repeat_cubit.dart';
import '../../styles/colors.dart';

class IncomeRepeatHeader extends StatelessWidget {
  const IncomeRepeatHeader({
    Key? key,
    required this.header,
    required this.currentIndex, required this.incomeRepeatCubit,
  }) : super(key: key);

  final List<String> header;
  final int currentIndex;
  final IncomeRepeatCubit incomeRepeatCubit;

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
                        text: header[index],
                        onTap: () =>
                            incomeRepeatCubit.changePage(index: index),
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
