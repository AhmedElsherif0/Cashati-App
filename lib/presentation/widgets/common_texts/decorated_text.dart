import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class DecoratedText extends StatefulWidget {
  const DecoratedText(
      {super.key,
      required this.text,
      required this.onPress,
      required this.boxDecoration,
      });

  final String text;
  final void Function() onPress;
  final BoxDecoration boxDecoration;

  @override
  State<DecoratedText> createState() => _DecoratedTextState();
}

class _DecoratedTextState extends State<DecoratedText> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      height: 5.h,
      width: 30.w,
      child: AnimatedContainer(
        duration: const Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
        decoration: widget.boxDecoration,
        child: TextButton(
          onPressed: widget.onPress,
          child: Text(widget.text,
              style: textTheme.headline5?.copyWith(fontWeight: FontWeight.w300)),
        ),
      ),
    );
  }
}
