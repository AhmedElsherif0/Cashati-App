import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/data/models/statistics/expenses_lists.dart';

import '../../constants/enum_classes.dart';
import '../../data/models/statistics/expenses_model.dart';
import '../styles/colors.dart';
import '../widgets/expenses_and_income_widgets/circle_progress_bar_chart.dart';
import '../widgets/expenses_and_income_widgets/important_or_fixed.dart';
import 'chart_bars_card.dart';

class FlowChartView extends StatelessWidget {
  const FlowChartView({
    Key? key,
    required this.index,
    this.priorityType = PriorityType.Important,
    this.transactionType = TransactionType.Expense,
    required this.expensesModel,
    required this.notPriority,
    required this.maxExpenses,
    required this.totalExpenses,
  }) : super(key: key);

  final int index;
  final PriorityType priorityType;
  final PriorityType notPriority;
  final TransactionType transactionType;
  final ExpensesModel expensesModel;
  final double maxExpenses;
  final double totalExpenses;

  Widget switchWidgets(int currentIndex) {
    final expList = ExpensesLists();
    Widget widget = CircularProgressBarChart(
        header: transactionType.name,
        maxExpenses: maxExpenses,
        totalExpenses: totalExpenses,
        onPressToHome: () {});
    switch (currentIndex) {
      case 0:
        widget;
        break;
      case 1:
        widget = ChartBarsCard(expensesList: expList.expensesData2);
        break;
      case 2:
        widget = ChartBarsCard(expensesList: expList.expensesData);
        break;
    }
    return widget;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 22,
      child: Column(
        children: [
          /// Chart widgets
          Expanded(flex: 4, child: switchWidgets(index)),

          /// priority flag.
          if (index == 0)
            Expanded(
              child: Row(
                children: [
                  const Spacer(flex: 11),
                  Expanded(
                    flex: 6,
                    child: Column(
                      children: [
                        PriorityWidget(text: priorityType.name),
                        SizedBox(height: 0.3.h),
                        PriorityWidget(
                            text: notPriority.name, circleColor: AppColor.grey),
                      ],
                    ),
                  ),
                  const Spacer()
                ],
              ),
            )
        ],
      ),
    );
  }
}
