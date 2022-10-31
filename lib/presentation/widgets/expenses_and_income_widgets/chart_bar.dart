import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../styles/colors.dart';

class ChartBar extends StatelessWidget {
  const ChartBar(
      {Key? key,
     required this.height,
      required this.percentage,
      required this.index,
      required this.after})
      : super(key: key);

  final double? height;
  final num after;
  final int index;
  final String percentage;

  @override
  Widget build(BuildContext context) {

    final textTheme =
        Theme.of(context).textTheme.headline6?.copyWith(fontSize: 8.5.sp);
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          flex: 2,
          child: Align(
            alignment: Alignment.center,
            child: Text(
              after > 100
                  ? '${after.toStringAsFixed(0)}%'
                  : '${after.toStringAsFixed(1)}%',
              style: textTheme,
            ),
          ),
        ),
        Flexible(
          flex: 10,
          child: SizedBox(
            height: ( height! <= 20) ? 3.h :height,
            width: 5.w,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: AppColor.primaryColor,
                borderRadius: BorderRadius.circular(12.sp),
              ),
            ),
          ),
        ),
        const Spacer(flex: 2),
        Expanded(
          flex: 2,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Transform(
              transform: Matrix4.rotationZ(-65 * pi / 180),
              child: Text('Week ${index + 1}',
                  style: textTheme),
            ),
          ),
        )
      ],
    );
  }
}
