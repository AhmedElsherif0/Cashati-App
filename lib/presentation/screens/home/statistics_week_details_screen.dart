import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:temp/business_logic/cubit/statistics_cubit/statistics_cubit.dart';
import 'package:temp/constants/app_lists.dart';
import 'package:temp/constants/app_strings.dart';
import 'package:temp/constants/enum_classes.dart';
import 'package:temp/data/models/transactions/transaction_model.dart';
import 'package:temp/data/repository/helper_class.dart';
import 'package:temp/presentation/screens/home/part_time_details.dart';
import 'package:temp/presentation/screens/shared/empty_screen.dart';
import 'package:temp/presentation/styles/colors.dart';
import 'package:temp/presentation/utils/extensions.dart';
import 'package:temp/presentation/widgets/dorp_downs_buttons/goals_drop_down.dart';
import 'package:temp/presentation/widgets/expenses_and_income_widgets/important_or_fixed.dart';
import 'package:temp/presentation/widgets/transaction_card.dart';

import '../../../constants/app_icons.dart';
import '../../router/app_router_names.dart';
import '../../widgets/custom_app_bar.dart';

class StatisticsWeekDetailsScreen extends StatelessWidget with HelperClass {
  const StatisticsWeekDetailsScreen({
    Key? key,
    this.transactions = const [],
    this.weekRanges = const [],
    required this.builderIndex,
    this.newRouteName,
  }) : super(key: key);

  final List<TransactionModel> transactions;
  final List<String> weekRanges;
  final int builderIndex;
  final String? newRouteName;

  String _appTitle(index) {
    final transactionType =
        transactions[0].isExpense ? AppStrings.expenses.tr() : AppStrings.income.tr();
    return translator.activeLanguageCode == 'en'
        ? '${'the'.tr()} ${AppStrings.week.tr()} $transactionType'
        : '$transactionType ${'the'.tr()}${AppStrings.week.tr()}';
  }

  bool _isAll(context) {
    final chosenFilterWeekDay =
        BlocProvider.of<StatisticsCubit>(context).chosenFilterWeekDay;
    return chosenFilterWeekDay == "All" || chosenFilterWeekDay == "الكل";
  }

  List<DropdownMenuItem<String>> _daysFilter() =>
      (translator.activeLanguageCode == 'en'
              ? AppConstantList.englishDays
              : AppConstantList.arabicDays)
          .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
          .toList();

  String _weekDateTime() {
    if (newRouteName == AppRouterNames.rExpenseStatistics) {
      return weekRanges[builderIndex];
    }
    final weeks = getWeekRange(chosenDay: transactions[builderIndex].createdDate);
    if (transactions[builderIndex].createdDate.day <= 7) return weeks[0];
    if (transactions[builderIndex].createdDate.day <= 14) return weeks[1];
    if (transactions[builderIndex].createdDate.day <= 21) return weeks[2];
    if (transactions[builderIndex].createdDate.day <= 28) return weeks[3];
    return weeks[4];
  }

  void _toPartTimeScreen(BuildContext context, currIndex, statisticsCubit) =>
      context.navigateTo(PartTimeDetails(
          transactionModel: _isAll(context)
              ? transactions[currIndex]
              : statisticsCubit.transactionsWeekFiltered[currIndex]));

  @override
  Widget build(BuildContext context) {
    final statisticsCubit = context.read<StatisticsCubit>();
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<StatisticsCubit, StatisticsState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomAppBar(title: _appTitle(builderIndex), isEndIconVisible: false),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(_weekDateTime(),
                          style: theme.textTheme.headline6,
                          overflow: TextOverflow.ellipsis),
                      const SizedBox(width: 20),
                      Expanded(
                        child: GoalsFilterWidget(
                            iconHeight: 1.h,
                            isExpanded: true,
                            iconWidget: Icon(Icons.keyboard_arrow_down,
                                color: AppColor.primaryColor, size: 24.dp),
                            value: statisticsCubit.chosenFilterWeekDay,
                            dropDownList: _daysFilter(),
                            hint: AppStrings.chooseDay.tr(),
                            leadingIcon: AppIcons.dateIcon,
                            onChangedFunc: (val) {
                              statisticsCubit.filterWeekTransactionsByDay(
                                  dayName: val, weekTransactions: transactions);
                            }),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          PriorityWidget(text: AppStrings.important),
                          PriorityWidget(
                              text: AppStrings.notImportant,
                              color: AppColor.pinkishGrey)
                        ],
                      ),
                    ],
                  ),
                ),
                //TODO change empty screen and make it dynamic with any empty Lost
                Expanded(
                  flex: 8,
                  child: Visibility(
                    visible: !_isAll(context) &&
                        statisticsCubit.transactionsWeekFiltered.isEmpty,
                    replacement: ListView.builder(
                      itemCount: _isAll(context)
                          ? transactions.length
                          : statisticsCubit.transactionsWeekFiltered.length,
                      itemBuilder: (_, currIndex) => InkWell(
                        onTap: () =>
                            _toPartTimeScreen(context, currIndex, statisticsCubit),
                        child: TransactionsCard(
                          index: currIndex,
                          isRepeated: false,
                          isSeeMore: true,
                          transactionModel: _isAll(context)
                              ? transactions[currIndex]
                              : statisticsCubit.transactionsWeekFiltered[currIndex],
                          priorityName: _isAll(context)
                              ? transactions[currIndex].isPriority
                                  ? AppStrings.important
                                  : AppStrings.notImportant
                              : statisticsCubit
                                      .transactionsWeekFiltered[currIndex].isPriority
                                  ? AppStrings.important
                                  : AppStrings.notImportant,

                          /// check if this is the higherExpense so show it.
                          switchWidget: SwitchWidgets.higherExpenses,
                        ),
                      ),
                    ),
                    child: const EmptyScreen(),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

class PreviousRouteObserver extends NavigatorObserver {
  Route<dynamic>? previousRoute;
  Route<dynamic>? beforePrevious;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    this.previousRoute = previousRoute;
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    previousRoute = oldRoute;
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    this.previousRoute = previousRoute;
  }
}
