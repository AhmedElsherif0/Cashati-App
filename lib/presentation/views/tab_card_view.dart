import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/constants/app_icons.dart';
import 'package:temp/presentation/widgets/expenses_and_income_widgets/important_or_fixed.dart';
import '../../constants/enum_classes.dart';
import '../styles/colors.dart';
import '../widgets/expenses_and_income_widgets/underline_text_button.dart';

class TabCardView extends StatelessWidget {
  const TabCardView(
      {Key? key,
      required this.listItem,
      required this.expensesName,
      required this.isPriority,
      required this.price,
      required this.dateTime,
      required this.onPressSeeMore,
      this.priorityName = 'Important',
      this.priceColor = AppColor.red,
      required this.isVisible,
      this.seeMoreOrDetailsOrHighest,
      this.transaction = 'Expenses',
      this.isRepeated = false,
      this.priorityColor = AppColor.secondColor})
      : super(key: key);

  final bool isPriority;
  final bool isVisible;
  final bool isRepeated;
  final List listItem;
  final String expensesName;
  final String transaction;
  final String priorityName;
  final String price;
  final Color priceColor;
  final Color priorityColor;
  final String dateTime;
  final void Function() onPressSeeMore;
  final SwitchWidgets? seeMoreOrDetailsOrHighest;

  Widget switchWidgets(SwitchWidgets? switchWidgets) {
    Widget widget = const SizedBox.shrink();
    switch (switchWidgets) {
      case SwitchWidgets.higherExpenses:
        widget = ImportantOrFixed(
            text: 'Heighset $expensesName', circleColor: AppColor.red);
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
    return listItem.isEmpty
        ? Image.asset(AppIcons.noDataCate)
        : ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: listItem.length,
            itemBuilder: (_, index) {
              index += 1;
              return Column(
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
                              Text('$expensesName $index',
                                  style: textTheme.headline5),
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
                          SizedBox(height: 1.h),
                          Row(
                            children: [
                              Column(
                                children: [
                                  Visibility(
                                    visible: isRepeated,
                                    child: Column(
                                      children: [
                                        SizedBox(height: 2.h),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text('No Repeat',
                                              style: textTheme.subtitle1),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Visibility(
                                    visible: isVisible,
                                    child: switchWidgets(
                                        seeMoreOrDetailsOrHighest),
                                  ),
                                ],
                              ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      const Spacer(),
                                      ImportantOrFixed(
                                        text: priorityName,
                                        circleColor: priorityColor,
                                      ),
                                    ],
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
              );
            });
  }
}
