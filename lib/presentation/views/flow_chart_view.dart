import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../constants/enum_classes.dart';
import '../router/app_router_names.dart';
import '../styles/colors.dart';
import '../widgets/expenses_and_income_widgets/circle_progress_bar_chart.dart';
import '../widgets/expenses_and_income_widgets/important_or_fixed.dart';
import 'chart_bars_card.dart';

class FlowChartView extends StatelessWidget {
  const FlowChartView({
    Key? key,
    required this.index,
    this.priorityType = PriorityType.important,
    this.transactionType = TransactionType.expense,
    required this.notPriority,
    this.maxExpenses = 0,
    this.totalExpenses = 0,
    required this.transactionsValues,
  }) : super(key: key);

  final int index;
  final PriorityType priorityType;
  final PriorityType notPriority;
  final TransactionType transactionType;
  final num maxExpenses;
  final double totalExpenses;
  final List<Map<String, dynamic>> transactionsValues;

  Widget switchWidgets(context, int currentIndex) {
    Widget widget = CircularProgressBarChart(
        header: transactionType.name.tr(),
        maxExpenses: maxExpenses.toDouble(),
        totalExpenses: totalExpenses,
        onPressToHome: () =>
            Navigator.of(context).pushNamed(AppRouterNames.rAddExpenseOrIncomeScreen));
    switch (currentIndex) {
      case 0:
        widget;
        break;
      case 1:
        widget = ChartBarsCard(transactionsValues: transactionsValues);
        break;
      case 2:
        widget = ChartBarsCard(transactionsValues: transactionsValues);
        break;
    }
    return widget;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 24,
      child: Column(
        children: [
          /// Chart widgets
          Expanded(flex: 4, child: switchWidgets(context, index)),

          /// priority flag.
          if (index == 0)
            Expanded(
              child: Row(
                textDirection: translator.activeLanguageCode == 'en'
                    ? TextDirection.ltr
                    : TextDirection.rtl,
                children: [
                  const Spacer(flex: 11),
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        PriorityWidget(text: priorityType.name.tr()),
                        SizedBox(height: 0.3.h),
                        PriorityWidget(
                            text: notPriority.name.tr(), color: AppColor.pinkishGrey),
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
