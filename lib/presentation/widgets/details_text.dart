import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DetailsText extends StatelessWidget {
  const DetailsText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.sp),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Details',
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
    );
  }
}
