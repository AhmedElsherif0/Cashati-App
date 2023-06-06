import 'package:flutter/material.dart';

class ElevatedTextButton extends StatelessWidget {
  const ElevatedTextButton({
    Key? key,
    required this.text,
    this.textStyle
  }) : super(key: key);

  final String text;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: textStyle ?? Theme.of(context).textTheme.bodyText1,
        maxLines: 1,
        overflow: TextOverflow.ellipsis);
  }
}
