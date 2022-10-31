import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/data/models/expenses/expenses_lists.dart';
import 'package:temp/presentation/styles/colors.dart';
import 'package:temp/presentation/views/chart_bars_card.dart';
import 'package:temp/presentation/widgets/expenses_and_income_widgets/important_or_fixed.dart';
import '../../../views/tab_bar_view.dart';
import '../../../widgets/expenses_and_income_widgets/circle_progress_bar_chart.dart';
import '../../../widgets/expenses_and_income_widgets/data_inside_pie_chart.dart';
import '../../../widgets/expenses_and_income_widgets/drop_down_button.dart';

class ExpensesStatisticsScreen extends StatefulWidget {
  const ExpensesStatisticsScreen({Key? key}) : super(key: key);

  @override
  State<ExpensesStatisticsScreen> createState() =>
      _ExpensesStatisticsScreenState();
}

class _ExpensesStatisticsScreenState extends State<ExpensesStatisticsScreen> {
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
        widget = const ChartBarsCard();
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
            increase = 1;
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Column(
                  children: [
                    DefaultDropDownButton(
                      selectedValue:
                          expensesLists.expensesData[index].chooseDate,
                      defaultText: expensesLists.expensesData[index].chooseDate,
                      items: [
                        '${(expensesLists.expensesData[index].chooseInnerData)} $increase',
                      ],
                    ),
                    const Spacer(),

                    /// Flow Chart Widgets.
                    Expanded(
                      flex: 16,
                      child: Column(
                        children: [

                          /// Chart widgets.
                          if (index == 1)
                            Expanded(
                              child: DataInsidePieChart(
                                  totalExpenses: 10000,
                                  valueNotifier: ValueNotifier<double>(5000),
                                  onPressToHome: () {},
                                  header: 'Income'),
                            ),
                          /// Chart widgets
                          Expanded(flex: 4, child: switchWidgets(index)),

                          /// importance Radio button.
                          if (index == 0)
                            Expanded(
                              child: Row(
                                children: [
                                  const Spacer(flex: 11),
                                  if (index == 0)
                                    Expanded(
                                      flex: 11,
                                      child: Column(
                                        children: [
                                          const ImportantOrFixed(
                                            text: 'Important Expense',
                                            circleColor: AppColor.secondColor,
                                          ),
                                          SizedBox(height: 0.3.h),
                                          const ImportantOrFixed(
                                            text: 'Not Important Expense',
                                            circleColor: AppColor.grey,
                                          ),
                                        ],
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
