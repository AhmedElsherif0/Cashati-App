import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/svg.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:temp/constants/enum_classes.dart';

import '../styles/colors.dart';

class TabBarIconText extends StatelessWidget {
  const TabBarIconText(
      {Key? key,
      required this.svgIcon,
      required this.transactionType,
      required this.isClicked})
      : super(key: key);

  final String svgIcon;
  final TransactionType transactionType;
  final bool isClicked;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: [
        SvgPicture.asset(svgIcon,
            height: 40.dp,
            width: 40.dp,
            color: isClicked ? AppColor.primaryColor : AppColor.pinkishGrey),
        Text(transactionType.name.tr(),
            style: isClicked
                ? textTheme.headline6
                : textTheme.headline6?.copyWith(color: AppColor.pinkishGrey))
      ],
    );
  }
}
