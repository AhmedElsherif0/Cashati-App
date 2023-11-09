import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/svg.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:temp/constants/app_strings.dart';
import 'package:temp/presentation/styles/decorations.dart';

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
      this.header = '',
      this.isEnabled,
      this.backGroundColor})
      : super(key: key);
  final TextEditingController textEditingController;
  final String hint;
  final String header;
  final String iconName;
  final TextInputType? keyboardType;
  final double? containerWidth;
  final Widget? trailing;
  final bool? isEnabled;
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
      // height: 6.h,
      width: widget.containerWidth,
      decoration: AppDecorations.editTextDecoration(widget.backGroundColor),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ListTile(
        title: Column(
          children: [
            Visibility(
                visible: widget.header.isEmpty ? false : true,
                child: Align(
                    alignment: translator.activeLanguageCode == 'en'
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    child: Text(widget.header.tr(), style: theme.subtitle2))),
            TextFormField(
              enabled: widget.isEnabled ?? true,
              keyboardType: widget.keyboardType ?? TextInputType.text,
              controller: widget.textEditingController,
              validator: (value) => value!.isEmpty ? AppStrings.cantBeEmpty : null,
              onChanged: (value) {},
              cursorColor: AppColor.primaryColor,
              style: theme.bodyText2!.copyWith(fontWeight: FontWeight.w300),
              maxLines: widget.maxLines,
              decoration: InputDecoration(
                  hintText: widget.hint,
                  hintStyle: theme.bodyText2!.copyWith(
                    fontWeight: FontWeight.w300,
                    fontSize: 12.dp,
                    color: AppColor.grey,
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
