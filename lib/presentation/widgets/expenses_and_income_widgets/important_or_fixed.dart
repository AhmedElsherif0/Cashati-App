import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../styles/colors.dart';

class PriorityWidget extends StatelessWidget {
  const PriorityWidget({
    Key? key,
    this.isPriority = true,
    this.text = 'important',
  }) : super(key: key);

  final String text;
  final bool isPriority;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.circle,
            color: isPriority ? AppColor.secondColor : AppColor.grey, size: 10.sp),
        SizedBox(width: 0.5.w),
        Text(text,
            style: Theme.of(context).textTheme.caption,
            overflow: TextOverflow.ellipsis,
            softWrap: true),
      ],
    );
  }
}
