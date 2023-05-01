import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/constants/app_strings.dart';
import 'package:temp/data/local/hive/app_boxes.dart';
import 'package:temp/data/local/hive/app_boxes.dart';
import 'package:temp/data/local/hive/hive_database.dart';
import 'package:temp/data/models/statistics/general_stats_model.dart';
import 'package:temp/presentation/widgets/buttons/dotted_button.dart';
import 'package:temp/presentation/widgets/expenses_and_income_widgets/underline_text_button.dart';

import '../../data/local/hive/app_boxes.dart';
import '../styles/colors.dart';

class CardHome extends StatelessWidget {
   const CardHome(
      {Key? key,
      required this.title,
      required this.onPressedShow,
      required this.onPressedAdd,
      required this.generalStatsModel,
      required this.isExpense,
      required this.onPressedTop})
      : super(key: key);

  final String title;
  final GeneralStatsModel generalStatsModel;
  final bool isExpense;
  final Function() onPressedShow;
  final Function() onPressedAdd;
  final Function() onPressedTop;
  @override
  Widget build(BuildContext context) {
    Hive.isBoxOpen(AppBoxes.generalStatisticsBox);
    final textTheme = Theme.of(context).textTheme;
    return ValueListenableBuilder<Box<GeneralStatsModel>>(
     // valueListenable: HiveHelper().getBoxName<GeneralStatsModel>(boxName: AppBoxes.generalStatisticsModel).listenable(),
      valueListenable:  HiveHelper().getBoxName<GeneralStatsModel>(boxName: AppBoxes.generalStatisticsBox).listenable(),
      builder: (context,box,_) {
        GeneralStatsModel ourGeneral =box.get(AppStrings.theOnlyGeneralStatsModelID)??generalStatsModel;
        return Stack(
          children: [
            /// Show Expense or Income.
            Padding(
              padding: EdgeInsets.only(top: 45.sp),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColor.primaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.sp),
                    topRight: Radius.circular(40.sp),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(right: 14.sp, bottom: 8.sp),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: UnderLineTextButton(
                      text: 'Show $title',
                      onPressed: onPressedShow,
                      textStyle: TextStyle(fontSize: 14.sp, color: AppColor.white),
                      decorationColor: AppColor.white,
                    ),
                  ),
                ),
              ),
            ),

            ///  Stacked Balance Widget.
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Visibility(
                    visible: isExpense,
                      child: Text('Top Expense Of the month',
                      style: Theme.of(context).textTheme.headline6,
                      ),
                  replacement:  Text('Top Income Of the month',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  ),
                  SizedBox(
                    height: 14.h,
                    width: 40.w,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.sp),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 50,
                            offset: const Offset(0, 4), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(top: 12.sp, right: 5.w, left: 5.w),
                        child: Column(
                          children: [
                            SvgPicture.asset('assets/icons/download.svg',
                                height: 20.sp, width: 20.sp),
                            SizedBox(height: 2.h),
                            Text('${isExpense?ourGeneral.topExpense:ourGeneral.topIncome} : ${isExpense?ourGeneral.topExpenseAmount:ourGeneral.topIncomeAmount}', style: textTheme.headline6),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// Dotted Widget
            Padding(
              padding: EdgeInsets.only(top: 22.h),
              child: Column(
                children: [
                  DottedButton(text: 'Balance', title: '${ourGeneral.balance}', onPressed: onPressedTop),
                  SizedBox(height: 2.h),
                  DottedButton(text: 'Add', title: title, onPressed: onPressedAdd),

                ],
              ),
            ),
          ],
        );
      }
    );
  }
}
