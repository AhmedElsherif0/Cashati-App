import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../styles/colors.dart';

class ConfirmPayingTitleCard extends StatelessWidget {
  const ConfirmPayingTitleCard({
    Key? key,
    required this.cardTitle,
  }) : super(key: key);

  final String cardTitle;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
            color: AppColor.primaryColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.dp),
                topRight: Radius.circular(24.dp))),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            '$cardTitle',
            style: textTheme.headline5?.copyWith(color: AppColor.white),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
