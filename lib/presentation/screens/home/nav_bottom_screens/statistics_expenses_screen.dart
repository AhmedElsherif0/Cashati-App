import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_month_picker/flutter_month_picker.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:temp/business_logic/cubit/statistics_cubit/statistics_cubit.dart';
import 'package:temp/constants/app_strings.dart';
import 'package:temp/data/repository/helper_class.dart';
import 'package:temp/presentation/screens/home/statistics_week_details_screen.dart';
import 'package:temp/presentation/views/flow_chart_view.dart';
import 'package:temp/presentation/views/week_card_view.dart';
import 'package:temp/presentation/widgets/buttons/elevated_button.dart';

import '../../../../constants/enum_classes.dart';
import '../../../../data/models/transactions/transaction_model.dart';
import '../../../router/app_router.dart';
import '../../../styles/colors.dart';
import '../../../views/tab_bar_view.dart';
import '../../../widgets/common_texts/details_text.dart';
import '../part_time_details.dart';
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
  void didChangeDependencies() {
    getStatisticsCubit().getExpenses();
    getStatisticsCubit().getTodayExpenses(true);
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant ExpensesStatisticsScreen oldWidget) {
    context.read<StatisticsCubit>().getTotalExpense();
    context.read<StatisticsCubit>().totalImportantExpenses();

    super.didUpdateWidget(oldWidget);
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

  // _onSeeMoreByWeek(context, index) => Navigator.push(
  //     context,
  //     AppRouter.pageBuilderRoute(
  //         child: StatisticsDetailsScreen(
  //             index: index, transactions: getStatisticsCubit().weeks[index])));
  _onSeeMoreByWeek(context, index) {
    if(getStatisticsCubit().weeks[index].isNotEmpty){
      Navigator.push(
          context,
          AppRouter.pageBuilderRoute(
              child: StatisticsWeekDetailsScreen(
                  builderIndex: index,
                  transactions: getStatisticsCubit().weeks[index])));
    }else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No Expenses in this week.")));
    }
  }

  _onSeeMoreByDay(context, TransactionModel transaction, insideIndex) =>
      Navigator.push(
          context,
          AppRouter.pageBuilderRoute(
              child: PartTimeDetails(
            transactionModel: transaction,
            insideIndex: insideIndex,
          )));

  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;
    return Scaffold(
      body: BlocConsumer<StatisticsCubit, StatisticsState>(
        listener: (context, state) {},
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
                                ? formatDayDate(getStatisticsCubit().chosenDay,
                                    translator.activeLanguageCode)
                                : formatWeekDate(getStatisticsCubit().chosenDay,
                                    translator.activeLanguageCode),
                            textStyle: Theme.of(context).textTheme.subtitle1,
                            backgroundColor: AppColor.white,
                            width: 40.w,
                            borderRadius: 8.dp,
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
                         DetailsText(text: AppStrings.filteredBy.tr(),
                         alignment: translator.activeLanguageCode == 'en'?
                         Alignment.centerLeft:Alignment.centerRight),
                        Expanded(
                          flex: 32,
                          child: CustomTabBarViewEdited(
                            onPressSeeMore: (int insideIndex) => _onSeeMoreByDay(
                                context,
                                getStatisticsCubit().byDayList[insideIndex],
                                insideIndex),
                            priorityName: PriorityType.Important,
                            transactions: getStatisticsCubit().byDayList,
                            index: index,
                            pageController: _controller,
                            monthWidget: WeekCardViewEdited(
                              onSeeMore:  (weekIndex) => _onSeeMoreByWeek(
                                  context,
                                  weekIndex),
                              weekRanges: getStatisticsCubit().weekRangeText(),
                              chosenDay: getStatisticsCubit().chosenDay,
                              weeksTotals: getStatisticsCubit().totalsWeeks,
                              seeMoreOrDetailsOrHighest: SwitchWidgets.seeMore,
                            ),
                          ),
                        ),
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
