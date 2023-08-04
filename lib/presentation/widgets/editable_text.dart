import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/svg.dart';
import '../styles/colors.dart';

class EditableInfoField extends StatefulWidget {
  const EditableInfoField(
      {Key? key,
      required this.textEditingController,
      required this.hint,
      required this.iconName,
      this.containerWidth,
      this.trailing,
      this.keyboardType,
      this.maxLines = 1,
      this.header = '',  this.backGroundColor })
      : super(key: key);
  final TextEditingController textEditingController;
  final String hint;
  final String header;
  final String iconName;
  final TextInputType? keyboardType;
  final double? containerWidth;
  final Widget? trailing;
  final int maxLines;
  final Color? backGroundColor;

  @override
  _EditableInfoFieldState createState() => _EditableInfoFieldState();
}

class _EditableInfoFieldState extends State<EditableInfoField> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Container(
      height: 6.h,
      width: widget.containerWidth,
      decoration: BoxDecoration(
          color: widget.backGroundColor ?? AppColor.primaryColor.withOpacity(0.3) ,
          borderRadius: BorderRadius.circular(16.dp)),
      padding: EdgeInsets.symmetric(horizontal: 8.dp),
      child: ListTile(
        title: Column(
          children: [
            Visibility(
                visible: widget.header.isEmpty ? false : true,
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(widget.header, style: theme.subtitle2))),
            TextFormField(
              keyboardType: widget.keyboardType ?? TextInputType.text,
              controller: widget.textEditingController,
              validator: (value) => value!.isEmpty
                  ? 'This field can\'t be empty'
                  :
                  // widget.subCategoryName=value;
                  null,
              // },
              onChanged: (value) {},
              cursorColor: AppColor.primaryColor,
              style: theme.bodyText2!.copyWith(fontWeight: FontWeight.w300),
              maxLines: widget.maxLines,
              decoration: InputDecoration(
                  hintText: widget.hint,
                  hintStyle: theme.bodyText2!.copyWith(
                    fontWeight: FontWeight.w300,
                    fontSize: 12.dp ,
                    color: AppColor.primaryColor,
                  ),
                  border: InputBorder.none),
            ),
          ],
        ),
        leading: widget.iconName.isEmpty ? null : SvgPicture.asset(widget.iconName),
        trailing: widget.trailing ?? const SizedBox.shrink(),
      ),
    );
  }
}
