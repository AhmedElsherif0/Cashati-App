import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../styles/colors.dart';

class TabBarItem extends StatelessWidget {
  const TabBarItem({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.sp),
        border: Border.all(width: 1.sp, color: AppColor.primaryColor),
      ),
      child: Align(alignment: Alignment.center, child: Text(text)),
    );
  }
}
