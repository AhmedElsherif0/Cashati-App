import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../styles/colors.dart';

class ChartBar extends StatefulWidget {
  const ChartBar({
    Key? key,
    required this.height,
    required this.percentage,
    required this.index,
    this.totalExp = 0.0,
  }) : super(key: key);

  final double? height;
  final double totalExp;
  final int index;
  final String percentage;

  @override
  State<ChartBar> createState() => _ChartBarState();
}

class _ChartBarState extends State<ChartBar> {

  @override
  void didUpdateWidget(covariant ChartBar oldWidget) {
    _height = widget.height!;
    super.didUpdateWidget(oldWidget);
  }

  double _height = 0;

  @override
  Widget build(BuildContext context) {
    final textTheme =
        Theme.of(context).textTheme.headline6?.copyWith(fontSize: 8.5.sp);
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.center,
            child: Text('${widget.totalExp.toStringAsFixed(0)}%', style: textTheme),
          ),
        ),
        Flexible(
          flex: 6,

          /// bar style
          child: AnimatedContainer(
            height: _height,
            curve: Curves.fastOutSlowIn,
            duration: const Duration(seconds: 3),
            constraints: BoxConstraints(minHeight: 3.h, maxHeight: 30.h),
            child: SizedBox(
              height: (widget.height! >= 10) ? widget.height : 3.h,
              width: 5.w,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColor.primaryColor,
                  borderRadius: BorderRadius.circular(12.sp),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 1.h),
        Expanded(
          flex: 2,

          /// weekly or monthly
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Transform(
              transform: Matrix4.rotationZ(-65 * pi / 180),
              child:
                  Text('${widget.percentage} ${widget.index + 1}', style: textTheme),
            ),
          ),
        )
      ],
    );
  }
}
