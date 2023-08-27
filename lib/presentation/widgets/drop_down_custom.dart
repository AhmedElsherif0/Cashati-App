import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
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
      required this.leadingIcon,
      this.arrowIconColor,
      this.hintStyle,
      required this.onChangedFunc,
      this.isEnglish = true, this.leadingIconColor ,this.iconHeight})
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
  final bool? isEnglish;
  final TextStyle? hintStyle;
  final Function(String) onChangedFunc;

  @override
  State<DropDownCustomWidget> createState() => _DropDownCustomWidgetState();
}

class _DropDownCustomWidgetState extends State<DropDownCustomWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: widget.backgroundColor ?? AppColor.primaryColor.withOpacity(.2),
          borderRadius: BorderRadius.circular(20)),
      child: DropdownButton<String>(
        style: const TextStyle(color: AppColor.primaryColor),
        elevation: 0,
        isExpanded: widget.isExpanded,
        dropdownColor: Colors.white,
        borderRadius: BorderRadius.circular(20),
        underline: Divider(color: Colors.blueGrey.withOpacity(.1)),
        hint: Visibility(
          visible: widget.leadingIcon.isEmpty,
          replacement: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            textDirection:
                widget.isEnglish ?? true ? TextDirection.ltr : TextDirection.rtl,
            children: [
              if(widget.leadingIconColor== null)
              SvgPicture.asset(widget.leadingIcon,
                  height: 20.dp,
                  color:  widget.leadingIconColor),
              if(widget.leadingIconColor== null)
                const SizedBox(width: 10),
                Text(
                widget.hint.tr(),
                style: widget.hintStyle ??
                    Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontWeight: FontWeight.w300, fontSize: 13),
              ),
              if(widget.leadingIconColor!= null)
                SvgPicture.asset(widget.leadingIcon,
                  height: 20.dp,
                  color:  widget.leadingIconColor),
            ],
          ),
          child: Text(
            widget.hint.tr(),
            style: widget.hintStyle ??
                Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(fontWeight: FontWeight.w300, fontSize: 13),
          ),
        ),
        value: widget.value?.tr(),
        items: widget.dropDownList,
        onChanged: (value) => widget.onChangedFunc(value!),
        icon: widget.isExpanded
            ? SvgPicture.asset(widget.icon ?? AppIcons.downArrow,
                height: widget.iconHeight??16.dp, color: AppColor.primaryColor)
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SvgPicture.asset(widget.icon ?? AppIcons.downArrow,
                    color: widget.arrowIconColor ?? AppColor.primaryColor),
              ),
      ),
    );
  }
}
