import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class DetailsText extends StatelessWidget {
  const DetailsText({Key? key, this.text = 'Details'}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.dp),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(text, style: Theme.of(context).textTheme.headline3),
      ),
    );
  }
}
