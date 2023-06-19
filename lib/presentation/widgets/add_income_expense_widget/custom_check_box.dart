import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../styles/colors.dart';

class CustomCheckBox extends StatefulWidget {
  const CustomCheckBox(
      {super.key,
      required this.isImportant,
      required this.text,
      required this.onChanged});

  final bool isImportant;
  final String text;
  final void Function(bool?) onChanged;

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 3.h,
          width: 4.w,
          child: Checkbox(
            value: widget.isImportant,
            onChanged: widget.onChanged,
            hoverColor: AppColor.primaryColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            activeColor: AppColor.white,
            checkColor: AppColor.white,
            fillColor: MaterialStateProperty.all(AppColor.primaryColor),
          ),
        ),
        SizedBox(width: 2.5.w),
        Text(
          widget.text,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: AppColor.primaryColor),
        )
      ],
    );
  }
}
