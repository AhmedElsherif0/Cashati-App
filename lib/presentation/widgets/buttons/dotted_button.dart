import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DottedButton extends StatelessWidget {
  const DottedButton({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.title,
  }) : super(key: key);

  final void Function() onPressed;
  final String text;
  final String title;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Align(
      alignment: Alignment.center,
      child: InkWell(
        onTap: onPressed,
        child: DottedBorder(
          color: Colors.white,
          strokeCap: StrokeCap.round,
          dashPattern: const [3, 6],
          borderType: BorderType.RRect,
          padding: EdgeInsets.symmetric(horizontal: 40.sp, vertical: 18.sp),
          radius: Radius.circular(4.sp),
          child: Text('$text $title', style: textTheme.bodyText1),
        ),
      ),
    );
  }
}
