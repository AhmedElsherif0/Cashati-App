import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_month_picker/flutter_month_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/business_logic/cubit/statistics_cubit/statistics_cubit.dart';
import 'package:temp/data/repository/helper_class.dart';
import 'package:temp/presentation/views/flow_chart_view.dart';
import 'package:temp/presentation/views/week_card_view.dart';
import 'package:temp/presentation/widgets/buttons/elevated_button.dart';

import '../../../../constants/enum_classes.dart';
import '../../../styles/colors.dart';
import '../../../views/tab_bar_view.dart';
import '../statistics_details_screen.dart';

class ExpensesStatisticsScreen extends StatefulWidget {
  const ExpensesStatisticsScreen({Key? key}) : super(key: key);

  @override
  State<ExpensesStatisticsScreen> createState() => _ExpensesStatisticsScreenState();
}

class _ExpensesStatisticsScreenState extends State<ExpensesStatisticsScreen>
    with HelperClass {
  final PageController _controller = PageController(initialPage: 0);
  DateTime? datePicker = DateTime.now();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    getStatisticsCubit().getExpenses();
    getStatisticsCubit().getTransactionsByMonth(true);
    getStatisticsCubit().getTodayExpenses(true);
    super.initState();
  }

  StatisticsCubit getStatisticsCubit() => BlocProvider.of<StatisticsCubit>(context);

  void showDatePick() async {
    datePicker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (datePicker == null) return;
    // getStatisticsCubit().choosenDay = datePicker;
    getStatisticsCubit().getExpensesByDay(datePicker!, true);
  }

  void showDatePickMonth() async {
    final datePicker = await showMonthPicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (datePicker == null) return;
    getStatisticsCubit().changeDatePicker(datePicker);
    getStatisticsCubit().getTransactionsByMonth(true);
  }

  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;
    return Scaffold(
      body: BlocConsumer<StatisticsCubit, StatisticsState>(
        listener: (context, state) {
          if (state is StatisticsInitial) {}
        },
        builder: (context, state) {
          return Directionality(
            textDirection: TextDirection.ltr,
            child: PageView.builder(
              controller: _controller,
              onPageChanged: (index) => setState(() => currentIndex = index),
              itemCount: 3,
              itemBuilder: (context, index) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Column(
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(minWidth: 20.h, maxWidth: 35.h),
                          child: CustomElevatedButton(
                            onPressed: () =>
                                index == 0 ? showDatePick() : showDatePickMonth(),
                            text: index == 0
                                ? formatDayDate(getStatisticsCubit().chosenDay)
                                : formatWeekDate(getStatisticsCubit().chosenDay),
                            textStyle: Theme.of(context).textTheme.subtitle1,
                            backgroundColor: AppColor.white,
                            width: 40.w,
                            borderRadius: 8.sp,
                          ),
                        ),
                        const Spacer(),
                        FlowChartView(
                          maxExpenses:
                              context.read<StatisticsCubit>().getTotalExpense(),
                          totalExpenses:
                              context.read<StatisticsCubit>().totalImportantExpenses(),
                          index: index,
                          priorityType: PriorityType.Important,
                          notPriority: PriorityType.NotImportant,
                          transactionsValues: getStatisticsCubit().transactionsValues,
                        ),

                        /// TabBarView Widgets.

                        Expanded(
                          flex: 32,
                          child: CustomTabBarViewEdited(
                              onPressSeeMore: () => onPressed(
                                  context,
                                  StatisticsDetailsScreen(
                                      index: index,
                                      transactions:
                                          context.read<StatisticsCubit>().byDayList)),
                              priorityName: PriorityType.Important,
                              expenseList: getStatisticsCubit().byDayList,
                              monthWidget: WeekCardViewEdited(
                                weekRanges: getStatisticsCubit().weekRangeText(),
                                chosenDay: getStatisticsCubit().chosenDay,
                                weeksTotals: getStatisticsCubit().totalsWeeks,
                                seeMoreOrDetailsOrHighest: SwitchWidgets.seeMore,
                              ),
                              currentIndex: currentIndex,
                              index: index,
                              pageController: _controller),
                        ),

                        // Expanded(
                        //     flex: 40,
                        //     child:
                        //         ListView.builder(
                        //             itemCount: getStatisticsCubit().currentIndex==0?getStatisticsCubit().byDayList.length:3,
                        //             itemBuilder: (context, index) {
                        //               TransactionModel item =getStatisticsCubit().byDayList[index];
                        //       return Visibility(
                        //         visible: getStatisticsCubit().currentIndex==0,
                        //           child: ExpansionTile(
                        //               title: Text(item.name),
                        //               children: [
                        //                 Text('${item.paymentDate}'),
                        //               ]
                        //
                        //           ),
                        //       replacement: ExpansionTile(title: Text("Week ${index+1}"),
                        //       subtitle: Text("${getStatisticsCubit().totals[index]}"),
                        //       ),
                        //       );
                        //     })
                        //
                        //
                        //
                        //     ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
