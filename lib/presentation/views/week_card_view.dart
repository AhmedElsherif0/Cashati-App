import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/constants/enum_classes.dart';
import 'package:temp/data/repository/helper_class.dart';
import 'package:temp/presentation/styles/colors.dart';
import 'package:temp/presentation/widgets/expenses_and_income_widgets/important_or_fixed.dart';
import 'package:temp/presentation/widgets/expenses_and_income_widgets/underline_text_button.dart';

import '../../constants/app_icons.dart';

class WeekCardViewEdited extends StatelessWidget with HelperClass {
  const WeekCardViewEdited({
    Key? key,
    required this.weeksTotals,
    this.priceColor = AppColor.red,
    this.seeMoreOrDetailsOrHighest,
    required this.weekRanges,
    required this.chosenDay,
    this.priorityColor = AppColor.secondColor,
    required this.onSeeMore,
  }) : super(key: key);

  final List<num> weeksTotals;
  final List<String> weekRanges;
  final DateTime chosenDay;
  final Color priceColor;
  final Color priorityColor;
  final void Function() onSeeMore;
  final SwitchWidgets? seeMoreOrDetailsOrHighest;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return weeksTotals.every((element) => element == 0)
        ? Image.asset(AppIcons.noDataCate)
        : ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: weeksTotals.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Card(
                    margin: EdgeInsets.symmetric(horizontal: 16.sp),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.sp),
                    ),
                    elevation: 4.sp,
                    color: AppColor.lightGrey,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text('Week ${index + 1}',
                                  overflow: TextOverflow.ellipsis,
                                  style: textTheme.headline5),
                              const Spacer(),
                              Text(
                                '${weeksTotals[index]} LE',
                                style:
                                    textTheme.headline5?.copyWith(color: priceColor),
                              ),
                            ],
                          ),
                          SizedBox(height: 1.h),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(weekRanges[index], style: textTheme.subtitle1),
                          ),
                          SizedBox(height: 1.h),
                          Row(
                            children: [
                              Column(
                                children: [
                                  // Visibility(
                                  //   visible: isRepeated,
                                  //   child: Column(
                                  //     children: [
                                  //       SizedBox(height: 2.h),
                                  //       Align(
                                  //         alignment: Alignment.centerLeft,
                                  //         child: Text(expenseModel.repeatType,
                                  //             style: textTheme.subtitle1),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  Visibility(
                                    visible: true,
                                    child: switchWidgets(
                                        onPress: onSeeMore,
                                        switchWidgets: seeMoreOrDetailsOrHighest),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 3.h)
                ],
              );
            });
  }
}
