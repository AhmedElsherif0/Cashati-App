import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:temp/constants/app_icons.dart';
import 'package:temp/constants/app_presentation_strings.dart';
import 'package:temp/presentation/styles/colors.dart';

class GoalNote extends StatelessWidget {
  const GoalNote({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.symmetric(horizontal: 1.w),
       height: 8.h,
      // width: 50.w,
      decoration: BoxDecoration(
        color: AppColor.primaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Image.asset(AppIcons.goalNote,height: 10.h,width: 10.w,),
          SizedBox(width: 2.w,),
          Flexible(
            child: Text(AppPresentationStrings.takeCareNeedsEng,
            style: Theme.of(context).textTheme.bodyText1,
            ),
          )
        ],
      ),
    );
  }
}
