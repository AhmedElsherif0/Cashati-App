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
      this.isExpanded,
      this.icon,
      required this.onChangedFunc})
      : super(key: key);
  final List<DropdownMenuItem<String>> dropDownList;
  String? value;
  final String hint;
  final String? icon;
  final Color? backgroundColor;
  final bool? isExpanded;
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
          color: widget.backgroundColor??Colors.blueGrey.withOpacity(.2),
          borderRadius: BorderRadius.circular(20)),
      child: DropdownButton<String>(
        style: TextStyle(color: AppColor.primaryColor),
        elevation: 0,
        isExpanded:widget.isExpanded?? true,
        dropdownColor: Colors.white,
        borderRadius: BorderRadius.circular(20),
        underline: Divider(color:Colors.blueGrey.withOpacity(.1) ,),

        hint: Text(
          widget.hint,
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(fontWeight: FontWeight.w300, fontSize: 13),
        ),
        value: widget.value,
        items: widget.dropDownList,
        onChanged: (value) {
          widget.onChangedFunc(value!);
        },
        icon:
            SvgPicture.asset(widget.icon??AppIcons.downArrow, color: AppColor.primaryColor),
      ),
    );
  }
}
