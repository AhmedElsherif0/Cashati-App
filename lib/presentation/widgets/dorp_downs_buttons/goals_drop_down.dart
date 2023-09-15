import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:temp/presentation/styles/colors.dart';

import '../../../constants/app_icons.dart';

class GoalsFilterWidget extends StatefulWidget {
  GoalsFilterWidget(
      {Key? key,
      required this.dropDownList,
      required this.hint,
      this.value,
      this.backgroundColor,
      this.isExpanded = true,
      this.icon,
      required this.leadingIcon,
      this.arrowIconColor,
      this.hintStyle,
      required this.onChangedFunc,
      this.isEnglish = true,
      this.leadingIconColor,
      this.iconHeight,
      this.iconWidget = const SizedBox.shrink()})
      : super(key: key);

  final List<DropdownMenuItem<String>> dropDownList;
  String? value;
  final String hint;
  final String? icon;
  final String leadingIcon;
  final Color? backgroundColor;
  final Color? arrowIconColor;
  final Color? leadingIconColor;
  final bool isExpanded;
  final double? iconHeight;
  final bool isEnglish;
  final TextStyle? hintStyle;
  final Function(String) onChangedFunc;
  final Widget iconWidget;

  @override
  State<GoalsFilterWidget> createState() => _GoalsFilterWidgetState();
}

class _GoalsFilterWidgetState extends State<GoalsFilterWidget> {
  bool isLeading() =>
      widget.leadingIconColor == null || widget.leadingIconColor.toString().isEmpty;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: widget.backgroundColor ?? AppColor.primaryColor.withOpacity(.2),
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: DropdownButton<String>(
          style: const TextStyle(color: AppColor.primaryColor),
          elevation: 0,
          isExpanded: widget.isExpanded,
          dropdownColor: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          underline: const DropdownButtonHideUnderline(child: SizedBox.shrink()),
          hint: Visibility(
            visible: widget.leadingIcon.isEmpty,
            replacement: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (widget.iconWidget == const SizedBox.shrink()) SizedBox(width: 5.w),
                if (widget.icon != null)
                  SvgPicture.asset(widget.icon ?? AppIcons.downArrow,
                      height: widget.iconHeight ?? 10.dp, color: AppColor.black),
                if (isLeading()) SizedBox(width: 5.w),
                Text(
                  widget.hint.tr(),
                  style: widget.hintStyle ??
                      textTheme.bodyText2!
                          .copyWith(fontWeight: FontWeight.w300, fontSize: 13.dp),
                ),
                if (isLeading() && widget.icon != null) SizedBox(width: 5.w),
                SvgPicture.asset(widget.leadingIcon,
                    height: 20.dp, color: widget.leadingIconColor),
              ],
            ),
            child: Text(
              widget.hint.tr(),
              style: widget.hintStyle ??
                  textTheme.bodyText2!
                      .copyWith(fontWeight: FontWeight.w300, fontSize: 13),
            ),
          ),
          value: widget.value?.tr(),
          items: widget.dropDownList,
          onChanged: (value) => widget.onChangedFunc(value!),
          icon: widget.iconWidget),
    );
  }
}
