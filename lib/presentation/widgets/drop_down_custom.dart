import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:temp/constants/app_icons.dart';
import 'package:temp/presentation/styles/colors.dart';

class DropDownCustomWidget extends StatefulWidget {
  DropDownCustomWidget(
      {Key? key,
      required this.dropDownList,
      required this.hint,
      this.value,
      this.backgroundColor,
      this.isExpanded = true,
      this.icon,
      this.leadingIcon = '',
      this.arrowIconColor,
      this.hintStyle,
      required this.onChangedFunc})
      : super(key: key);
  final List<DropdownMenuItem<String>> dropDownList;
  String? value;
  final String hint;
  final String? icon;
  String? leadingIcon = '';
  final Color? backgroundColor;
  final Color? arrowIconColor;
  final bool? isExpanded;
  final TextStyle? hintStyle;
  final Function(String) onChangedFunc;

  @override
  State<DropDownCustomWidget> createState() => _DropDownCustomWidgetState();
}

class _DropDownCustomWidgetState extends State<DropDownCustomWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
          color: widget.backgroundColor ?? Colors.blueGrey.withOpacity(.2),
          borderRadius: BorderRadius.circular(20)),
      child: DropdownButton<String>(
        style: TextStyle(color: AppColor.primaryColor),
        elevation: 0,
        isExpanded: widget.isExpanded ?? true,
        dropdownColor: Colors.white,
        borderRadius: BorderRadius.circular(20),
        underline: Divider(
          color: Colors.blueGrey.withOpacity(.1),
        ),
        hint: Visibility(
          visible: widget.leadingIcon!.isEmpty,
          replacement: Row(
            children: [
              SvgPicture.asset(widget.leadingIcon ?? AppIcons.filterGreen),
              const SizedBox(width: 10),
              Text(
                widget.hint,
                style: widget.hintStyle ??
                    Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontWeight: FontWeight.w300, fontSize: 13),
              )
            ],
          ),
          child: Text(
            widget.hint,
            style: widget.hintStyle ??
                Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(fontWeight: FontWeight.w300, fontSize: 13),
          ),
        ),
        value: widget.value,
        items: widget.dropDownList,
        onChanged: (value) => widget.onChangedFunc(value!),
        icon: widget.isExpanded!
            ? SvgPicture.asset(widget.icon ?? AppIcons.downArrow,
                color: AppColor.primaryColor)
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SvgPicture.asset(widget.icon ?? AppIcons.downArrow,
                    color: widget.arrowIconColor ?? AppColor.primaryColor),
              ),
      ),
    );
  }
}
