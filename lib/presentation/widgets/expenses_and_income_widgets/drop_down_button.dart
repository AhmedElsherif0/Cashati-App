import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../styles/colors.dart';

class DefaultDropDownButton extends StatefulWidget {
  final Color? iconColor;
  final double? iconSize;
  final String defaultText;
  final List<String> items;
  final bool isExpanded;
  String selectedValue;

   DefaultDropDownButton({
    Key? key,
    this.iconColor,
    this.selectedValue = 'Choose day',
    this.iconSize,
    required this.defaultText,
    required this.items,
    this.isExpanded = false,
  }) : super(key: key);

  @override
  State<DefaultDropDownButton> createState() => _DefaultDropDownButtonState();
}

class _DefaultDropDownButtonState extends State<DefaultDropDownButton> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      height: 5.8.h,
      child: Card(
        elevation: 4.sp,
        color: AppColor.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.sp)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.sp),
          child: AnimatedContainer(
            duration: const Duration(seconds: 300),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                isExpanded: widget.isExpanded,
                elevation: 8,
                menuMaxHeight: 30.h,
                iconEnabledColor: AppColor.black,
                disabledHint: Text(widget.items[0]),
                isDense: true,
                borderRadius: BorderRadius.circular(8.sp),
                focusColor: AppColor.grey,
                dropdownColor: AppColor.white,
                style: textTheme.bodyText2,
                icon: Icon(
                  size: 16.sp,
                  widget.isExpanded
                      ? Icons.keyboard_arrow_down
                      : Icons.keyboard_arrow_right,
                  color: AppColor.pineGreen,
                ),
                hint: Text(
                  widget.selectedValue,
                  style:
                      textTheme.subtitle1,
                ),
                items: widget.items
                    .map(
                      (item) => DropdownMenuItem<String>(
                          value: item,
                              child: Center(
                                child: Text(item, style: textTheme.subtitle1
                                    ?.copyWith(fontWeight: FontWeight.w500)),
                              )),
                    )
                    .toList(),
                onChanged: (String? value) => setState(
                  () => widget.selectedValue = value!,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
