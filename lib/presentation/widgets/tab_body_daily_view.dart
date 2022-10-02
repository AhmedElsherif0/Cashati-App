import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../styles/colors.dart';

class TabBodyView extends StatelessWidget {
  const TabBodyView(
      {Key? key,
      required this.isListIsEmpty,
      required this.listItemCount,
      required this.expensesName,
      required this.isImportant,
      required this.price,
      required this.dateTime,
      required this.onPressSeeMore})
      : super(key: key);

  final bool isListIsEmpty;
  final bool isImportant;
  final int listItemCount;
  final String expensesName;
  final String price;
  final String dateTime;
  final void Function() onPressSeeMore;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return isListIsEmpty
        ? Image.asset('assets/images/No data-cuate 1.png')
        : ListView.builder(
            itemCount: listItemCount,
            itemBuilder: (_, index) => Column(
              children: [
                Card(
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.sp)),
                  elevation: 4.sp,
                  color: AppColor.lightGrey,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(expensesName, style: textTheme.headline5),
                            const Spacer(),
                            Text('${price} LE',
                                style: textTheme.headline5
                                    ?.copyWith(color: Colors.red)),
                          ],
                        ),
                        SizedBox(height: 1.h),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(dateTime, style: textTheme.subtitle1),
                        ),
                        Row(
                          children: [
                            TextButton(
                              onPressed: onPressSeeMore,
                              style: TextButton.styleFrom(
                                  backgroundColor: AppColor.lightGrey,
                                  onSurface:AppColor.grey ,
                                  //foregroundColor: AppColor.grey,
                                  padding: EdgeInsets.zero,
                                  alignment: Alignment.centerLeft),
                              child: const Text(
                                'see more',
                                style: TextStyle(
                                  color: AppColor.pineGreen,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  decoration: TextDecoration.underline,
                                  decorationStyle: TextDecorationStyle.solid,
                                  decorationColor: AppColor.pineGreen,
                                ),
                              ),
                            ),
                            const Spacer(),
                            if (isImportant)
                              Card(
                                margin: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                color: AppColor.pinkishGrey,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 2.w, vertical: 3),
                                  child: Row(
                                    children: const [
                                      Text(
                                        'Important',
                                        style: TextStyle(
                                            color: AppColor.pineGreen,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Icon(Icons.circle,
                                          color: AppColor.secondColor)
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
                SizedBox(height: 4.h)
              ],
            ),
          );
  }
}
