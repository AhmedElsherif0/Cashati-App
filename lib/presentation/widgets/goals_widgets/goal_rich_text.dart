import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../../styles/colors.dart';

class GoalsRichText extends StatelessWidget {
  const GoalsRichText({super.key, required this.title, required this.subTitle});

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.3.h),
      child: RichText(
          text: TextSpan(
              text: '$title: ',
              style: Theme.of(context).textTheme.bodyText1,
              children: [
            TextSpan(
              text: subTitle,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: AppColor.middleGrey),
            ),
          ])),
    );
  }
}
