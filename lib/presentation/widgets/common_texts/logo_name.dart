import 'package:flutter/material.dart';

import '../../styles/colors.dart';

class LogoName extends StatelessWidget {
  const LogoName({Key? key}) : super(key: key);

  /// logo name.
  @override
  Widget build(BuildContext context) {
    final themeStyle =
        Theme.of(context).textTheme.headline4?.copyWith(color: AppColor.black);
    return RichText(
      text: TextSpan(
        text: 'Ca',
        style: themeStyle,
        children: <InlineSpan>[
          const TextSpan(
            text: '\$',
            style: TextStyle(color: AppColor.pineGreen),
          ),
          TextSpan(
            text: 'hati',
            style: themeStyle,
          )
        ],
      ),
    );
  }
}
