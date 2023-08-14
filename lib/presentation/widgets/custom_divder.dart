import 'package:flutter/material.dart';

import '../styles/colors.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key, this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return  Divider(
        color: color ?? AppColor.dividerColor.withOpacity(.7),
        thickness: 2,
        indent: 14.3,
        endIndent: 14.3,
      );
    }
  }
