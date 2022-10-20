import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/constants/app_icons.dart';
import '../../constants/enum_classes.dart';
import '../styles/colors.dart';
import '../widgets/expenses_and_income_widgets/underline_text_button.dart';


class TabCardView extends StatelessWidget {
  const TabCardView({
    Key? key,
    required this.listItem,
    required this.expensesName,
    required this.isPriority,
    required this.price,
    required this.dateTime,
    required this.onPressSeeMore,
    this.priorityName = 'Important',
    this.priceColor = AppColor.red,
    required this.isVisible, this.seeMoreOrDetailsOrHighest,
     this.transaction = 'Expenses',
  }) : super(key: key);

  final bool isPriority;
  final bool isVisible;
  final List listItem;
  final String expensesName;
  final String transaction;
  final String priorityName;
  final String price;
  final Color priceColor;
  final String dateTime;
  final void Function() onPressSeeMore;
  final SwitchWidgets? seeMoreOrDetailsOrHighest;

  Widget switchWidgets(SwitchWidgets? switchWidgets, TextTheme textTheme) {
    Widget widget = const SizedBox.shrink();
    switch (switchWidgets) {
      case SwitchWidgets.higherExpenses:
        widget = _highestExpenses(textTheme);
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

  Widget _highestExpenses(textTheme) => Row(
        children: [
          Icon(Icons.circle, color: AppColor.red, size: 10.sp),
          SizedBox(width: 0.2.w),
          Text('Highest $transaction', style: textTheme.subtitle1),
        ],
      );

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return listItem.isEmpty
        ? Image.asset(AppIcons.noDataCate)
        : ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: listItem.length,
            itemBuilder: (_, index) => Column(
              children: [
                Card(
                  margin: EdgeInsets.symmetric(horizontal: 16.sp),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.sp)),
                  elevation: 4.sp,
                  color: AppColor.lightGrey,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(expensesName, style: textTheme.headline5),
                            const Spacer(),
                            Text(
                              '${price} LE',
                              style: textTheme.headline5
                                  ?.copyWith(color: priceColor),
                            ),
                          ],
                        ),
                        SizedBox(height: 1.h),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(dateTime, style: textTheme.subtitle1),
                        ),
                        Row(
                          children: [
                            Visibility(
                                visible: isVisible,
                                child: switchWidgets(
                                    seeMoreOrDetailsOrHighest, textTheme)),
                            const Spacer(),
                            if (isPriority)
                              Card(
                                margin: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.sp)),
                                color: AppColor.pinkishGrey,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 2.w, vertical: 0.5.h),
                                  child: Row(
                                    children: [
                                      Text(
                                        priorityName,
                                        style: textTheme.caption
                                      ),
                                      Icon(Icons.circle,
                                          color: AppColor.secondColor,
                                          size: 14.sp)
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 3.h)
              ],
            ),
          );
  }
}
