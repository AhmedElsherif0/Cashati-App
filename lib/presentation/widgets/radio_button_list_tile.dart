import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../data/models/expenses/expenses_lists.dart';
import '../styles/colors.dart';

class RadioButtonListTile extends StatefulWidget {
   RadioButtonListTile({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.text,
  }) : super(key: key);

  final Importance value;
  final String text;
   Importance groupValue;
  final void Function(Importance?) onChanged;

  @override
  State<RadioButtonListTile> createState() => _RadioButtonListTileState();
}

class _RadioButtonListTileState extends State<RadioButtonListTile> {
  @override
  Widget build(BuildContext context) {
    return  Row(
    mainAxisSize: MainAxisSize.min,
    children: [
     SizedBox(
          height: 14.sp,
          width: 14.sp,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: widget.value == widget.groupValue
                  ? AppColor.secondColor
                  : AppColor.pinkishGrey,
              borderRadius: BorderRadius.all(Radius.circular(12.sp)),
            ),
            child: Radio(
              focusColor: AppColor.lightGrey,
              hoverColor: AppColor.lightGrey,
              fillColor: widget.value == widget.groupValue ? MaterialStateProperty.all(
                  AppColor.secondColor) : MaterialStateProperty.all(
                AppColor.pinkishGrey),
              value: widget.value,
              groupValue: widget.groupValue,
              onChanged: widget.onChanged,
              activeColor: AppColor.secondColor,
            ),
          ),
        ),
      SizedBox(width: 0.7.w),
      Text(widget.text, style: Theme
          .of(context)
          .textTheme
          .caption),
    ],
    );
  }
}
