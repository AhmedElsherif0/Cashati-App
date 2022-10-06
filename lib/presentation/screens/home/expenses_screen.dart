import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/data/models/expenses/expenses_lists.dart';
import 'package:temp/presentation/views/importance_radio_buttons.dart';
import '../../views/tab_bar_view.dart';
import '../../widgets/circle_progress_bar_chart.dart';
import '../../widgets/drop_down_button.dart';
import '../../widgets/radio_button_list_tile.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({Key? key}) : super(key: key);

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  final PageController _controller = PageController(initialPage: 0);
  Importance importanceGroup = Importance.importantExpense;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    ExpensesLists expensesLists = ExpensesLists();
    int currentIndex = 0;

    return Scaffold(
      appBar: AppBar(),
      body: Directionality(
        textDirection: TextDirection.ltr,
        child: PageView.builder(
          controller: _controller,
          onPageChanged: (value) => setState(() => currentIndex = value),
          itemCount: expensesLists.expensesData.length,
          itemBuilder: (context, index) {
            int increase = index ;
            increase ++;
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Column(
                  children: [
                    Text('${expensesLists.expensesData[index].header} expenses',
                        style: textTheme.headline2),
                    DefaultDropDownButton(
                      selectedValue:
                          expensesLists.expensesData[index].chooseDate,
                      defaultText: expensesLists.expensesData[index].chooseDate,
                      items: [
                        '${(expensesLists.expensesData[index].chooseInnerData)} $increase',
                        '${(expensesLists.expensesData[index].chooseInnerData)}${2}',
                        '${(expensesLists.expensesData[index].chooseInnerData)}${3}',
                        '${(expensesLists.expensesData[index].chooseInnerData)}${4}',
                        '${(expensesLists.expensesData[index].chooseInnerData)}${5}',
                        '${(expensesLists.expensesData[index].chooseInnerData)}${5}',
                        '${(expensesLists.expensesData[index].chooseInnerData)}${5}',
                        '${(expensesLists.expensesData[index].chooseInnerData)}${5}',
                        '${(expensesLists.expensesData[index].chooseInnerData)}${5}',
                      ],
                    ),
                    const Spacer(),

                    /// Flow Chart Widgets.
                    Expanded(
                      flex: 12,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 4,
                            child: CircularProgressBarChart(
                              maxExpenses: 10000,
                              totalExpenses: ValueNotifier(0.0),
                            ),
                          ),

                          /// importance Radio button.
                          Expanded(
                            child: Row(
                              children: [
                                const Spacer(flex: 10),
                                if (index == 0)
                                  Expanded(
                                    flex: 9,
                                    child: ImportanceRadioButton(
                                      groupValue: importanceGroup,
                                      onChange: (Importance? value) => setState(
                                          () => importanceGroup = value!),
                                    ),
                                  ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),

                    /// TabBarView Widgets.
                    Expanded(
                      flex: 16,
                      child: CustomTabBarView(
                          expensesList: expensesLists.expensesData,
                          currentIndex: currentIndex,
                          index: index,
                          pageController: _controller),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
