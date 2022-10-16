import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/constants/app_icons.dart';

import '../../styles/colors.dart';
import 'underline_text_button.dart';

class TabBodyView extends StatelessWidget {
  const TabBodyView(
      {Key? key,
      required this.listItem,
      required this.expensesName,
      required this.isPriority,
      required this.price,
      required this.dateTime,
      required this.onPressSeeMore,
      this.priorityName = 'Important',
      this.priceColor = AppColor.red})
      : super(key: key);

  final bool isPriority;
  final List listItem;
  final String expensesName;
  final String priorityName;
  final String price;
  final Color priceColor;
  final String dateTime;
  final void Function() onPressSeeMore;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return listItem.isEmpty
        ? Image.asset(AppIcons.noDataCate)
        : ListView.builder(
            itemCount: listItem.length,
            itemBuilder: (_, index) => Column(
              children: [
                Card(
                  margin: EdgeInsets.symmetric(horizontal: 8.sp),
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
                              style: textTheme.headline5?.copyWith(
                                  color: priorityName == 'Important'
                                      ? AppColor.red
                                      : AppColor.primaryColor),
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
                            UnderLineTextButton(
                                onPressed: onPressSeeMore, text: 'see more'),
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
                                        style: textTheme.caption,
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
