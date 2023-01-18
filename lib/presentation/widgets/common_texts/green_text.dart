import 'package:flutter/material.dart';

class GreenText extends StatelessWidget {
  const GreenText({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .bodyMedium!
          .copyWith(fontWeight: FontWeight.w500),
    );
  }
}
