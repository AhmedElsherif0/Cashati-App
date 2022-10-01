import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../styles/colors.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Icon(
              Icons.arrow_back_ios,
              size: 30,
              color: AppColor.pineGreen,
            )),
        Expanded(
          flex: 3,
          child: Center(
            child: Text(
              title,
              style: Theme.of(context).textTheme.headline5!.copyWith(
                  color: Color(0xff80BF88), fontWeight: FontWeight.w700),
            ),
          ),
        ),
        Expanded(
            flex: 1, child: SvgPicture.asset('assets/images/notification.svg'))
      ],
    );
  }
}
