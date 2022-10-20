import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../styles/colors.dart';

class ConfirmPayingTitleCard extends StatelessWidget {
  const ConfirmPayingTitleCard({
    Key? key,
    required this.cardTitle,
    required this.index,
  }) : super(key: key);

  final String cardTitle;
  final int index;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
            color: AppColor.primaryColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.sp),
                topRight: Radius.circular(24.sp))),
        child: Align(
          alignment: Alignment.center,
          child: Text('$cardTitle $index',
              style: textTheme.headline5?.copyWith(color: AppColor.white)),
        ),
      ),
    );
  }
}
