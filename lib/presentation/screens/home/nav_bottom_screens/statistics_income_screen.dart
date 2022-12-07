import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/business_logic/cubit/expense_repeat/expense_repeat_cubit.dart';
import 'package:temp/presentation/styles/colors.dart';
import 'package:temp/presentation/views/chart_bars_card.dart';
import '../../../../data/models/transactions/expenses_lists.dart';
import '../../../views/tab_bar_view.dart';
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
    ExpensesLists expensesLists = ExpensesLists();
    int currentIndex = 0;
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.ltr,
        child: PageView.builder(
          controller: _controller,
          onPageChanged: (value) => setState(() => currentIndex = value),
          itemCount: 3,
          itemBuilder: (context, index) {
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Column(
                  children: [
                    DefaultDropDownButton(
                      selectedValue:
                          expensesLists.expensesData[index].chooseDate,
                      defaultText: expensesLists.expensesData[index].chooseDate,
                      items: List.generate(12, (index) {
                        index += 1;
                        return '${(expensesLists.expensesData[0].chooseInnerData)} $index';
                      }),
                    ),
                    const Spacer(),

                    /// Flow Chart Widgets.
                    Expanded(
                      flex: 36,
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
                            child: switchWidgets(index),
                          ),

                          /// importance Radio button.
                          if (index == 0)
                            Expanded(
                              child: Row(
                                children: [
                                  const Spacer(flex: 11),
                                  Expanded(
                                      flex: 11,
                                      child: Column(
                                        children: [
                                          const ImportantOrFixed(text: 'Fixed'),
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
                      flex: 40,
                      child:
                          BlocBuilder<ExpenseRepeatCubit, ExpenseRepeatState>(
                        builder: (context, state) {
                          return CustomTabBarView(
                            priorityName: 'Fixed',
                            currentIndex: currentIndex,
                            index: index,
                            pageController: _controller,
                            expenseDetailsList: context
                                .read<ExpenseRepeatCubit>()
                                .getExpenseTypeList(),
                          );
                        },
                      ),
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
