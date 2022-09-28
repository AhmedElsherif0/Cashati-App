import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class UnderLineDivider extends StatelessWidget {
  const UnderLineDivider({Key? key, required this.color}) : super(key: key);

  final Color color ;

  @override
  Widget build(BuildContext context) {
    return
      Divider(
        color: color,
        thickness: 8,
        indent: 10.w,
        endIndent: 10.w,
      );
  }
}
