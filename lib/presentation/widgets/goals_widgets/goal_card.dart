import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/data/models/goals/goal_model.dart';
import 'package:temp/presentation/styles/colors.dart';
import 'package:temp/presentation/widgets/goals_widgets/circle_button.dart';
import 'package:temp/presentation/widgets/goals_widgets/complete_indicator.dart';

class GoalCard extends StatelessWidget {
  const GoalCard({Key? key,required this.goal, required this.editFunction, required this.deleteFunction}) : super(key: key);
  final GoalModel goal;
  final Function() editFunction;
  final Function() deleteFunction;
  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding:  EdgeInsets.symmetric(vertical: 2.h),
      child: Stack(
        children: [
          Container(
            //  height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
                color: AppColor.primaryColor,
                borderRadius: BorderRadius.circular(20)

            ),
            child: Padding(
              padding:  EdgeInsets.only(left: 4.0.w,right: 3.0.w,top: 2.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  goalName(context,goal.goalName),
                  goalRichText(context,title: 'Goal Cost',text: '${goal.goalTotalAmount} LE'),

                  goalRichText(context,title: 'Remaining Amount',text: '${goal.goalRemainingAmount} LE'),
                  goalRichText(context,title: 'Your Saving',text: '${goal.goalSaveAmount} LE , ${goal.goalSaveAmountRepeat}'),

                  goalRichText(context,title: 'Goal Cost',text: '${goal.goalTotalAmount} LE'),

                  Padding(
                    padding:  EdgeInsets.symmetric(vertical: 1.h),
                    child: Center(child: CompleteIndicatorBar(goalModel: goal,)),
                  )

                ],
              ),
            ),
          ),
          Positioned(
              right: 2.h,
              top: 2.h,

              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleIconButton(iconData: Icons.edit_outlined,onTap: (){editFunction();},),
                  CircleIconButton(iconData: Icons.close,onTap: (){deleteFunction();},),
                ],
              ))
        ],
      ),
    );
  }

  Widget goalRichText(BuildContext context,{required String title,required String text}) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: .5.h),
      child: RichText(text: TextSpan(
              text: title,
              style: Theme.of(context).textTheme.bodyText1,
              children: [
                TextSpan(text: ' : ',
                  style:  Theme.of(context).textTheme.bodyText1,
                ),
                TextSpan(text: text ,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(color: AppColor.middleGrey),
                ),
              ]
            )),
    );
  }
  Widget goalName(BuildContext context,String goalName){
    return Flexible(
      child: Padding(
        padding:  EdgeInsets.only(bottom: 1.0.h),
        child: Text(goalName,

          style: Theme.of(context).textTheme.headline5!.copyWith(color: AppColor.white,
            fontSize: 13.sp
          ),
        ),
      ),
    );
  }

}
