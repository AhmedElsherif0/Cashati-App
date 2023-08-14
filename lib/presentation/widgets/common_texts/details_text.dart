import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:temp/constants/app_strings.dart';

class DetailsText extends StatelessWidget {
  const DetailsText({Key? key, required this.text,  required this.alignment})
      : super(key: key);

  final String text;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.dp),
      child: Align(
        alignment: alignment,
        child: Text(text, style: Theme.of(context).textTheme.headline3),
      ),
    );
  }
}
