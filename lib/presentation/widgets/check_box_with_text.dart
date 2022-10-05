import 'package:flutter/material.dart';

class CheckBoxWithText extends StatelessWidget {
  const CheckBoxWithText(
      {Key? key,
      required this.value,
      required this.onChange,
      this.activeColor = Colors.deepOrange,
      this.text = 'Hyundai',
        this.textStyle = const TextStyle(fontSize: 20)})
      : super(key: key);

  final bool value;
  final void Function(bool?) onChange;
  final Color activeColor;
  final String text;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return  Center(
        child: Row(children: [
          Transform.scale(
            scale: 1.5,
            child: Checkbox(
              onChanged: onChange,
              value: value,
              activeColor: activeColor,
            ),
          ),
          Text(
            text,
            style: textStyle,
          )
        ]),
    );
  }
}
