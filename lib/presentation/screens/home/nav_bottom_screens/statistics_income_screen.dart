import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_month_picker/flutter_month_picker.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:temp/business_logic/cubit/statistics_cubit/statistics_cubit.dart';
import 'package:temp/constants/app_strings.dart';
import 'package:temp/data/models/transactions/transaction_model.dart';
import 'package:temp/presentation/styles/colors.dart';
import 'package:temp/presentation/utils/extensions.dart';
import 'package:temp/presentation/views/flow_chart_view.dart';
import 'package:temp/presentation/views/week_card_view.dart';
import 'package:temp/presentation/widgets/buttons/elevated_button.dart';
import 'package:temp/presentation/widgets/show_dialog.dart';

import '../../../../constants/enum_classes.dart';
import '../../../../data/repository/formats_mixin.dart';
import '../../../views/tab_bar_view.dart';
import '../../../widgets/common_texts/details_text.dart';
import '../part_time_details.dart';
import '../statistics_week_details_screen.dart';

class IncomeStatisticsScreen extends StatefulWidget {
  const IncomeStatisticsScreen({Key? key}) : super(key: key);

  @override
  State<IncomeStatisticsScreen> createState() => _IncomeStatisticsScreenState();
}

class _IncomeStatisticsScreenState extends State<IncomeStatisticsScreen>
    with FormatsMixin, AlertDialogMixin {
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
    getStatisticsCubit().getTodayExpenses(false);
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant IncomeStatisticsScreen oldWidget) {
    context.read<StatisticsCubit>().getTotalExpense(isExpense: false);
    context.read<StatisticsCubit>().totalImportantExpenses(isExpense: false);
    super.didUpdateWidget(oldWidget);
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
    datePicker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (datePicker == null) return;
    getStatisticsCubit().getExpensesByDay(datePicker, false);
  }

  void showDatePickMonth() async {
    datePicker = await showMonthPicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (datePicker == null) return;
    getStatisticsCubit().changeDatePicker(datePicker);
    getStatisticsCubit().getTransactionsByMonth(false);
  }

  _onSeeMoreByWeek(BuildContext context, index) {
    if (getStatisticsCubit().weeks[index].isNotEmpty) {
      getStatisticsCubit().chosenFilterWeekDay = AppStrings.all.tr();
      context.navigateTo(StatisticsWeekDetailsScreen(
          weekRanges: getStatisticsCubit().weekRangeText(),
          builderIndex: index,
          transactions: getStatisticsCubit().weeks[index]));
    } else {
      errorSnackBar(
          context: context,
          message: '${AppStrings.noIncomesYet.tr()} ${AppStrings.inThisWeek.tr()}');
    }
  }

  _onSeeMoreByDay(BuildContext context, TransactionModel transaction) =>
      context.navigateTo(PartTimeDetails(transactionModel: transaction));

  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;
    return BlocBuilder<StatisticsCubit, StatisticsState>(
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
                          maxExpenses: context
                              .read<StatisticsCubit>()
                              .getTotalExpense(isExpense: false),
                          totalExpenses: context
                              .read<StatisticsCubit>()
                              .totalImportantExpenses(isExpense: false),
                          index: index,
                          priorityType: AppStrings.fixed,
                          notPriority: AppStrings.notFixed,
                          transactionsValues: getStatisticsCubit().transactionsValues,
                        ),
                        DetailsText(
                            text: AppStrings.filteredBy.tr(),
                            alignment: translator.activeLanguageCode == 'en'
                                ? Alignment.centerLeft
                                : Alignment.centerRight),

                        /// TabBarView Widgets.
                        Expanded(
                          flex: 32,
                          child: CustomTabBarViewEdited(
                            priorityName: PriorityType.Fixed,
                            transactions: getStatisticsCubit().byDayList,
                            onPressSeeMore: (int insideIndex) => _onSeeMoreByDay(
                                context, getStatisticsCubit().byDayList[insideIndex]),
                            index: index,
                            pageController: _controller,
                            monthWidget: WeekCardViewEdited(
                              onSeeMore: (weekIndex) =>
                                  _onSeeMoreByWeek(context, weekIndex),
                              weekRanges: getStatisticsCubit().weekRangeText(),
                              chosenDay: getStatisticsCubit().chosenDay,
                              weeksTotals: getStatisticsCubit().totalsWeeks,
                              seeMoreOrDetailsOrHighest: SwitchWidgets.seeMore,
                              priceColor: AppColor.secondColor,
                            ),
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
