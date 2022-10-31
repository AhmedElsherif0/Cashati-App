import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../styles/colors.dart';

class ImportantOrFixed extends StatelessWidget {
  const ImportantOrFixed({
    Key? key,
    this.circleColor = AppColor.secondColor,
    this.text = 'important',
  }) : super(key: key);

  final Color circleColor;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.circle, color: circleColor, size: 10.sp),
        SizedBox(width: 0.5.w,),
        Text(text,
            style: Theme.of(context).textTheme.caption,
            overflow: TextOverflow.ellipsis,
        softWrap: true),
      ],
    );
  }
}
