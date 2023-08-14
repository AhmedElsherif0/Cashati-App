import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:temp/constants/app_strings.dart';
import 'package:temp/presentation/styles/decorations.dart';

import '../../styles/colors.dart';

class DefaultDropDownButton extends StatefulWidget {
  final Color? iconColor;
  final List<String> items;
  final bool isExpanded;
  final bool isDirection;
  String selectedValue;

  DefaultDropDownButton({
    Key? key,
    this.iconColor,
    required this.selectedValue,
    required this.items,
    this.isExpanded = false,
    this.isDirection = true,
  }) : super(key: key);

  @override
  State<DefaultDropDownButton> createState() => _DefaultDropDownButtonState();
}

class _DefaultDropDownButtonState extends State<DefaultDropDownButton> {
  Color get dropDownColor =>
      widget.selectedValue != AppStrings.chooseCurrency
          ? AppColor.white
          : AppColor.primaryColor;

  IconData get iconDirection =>
      widget.isDirection ? Icons.keyboard_arrow_left : Icons.keyboard_arrow_right;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      height: 8.h,
      width: 100.w,
      child: Card(
        color: widget.selectedValue != AppStrings.chooseCurrency
            ? AppColor.primaryColor
            : AppColor.white,
        shape: AppDecorations.dropDownCurrency,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.dp),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              isExpanded: widget.isExpanded,
              elevation: 8,
              menuMaxHeight: 25.h,
              iconEnabledColor: AppColor.primaryColor,
              disabledHint: Text(widget.items[0]),
              isDense: true,
              borderRadius: BorderRadius.circular(12.dp),
              focusColor: AppColor.primaryColor,
              iconDisabledColor: AppColor.primaryColor,
              dropdownColor:
                  widget.isExpanded ? AppColor.primaryColor : AppColor.white,
              style: textTheme.bodyText2,
              icon: Icon(
                  size: 34.dp,
                  widget.isExpanded ? Icons.keyboard_arrow_down : iconDirection,
                  color: dropDownColor),
              hint: Text(widget.selectedValue,
                  style: textTheme.bodyText2?.copyWith(color: dropDownColor)),
              items: widget.items
                  .map(
                    (item) => DropdownMenuItem<String>(
                        value: item,
                        child: Center(
                          child: Text(item,
                              style: textTheme.bodyText2
                                  ?.copyWith(fontWeight: FontWeight.w500)),
                        )),
                  )
                  .toList(),
              onChanged: (String? value) =>
                  setState(() => widget.selectedValue = value!),
            ),
          ),
        ),
      ),
    );
  }
}
