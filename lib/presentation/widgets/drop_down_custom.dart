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
      required this.onChangedFunc})
      : super(key: key);
  final List<DropdownMenuItem<String>> dropDownList;
  String? value;
  String hint;
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
          color: Colors.blueGrey.withOpacity(.2),
          borderRadius: BorderRadius.circular(20)),
      child: DropdownButton<String>(
        elevation: 0,
        isExpanded: true,
        dropdownColor: Theme.of(context).primaryColor,
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
            SvgPicture.asset(AppIcons.downArrow, color: AppColor.primaryColor),
      ),
    );
  }
}
