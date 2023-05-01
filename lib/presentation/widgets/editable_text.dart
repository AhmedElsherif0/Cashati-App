import 'package:flutter/material.dart';
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
      this.keyboardType, this.maxLines = 1})
      : super(key: key);
  final TextEditingController textEditingController;
  final String hint;
  final String iconName;
  final TextInputType? keyboardType;
  final double? containerWidth;
  final Widget? trailing;
  final int maxLines;

  @override
  _EditableInfoFieldState createState() => _EditableInfoFieldState();
}

class _EditableInfoFieldState extends State<EditableInfoField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.containerWidth,
      decoration: BoxDecoration(
          color: AppColor.primaryColor.withOpacity(0.3),
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: ListTile(
          title: TextFormField(
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
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(fontWeight: FontWeight.w300),
            maxLines: widget.maxLines,
            decoration: InputDecoration(
                hintText: widget.hint,
                hintStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontWeight: FontWeight.w300,
                      fontSize: 15,
                      color: AppColor.primaryColor,
                    ),
                border: InputBorder.none),
          ),
          leading: SvgPicture.asset(widget.iconName),
          trailing: widget.trailing ?? const SizedBox(),
        ),
      ),
    );
  }
}
