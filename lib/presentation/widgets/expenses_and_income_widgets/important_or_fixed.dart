import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:temp/constants/enum_classes.dart';

import '../../styles/colors.dart';

class PriorityWidget extends StatelessWidget {
  const PriorityWidget({
    Key? key,
    this.text = 'important',
    this.color =AppColor.secondColor  ,
  }) : super(key: key);

  final String text;
  final Color color;

  Color switchPriorityColor(PriorityType? priorityType) {
    switch (priorityType) {
      case PriorityType.HigherExpenses:
        return AppColor.red;
      case PriorityType.Important:
      case PriorityType.Fixed:
        return AppColor.secondColor;
      default:
        AppColor.pinkishGrey;
    }
    return AppColor.pinkishGrey;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.circle,
            color: color , size: 10.dp),
        SizedBox(width: 0.5.w),
        Text(text,
            style: Theme.of(context).textTheme.caption,
            overflow: TextOverflow.ellipsis,
            softWrap: true),
      ],
    );
  }
}
