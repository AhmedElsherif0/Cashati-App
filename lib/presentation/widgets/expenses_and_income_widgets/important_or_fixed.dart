import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/constants/enum_classes.dart';
import 'package:temp/data/repository/helper_class.dart';

import '../../styles/colors.dart';

class PriorityWidget extends StatelessWidget with HelperClass{
  const PriorityWidget({
    Key? key,
    this.text = 'important',
    this.color =AppColor.secondColor  ,
  }) : super(key: key);

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.circle,
            color: color , size: 10.sp),
        SizedBox(width: 0.5.w),
        Text(text,
            style: Theme.of(context).textTheme.caption,
            overflow: TextOverflow.ellipsis,
            softWrap: true),
      ],
    );
  }
}
