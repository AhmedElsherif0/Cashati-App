import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/data/models/expenses/expenses_lists.dart';
import 'package:temp/presentation/styles/colors.dart';
import 'package:temp/presentation/views/chart_bars_card.dart';
import '../../../views/tab_bar_view.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/expenses_and_income_widgets/circle_progress_bar_chart.dart';
import '../../../widgets/expenses_and_income_widgets/data_inside_pie_chart.dart';
import '../../../widgets/expenses_and_income_widgets/drop_down_button.dart';
import '../../../widgets/expenses_and_income_widgets/important_or_fixed.dart';

class IncomeStatisticsScreen extends StatefulWidget {
  const IncomeStatisticsScreen({Key? key}) : super(key: key);

  @override
  State<IncomeStatisticsScreen> createState() => _IncomeStatisticsScreenState();
}

class _IncomeStatisticsScreenState extends State<IncomeStatisticsScreen> {
  final PageController _controller = PageController(initialPage: 0);
  Importance importanceGroup = Importance.importantExpense;

  Widget switchWidgets(int currentIndex) {
    Widget widget = CircularProgressBarChart(
        header: 'Income',
        maxExpenses: 10000,
        totalExpenses: 0.0,
        onPressToHome: () {});
    switch (currentIndex) {
      case 0:
        widget = CircularProgressBarChart(
            header: 'Income',
            maxExpenses: 10000,
            totalExpenses: 5000,
            onPressToHome: () {});
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
            increase++;
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Column(
                  children: [
                   /* CustomAppBar(
                      title: 'Statistics Income',
                      onTanNotification: () {},
                      onTapFirstIcon: () {},
                      firstIcon: Icons.menu,
                    ),*/
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

                          Expanded(
                            flex: 4,
                            child: Center(child: switchWidgets(index)),
                          ),

                          /// importance Radio button.
                          if (index == 0)
                            Expanded(
                              child: Row(
                                children: [
                                  const Spacer(flex: 13),
                                  if (index == 0)
                                    Expanded(
                                        flex: 9,
                                        child: Column(
                                          children: [
                                            const ImportantOrFixed(
                                                text: 'Fixed'),
                                            SizedBox(height: 0.3.h),
                                            const ImportantOrFixed(
                                                text: 'Not Fixed',
                                                circleColor: AppColor.grey),
                                          ],
                                        )),
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
                          priorityName: 'Fixed',
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
