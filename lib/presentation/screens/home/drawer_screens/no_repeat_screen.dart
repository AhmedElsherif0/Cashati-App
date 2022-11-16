import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/data/models/expenses/expenses_lists.dart';
import 'package:temp/presentation/widgets/custom_app_bar.dart';
import '../../../../constants/enum_classes.dart';
import '../../../../data/models/expenses/expenses_model.dart';
import '../../../views/tab_card_View.dart';
import '../../../widgets/details_text.dart';
import '../../../widgets/expenses_and_income_widgets/tab_view_item_decoration.dart';

class NoRepeatScreen extends StatelessWidget {
  const NoRepeatScreen({Key? key}) : super(key: key);

  List<Row> listOfItem(
          {required List<String> noRepeats, required void Function() onTap}) =>
      List.generate(
        noRepeats.length,
        (index) => Row(
          children: [
            SizedBox(
              width: 30.w,
              height: 6.h,
              child: InkWell(
                onTap: onTap,
                child: TabBarItem(text: noRepeats[index]),
              ),
            ),
            SizedBox(width: 8.w),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    List<ExpensesModel> expensesList = ExpensesLists().expensesData;
    List<String> noRepeats = ExpensesLists().noRepeats;
    String currentTime =
        DateFormat('dd/MM/yyyy').format(DateTime.now().toUtc());
    final currentTimeAfter = currentTime.replaceFirst('0', '');
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: CustomAppBar(
                title: 'No Repeat Income',
                onTapFirstIcon: () {},
                onTanNotification: () {},
                textStyle: Theme.of(context).textTheme.headline5,
              ),
            ),
            SizedBox(
              height: 10.h,
              width: double.infinity,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding:
                    EdgeInsets.symmetric(horizontal: 16.sp, vertical: 12.sp),
                children: listOfItem(noRepeats: noRepeats, onTap: () {}),
              ),
            ),
            Expanded(
              flex: 12,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.sp),
                child: Column(
                  children: [
                    const DetailsText(),
                    Expanded(
                      child: TabCardView(
                        priorityName: 'Important',
                        expensesName: expensesList[0].header,
                        listItem: expensesList,
                        isPriority: expensesList[0].isImportant,
                        onPressSeeMore: () {},
                        dateTime: currentTimeAfter,
                        price: '${expensesList[0].price}',
                        isVisible: true,
                        isRepeated: true,
                        seeMoreOrDetailsOrHighest: SwitchWidgets.seeMore,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
