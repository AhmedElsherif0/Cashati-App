import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/data/models/expenses/expenses_lists.dart';
import 'package:temp/presentation/views/chart_bars_card.dart';
import 'package:temp/presentation/views/importance_radio_buttons.dart';
import '../../views/tab_bar_view.dart';
import '../../widgets/expenses_and_income_widgets/circle_progress_bar_chart.dart';
import '../../widgets/expenses_and_income_widgets/drop_down_button.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({Key? key}) : super(key: key);

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  final PageController _controller = PageController(initialPage: 0);
  Importance importanceGroup = Importance.importantExpense;

  Widget switchWidgets(int currentIndex) {
    Widget widget = CircularProgressBarChart(
      header: 'expense',
      maxExpenses: 10000,
      totalExpenses: 5000,
      onPressToHome: () {},
    );
    switch (currentIndex) {
      case 0:
        widget = CircularProgressBarChart(
          header: 'expense',
          maxExpenses: 10000,
          totalExpenses: 5000,
          onPressToHome: () {},
        );
        break;
      case 1:
        widget = CircularProgressBarChart(
          header: 'expense',
          maxExpenses: 10000,
          totalExpenses: 5000,
          onPressToHome: () {},
        );
        break;
      case 2:
        widget = const ChartBarsCard();
        break;
    }
    return widget;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
          itemCount: 3,
          itemBuilder: (context, index) {
            int increase = index;
            increase++;
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Column(
                  children: [
                    Text('Statistics expenses',
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
                      ],
                    ),
                    const Spacer(),

                    /// Flow Chart Widgets.
                    Expanded(
                      flex: 16,
                      child: Column(
                        children: [
                          Expanded(flex: 4, child: switchWidgets(index)),

                          /// importance Radio button.
                          if (index == 0)
                            Expanded(
                              child: Row(
                                children: [
                                  const Spacer(flex: 13),
                                  if (index == 0)
                                    Expanded(
                                      flex: 9,
                                      child: ImportanceRadioButton(
                                        firstRadio: 'Important Expense',
                                        secondRadio: 'Not Important Expense',
                                        groupValue: importanceGroup,
                                        onChange: (Importance? value) =>
                                            setState(
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
                      flex: 20,
                      child: CustomTabBarView(
                          priorityName: 'Important',
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
