import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_month_picker/flutter_month_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/business_logic/cubit/expense_repeat/expense_repeat_cubit.dart';
import 'package:temp/business_logic/cubit/statistics_cubit/statistics_cubit.dart';
import 'package:temp/presentation/styles/colors.dart';
import 'package:temp/presentation/views/flow_chart_view.dart';
import 'package:temp/presentation/views/week_card_view.dart';
import 'package:temp/presentation/widgets/buttons/elevated_button.dart';
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
  void initState() {
    // TODO: implement initState

    getStatisticsCubit().getIncome();
    getStatisticsCubit().getExpenseByMonth(false);
    getStatisticsCubit().getTodaysExpenses(false);
    super.initState();
  }

  StatisticsCubit getStatisticsCubit() =>
      BlocProvider.of<StatisticsCubit>(context);

  void showDatePick() async {

    final datePicker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (datePicker == null) return;
    // getStatisticsCubit().choosenDay = datePicker;
    getStatisticsCubit().getExpensesByDay(datePicker,false);
  }
  void showDatePickMonth() async {

    final datePicker = await showMonthPicker(

      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (datePicker == null) return;
    getStatisticsCubit().chooseMonth(datePicker);
    getStatisticsCubit().getExpenseByMonth(false);
  }

  @override
  Widget build(BuildContext context) {
    ExpensesLists expensesLists = ExpensesLists();
    int currentIndex = 0;
    return BlocConsumer<StatisticsCubit, StatisticsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
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
                        CustomElevatedButton(
                          onPressed: () => index==0?showDatePick():showDatePickMonth(),
                          text: index ==0?'${getStatisticsCubit().choosenDay.day} \\ ${getStatisticsCubit().choosenDay.month} \\ ${getStatisticsCubit().choosenDay.year}':'${getStatisticsCubit().choosenDay.month} \\ ${getStatisticsCubit().choosenDay.year}',
                          textStyle: Theme.of(context).textTheme.subtitle1,
                          backgroundColor: AppColor.white,
                          width: 40.w,
                          borderRadius: 8.sp,
                        ),
                        const Spacer(),
                        FlowChartView(
                            index: index,
                            transactionType: TransactionType.Income,
                            priorityType: PriorityType.Fixed,
                            notPriority: PriorityType.NotFixed,
                            expensesModel: expenses),

                        /// TabBarView Widgets.
                        Expanded(
                          flex: 40,
                          child: CustomTabBarViewEdited(
                              priorityName: PriorityType.Fixed,
                              expenseList: getStatisticsCubit().byDayList,
                              monthWidget: WeekCardViewEdited(
                                chosenDay: getStatisticsCubit().choosenDay,
                                onPressSeeMore: (){},
                                weeksTotals: getStatisticsCubit().totals,
                                seeMoreOrDetailsOrHighest: SwitchWidgets.seeMore,
                              ),
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
      },
    );
  }
}
