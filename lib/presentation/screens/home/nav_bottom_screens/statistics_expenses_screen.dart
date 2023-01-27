import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/business_logic/cubit/expense_repeat/expense_repeat_cubit.dart';
import 'package:temp/presentation/views/flow_chart_view.dart';

import '../../../../constants/enum_classes.dart';
import '../../../../data/models/statistics/expenses_lists.dart';
import '../../../views/tab_bar_view.dart';
import '../../../widgets/expenses_and_income_widgets/drop_down_button.dart';

class ExpensesStatisticsScreen extends StatefulWidget {
  const ExpensesStatisticsScreen({Key? key}) : super(key: key);

  @override
  State<ExpensesStatisticsScreen> createState() =>
      _ExpensesStatisticsScreenState();
}

class _ExpensesStatisticsScreenState extends State<ExpensesStatisticsScreen> {
  final PageController _controller = PageController(initialPage: 0);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  ExpenseRepeatCubit getStatisticsCubit() =>
      BlocProvider.of<ExpenseRepeatCubit>(context);

  @override
  Widget build(BuildContext context) {
    ExpensesLists expensesLists = ExpensesLists();
    int currentIndex = 0;
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.ltr,
        child: PageView.builder(
          controller: _controller,
          onPageChanged: (index) => setState(() => currentIndex = index),
          itemCount: 3,
          itemBuilder: (context, index) {
            final list = expensesLists.expensesData[index];
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Column(
                  children: [
                    DefaultDropDownButton(
                      selectedValue: list.chooseDate,
                      defaultText: list.chooseDate,
                      items: List.generate(12,
                          (index) => '${(list.chooseInnerData)} ${++index}'),
                    ),
                    const Spacer(),

                    FlowChartView(
                        index: index,
                        priorityType: PriorityType.Important,
                        notPriority: PriorityType.NotImportant,
                        expensesModel: list),

                    /// TabBarView Widgets.
                    Expanded(
                      flex: 40,
                      child:
                          BlocBuilder<ExpenseRepeatCubit, ExpenseRepeatState>(
                        builder: (context, state) {
                          // Todo:: taken a different list verses the ExpenseList.
                          return CustomTabBarView(
                              priorityName: PriorityType.Important,
                              expenseDetailsList:
                                  getStatisticsCubit().getExpenseTypeList(),
                              currentIndex: currentIndex,
                              index: index,
                              pageController: _controller);
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
