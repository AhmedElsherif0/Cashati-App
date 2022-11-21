import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/constants/enum_classes.dart';
import 'package:temp/data/models/expenses/expenses_lists.dart';
import 'package:temp/presentation/widgets/custom_app_bar.dart';
import '../../views/tab_card_View.dart';

class AddExpensesScreen extends StatelessWidget {
  const AddExpensesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final expensesList = ExpensesLists().expensesData;
    String currentTime =
        DateFormat('dd/MM/yyyy').format(DateTime.now().toUtc());
    final currentTimeAfter = currentTime.replaceFirst('0', '');
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            CustomAppBar(
                title: 'Week Expenses',
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
                      seeMoreOrDetailsOrHighest: SwitchWidgets.higherExpenses,
                      isVisible: true,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
