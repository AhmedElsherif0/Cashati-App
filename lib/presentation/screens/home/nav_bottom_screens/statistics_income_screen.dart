import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_month_picker/flutter_month_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/business_logic/cubit/statistics_cubit/statistics_cubit.dart';
import 'package:temp/data/repository/helper_class.dart';
import 'package:temp/presentation/styles/colors.dart';
import 'package:temp/presentation/views/flow_chart_view.dart';
import 'package:temp/presentation/views/week_card_view.dart';
import 'package:temp/presentation/widgets/buttons/elevated_button.dart';

import '../../../../constants/enum_classes.dart';
import '../../../views/tab_bar_view.dart';
import '../statistics_details_screen.dart';

class IncomeStatisticsScreen extends StatefulWidget {
  const IncomeStatisticsScreen({Key? key}) : super(key: key);

  @override
  State<IncomeStatisticsScreen> createState() => _IncomeStatisticsScreenState();
}

class _IncomeStatisticsScreenState extends State<IncomeStatisticsScreen>
    with HelperClass {
  final PageController _controller = PageController(initialPage: 0);
  DateTime? datePicker =DateTime.now();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    getStatisticsCubit().getIncome();
    getStatisticsCubit().getTransactionsByMonth(false);
    getStatisticsCubit().getTodayExpenses(false);
    super.initState();
  }

  StatisticsCubit getStatisticsCubit() => BlocProvider.of<StatisticsCubit>(context);

  void showDatePick() async {
    final datePicker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (datePicker == null) return;
    getStatisticsCubit().getExpensesByDay(datePicker, false);
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
    getStatisticsCubit().getTransactionsByMonth(false);
  }

  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;
    return BlocConsumer<StatisticsCubit, StatisticsState>(
      listener: (context, state) {},
      builder: (context, state) {
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
                        ConstrainedBox(
                          constraints: BoxConstraints(minWidth: 20.h, maxWidth: 35.h),
                          child: CustomElevatedButton(
                            onPressed: () => showDatePick(),
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
                          maxExpenses: context
                              .read<StatisticsCubit>()
                              .getTotalExpense(isExpense: false),
                          totalExpenses: context
                              .read<StatisticsCubit>()
                              .totalImportantExpenses(isExpense: false),
                          index: index,
                          priorityType: PriorityType.Fixed,
                          notPriority: PriorityType.NotFixed,
                          transactionsValues: getStatisticsCubit().transactionsValues,
                        ),

                        /// TabBarView Widgets.
                        Expanded(
                          flex: 36,
                          child: CustomTabBarViewEdited(
                            priorityName: PriorityType.Fixed,
                            expenseList: getStatisticsCubit().byDayList,
                            onPressSeeMore: () => onPressed(
                              context,
                              StatisticsDetailsScreen(
                                  index: index,
                                  transactions:
                                      context.read<StatisticsCubit>().byDayList),
                            ),
                            monthWidget: WeekCardViewEdited(
                              weekRanges: getStatisticsCubit().weekRangeText(),
                              chosenDay: getStatisticsCubit().chosenDay,
                              weeksTotals: getStatisticsCubit().totalsWeeks,
                              seeMoreOrDetailsOrHighest: SwitchWidgets.seeMore,
                              priceColor: AppColor.secondColor,
                            ),
                            currentIndex: currentIndex,
                            index: index,
                            pageController: _controller,
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
      },
    );
  }
}
