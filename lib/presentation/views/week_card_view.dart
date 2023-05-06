import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/constants/app_icons.dart';
import 'package:temp/constants/app_lists.dart';
import 'package:temp/constants/enum_classes.dart';
import 'package:temp/data/models/transactions/transaction_model.dart';
import 'package:temp/presentation/styles/colors.dart';
import 'package:temp/presentation/widgets/expenses_and_income_widgets/important_or_fixed.dart';
import 'package:temp/presentation/widgets/expenses_and_income_widgets/underline_text_button.dart';

class WeekCardViewEdited extends StatelessWidget {
  const WeekCardViewEdited(
      {Key? key,
        required this.weeksTotals,
        required this.onPressSeeMore,
        this.priceColor = AppColor.red,
        this.seeMoreOrDetailsOrHighest,
        required this.chosenDay ,
        this.priorityColor = AppColor.secondColor})
      : super(key: key);

  final List<num> weeksTotals;
  final DateTime chosenDay;
  final Color priceColor;
  final Color priorityColor;
  final void Function() onPressSeeMore;
  final SwitchWidgets? seeMoreOrDetailsOrHighest;

  Widget switchWidgets(SwitchWidgets? switchWidgets) {
    Widget widget;
    switch (switchWidgets) {
      case SwitchWidgets.higherExpenses:
        widget = PriorityWidget(
            text: 'Heighset ',
            circleColor: AppColor.red);
        break;
      case SwitchWidgets.seeMore:
        widget =
            UnderLineTextButton(onPressed: onPressSeeMore, text: 'see more');
        break;
      default:
        widget = const SizedBox.shrink();
    }
    return widget;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return
         ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: 4,
        itemBuilder: (context, index) {
         // final expenseModel = expenseList[index];
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
                  padding:
                  EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text('Week ${index + 1}',
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.headline5),
                          const Spacer(),
                          Text(
                            '${weeksTotals[index] ?? 200} LE',
                            style: textTheme.headline5
                                ?.copyWith(color: priceColor),
                          ),
                        ],
                      ),
                      SizedBox(height: 1.h),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          AppConstantList.getWeekRange(chosenDay: chosenDay,)[index],
                          style: textTheme.subtitle1,
                        ),
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
                                    seeMoreOrDetailsOrHighest),
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
