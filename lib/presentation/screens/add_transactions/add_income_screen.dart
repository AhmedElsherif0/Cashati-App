import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/presentation/styles/colors.dart';
import '../../../constants/enum_classes.dart';
import '../../views/tab_card_View.dart';
import '../../widgets/custom_app_bar.dart';

class AddIncomeScreen extends StatelessWidget {
  const AddIncomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(

        body: Center(
          child: Column(
            children: [
              CustomAppBar(
                  title: 'Week Income',
                  textStyle: textTheme.headline5?.copyWith(fontSize: 17.sp),
                  isEndIconVisible: false),
              Expanded(
                child: Column(
                  children: [
                    const Spacer(),
                    Text('23/ 04/ 2022 To 30/ 04/ 2022  ',
                        style: textTheme.subtitle1),
                    const Spacer(),
                    Expanded(
                      flex: 32,
                      child: TabCardView(
                        priorityName: 'Important',
                        expenseRepeatList: [],
                        onPressSeeMore: () {},
                        priceColor: AppColor.secondColor,
                        seeMoreOrDetailsOrHighest: SwitchWidgets.higherExpenses,
                        isVisible: true,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
