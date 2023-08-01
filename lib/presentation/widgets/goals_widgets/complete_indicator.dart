import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/svg.dart';
import 'package:temp/constants/app_icons.dart';
import 'package:temp/data/models/goals/goal_model.dart';
import 'package:temp/presentation/styles/colors.dart';

class CompleteIndicatorBar extends StatelessWidget {
  const CompleteIndicatorBar({
    Key? key,
    required this.goalModel,
  }) : super(key: key);
  final GoalModel goalModel;

//  final int width ;
//  int cost = 1000;
  //int remaining = 300;

  int getPosition() {
    return (goalModel.goalRemainingAmount / goalModel.goalTotalAmount * 70).truncate();
  }

  @override
  Widget build(BuildContext context) {
    print((300 / 1000 * 70).truncate());
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
                  width: (70 - getPosition()).w,
                  decoration: BoxDecoration(
                      color: AppColor.darkGrey,
                      border: const Border(right: BorderSide.none),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.dp),
                          bottomLeft: Radius.circular(10.dp))),
                ),
                Visibility(
                  visible: goalModel.goalRemainingAmount != 0,
                  replacement: const SizedBox(),
                  child: Container(
                    height: 2.1.h,
                    width: getPosition().w,
                    decoration: BoxDecoration(
                        color: AppColor.white,
                        border: const Border(left: BorderSide.none),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10.dp),
                            bottomRight: Radius.circular(10.dp))),
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned(
            top: .01.h,
            bottom: .01.h,
            left: (70 - getPosition() - 5).w,
            //remaining==0?62.1.w:(position).w,
            // height: 5.h,
            child: SvgPicture.asset(
              goalModel.goalRemainingAmount == 0
                  ? AppIcons.completedGoal
                  : AppIcons.goalCompleteDollar,
              height: 5.5.h,
            )),
      ],
    );
  }
}
