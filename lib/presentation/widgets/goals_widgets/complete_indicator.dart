import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/constants/app_icons.dart';
import 'package:temp/data/models/goals/goal_model.dart';
import 'package:temp/presentation/styles/colors.dart';

class CompleteIndicatorBar extends StatelessWidget {
   CompleteIndicatorBar({Key? key, required this.goalModel}) : super(key: key);
   final GoalModel goalModel;
  final width=70.w;
  int cost=1000;
  int remaining=300;
  int position=(300/1000*70).truncate();
  int getPosition(){
    return (goalModel.goalRemainingAmount/goalModel.goalTotalAmount*70).truncate();
  }
  @override
  Widget build(BuildContext context) {
    print(position);
    return Stack(
      children: [
        Container(
          color: Colors.transparent,
          height: 3.4.h,
          width: 70.w,
          child: Center(
            child: Row(
              children: [
                Container(
                  height: 2.1.h,
                  width:(70-getPosition()).w,

                  decoration: BoxDecoration(
                      color: AppColor.darkGrey,

                      border: Border(right: BorderSide.none),

                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10.sp),bottomLeft: Radius.circular(10.sp))
                  ),
                ),
                Visibility(
                  visible: goalModel.goalRemainingAmount!=0,
                  child: Container(
                    height: 2.1.h,
                    width:getPosition().w,
                    decoration: BoxDecoration(
                        color: AppColor.white,
                        border: Border(left: BorderSide.none),
                        borderRadius: BorderRadius.only(topRight: Radius.circular(10.sp),bottomRight: Radius.circular(10.sp))
                    ),
                  ),
                  replacement: SizedBox(),
                )
              ],
            ),
          ),
        ),
        Positioned(
          top: .01.h,
          bottom: .01.h,
         left:(70-getPosition()-5).w,
         //remaining==0?62.1.w:(position).w,
         // height: 5.h,
            child: SvgPicture.asset(goalModel.goalRemainingAmount==0?AppIcons.completedGoal:AppIcons.goalCompleteDollar,height: 5.5.h,)),
      ],
    );
  }
}
