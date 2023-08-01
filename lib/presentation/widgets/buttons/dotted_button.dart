import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DottedButton extends StatelessWidget {
  const DottedButton({
    Key? key,
    required this.onPressed,
    required this.text, required this.icon,
  }) : super(key: key);

  final void Function() onPressed;
  final String text;
  final String icon;

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
          dashPattern: const [3, 7],
          borderType: BorderType.RRect,
          strokeWidth: 2,
          padding: EdgeInsets.symmetric(horizontal: 30.dp, vertical: 18.dp),
          radius: Radius.circular(4.dp),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(icon),
              SizedBox(width: 2.h),
              Text(text , style: textTheme.bodyText1),
            ],
          ),
        ),
      ),
    );
  }
}
