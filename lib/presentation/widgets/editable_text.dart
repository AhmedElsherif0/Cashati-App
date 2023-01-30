import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../styles/colors.dart';

class EditableInfoField extends StatefulWidget {
  EditableInfoField(
      {Key? key,
      required this.textEditingController,
      required this.hint,
      required this.IconName,
       this.containerWidth,
       this.trailing,
      this.keyboardType})
      : super(key: key);
  final TextEditingController textEditingController;
  final String hint;
  final String IconName;
  final TextInputType? keyboardType;
  final double? containerWidth;
  final Widget? trailing;

  @override
  _EditableInfoFieldState createState() => _EditableInfoFieldState();
}

class _EditableInfoFieldState extends State<EditableInfoField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.containerWidth??270,
      decoration: BoxDecoration(
          color: Colors.blueGrey.withOpacity(.2),
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: ListTile(
          title: TextFormField(
            keyboardType: widget.keyboardType ?? TextInputType.text,
            controller: widget.textEditingController,
            validator: (value) {

              if (value!.isEmpty) {
                return 'This field can\'t be empty';
              } else {
                // widget.subCategoryName=value;
              }
            },

            // },
            onChanged: (value) {

            },
            cursorColor: AppColor.primaryColor,
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  fontWeight: FontWeight.w300,
                ),
            decoration: InputDecoration(
                hintText: widget.hint,
                hintStyle: Theme.of(context).textTheme.bodyText2!
                    .copyWith(fontWeight: FontWeight.w300, fontSize: 13,color: AppColor.grey),
                border: InputBorder.none),
          ),
          leading: SvgPicture.asset(widget.IconName),
          trailing: widget.trailing??SizedBox(),
        ),
      ),
    );
  }
}
