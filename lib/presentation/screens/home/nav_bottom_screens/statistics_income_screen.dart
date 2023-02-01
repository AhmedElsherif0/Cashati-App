import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/business_logic/cubit/expense_repeat/expense_repeat_cubit.dart';
import 'package:temp/presentation/views/flow_chart_view.dart';
import '../../../../constants/enum_classes.dart';
import '../../../../data/models/statistics/expenses_lists.dart';
import '../../../views/tab_bar_view.dart';
import '../../../widgets/expenses_and_income_widgets/drop_down_button.dart';

class IncomeStatisticsScreen extends StatefulWidget {
  const IncomeStatisticsScreen({Key? key}) : super(key: key);

  @override
  State<IncomeStatisticsScreen> createState() => _IncomeStatisticsScreenState();
}

class _IncomeStatisticsScreenState extends State<IncomeStatisticsScreen> {
  final PageController _controller = PageController(initialPage: 0);

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
            final expenses = expensesLists.expensesData[index];
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Column(
                  children: [
                    DefaultDropDownButton(
                      selectedValue: expenses.chooseDate,
                      defaultText: expenses.chooseDate,
                      items: List.generate(12,
                          (index) => '${(expenses.chooseInnerData)} ${++index}'),
                    ),
                    const Spacer(),

                    FlowChartView(
                      index: index,
                      expensesModel:  expenses,
                      transactionType: TransactionType.Income,
                      priorityType: PriorityType.Fixed,
                      notPriority: PriorityType.NotFixed,
                    ),

                    /// TabBarView Widgets.
                    Expanded(
                      flex: 40,
                      child:
                          BlocBuilder<ExpenseRepeatCubit, ExpenseRepeatState>(
                        builder: (context, state) {
                          return CustomTabBarView(
                            priorityName: PriorityType.Fixed,
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
