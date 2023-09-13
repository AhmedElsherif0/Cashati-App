import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/svg.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../styles/colors.dart';

class UnEditableInfoField extends StatefulWidget {
  const UnEditableInfoField(
      {Key? key,
        required this.hint,
        required this.iconName,
        this.containerWidth,
        this.trailing,
        this.maxLines = 1,
        this.header = '',
        this.backGroundColor})
      : super(key: key);
  final String hint;
  final String header;
  final String iconName;
  final double? containerWidth;
  final Widget? trailing;
  final int maxLines;
  final Color? backGroundColor;

  @override
  _UnEditableInfoFieldState createState() => _UnEditableInfoFieldState();
}

class _UnEditableInfoFieldState extends State<UnEditableInfoField> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Container(
      // height: 6.h,
      width: widget.containerWidth,
      decoration: BoxDecoration(
          color: widget.backGroundColor ?? AppColor.primaryColor.withOpacity(0.3),
          borderRadius: BorderRadius.circular(16.dp)),
      padding: EdgeInsets.symmetric(horizontal: 8.dp),
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Visibility(
            //     visible: widget.header.isEmpty ? false : true,
            //     child: Align(
            //         alignment: translator.activeLanguageCode == 'en'
            //             ? Alignment.centerLeft
            //             : Alignment.centerRight,
            //         child: Text(widget.header.tr(), style: theme.subtitle2))),
            Text(widget.hint,
              textAlign:
              translator.activeLanguageCode == 'en'
                          ? TextAlign.left
                           : TextAlign.right,
              maxLines: widget.maxLines,
              style: theme.bodyText2!.copyWith(fontWeight: FontWeight.w300),

            ),

          ],
        ),
        leading: widget.iconName.isEmpty ? null : SvgPicture.asset(widget.iconName),
        trailing: widget.trailing ?? const SizedBox.shrink(),
      ),
    );
  }
}
