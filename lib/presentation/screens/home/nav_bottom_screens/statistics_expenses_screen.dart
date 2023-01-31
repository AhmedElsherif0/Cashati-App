import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/business_logic/cubit/expense_repeat/expense_repeat_cubit.dart';
import 'package:temp/presentation/views/flow_chart_view.dart';
import 'package:temp/presentation/widgets/buttons/elevated_button.dart';
import '../../../../constants/enum_classes.dart';
import '../../../../data/models/statistics/expenses_lists.dart';
import '../../../styles/colors.dart';
import '../../../views/tab_bar_view.dart';

class ExpensesStatisticsScreen extends StatefulWidget {
  const ExpensesStatisticsScreen({Key? key}) : super(key: key);

  @override
  State<ExpensesStatisticsScreen> createState() =>
      _ExpensesStatisticsScreenState();
}

class _ExpensesStatisticsScreenState extends State<ExpensesStatisticsScreen> {
  final PageController _controller = PageController(initialPage: 0);
  DateTime _selectedDate = DateTime.now();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  ExpenseRepeatCubit getStatisticsCubit() =>
      BlocProvider.of<ExpenseRepeatCubit>(context);

  void showDatePick() async {
    final datePicker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (datePicker == null) return;
    _selectedDate =datePicker;
    print(' selectedDate : $_selectedDate');
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
          onPageChanged: (index) => setState(() => currentIndex = index),
          itemCount: 3,
          itemBuilder: (context, index) {
            final list = expensesLists.expensesData[index];
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Column(
                  children: [
                    CustomElevatedButton(
                      onPressed: () => showDatePick(),
                      text: 'Choose Day',
                      textStyle: Theme.of(context).textTheme.subtitle1,
                      backgroundColor: AppColor.white,
                      width: 40.w,
                      borderRadius: 8.sp,
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
