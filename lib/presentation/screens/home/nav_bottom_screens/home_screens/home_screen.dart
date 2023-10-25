import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:temp/business_logic/cubit/add_exp_inc/add_exp_or_inc_cubit.dart';
import 'package:temp/constants/app_strings.dart';
import 'package:temp/data/models/statistics/general_stats_model.dart';
import 'package:temp/presentation/utils/extensions.dart';
import 'package:temp/presentation/widgets/expenses_and_income_widgets/expenses_income_header.dart';

import '../../../../../business_logic/cubit/home_cubit/home_cubit.dart';
import '../../../../../business_logic/cubit/home_cubit/home_state.dart';
import '../../../../router/app_router_names.dart';
import '../../../../views/card_home.dart';
import '../../part_time_details.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  void onAddTransaction(BuildContext context, bool isExpense) {
    isExpense
        ? context.read<AddExpOrIncCubit>().currentIndex = 0
        : context.read<AddExpOrIncCubit>().currentIndex = 1;
    Navigator.of(context).pushNamed(AppRouterNames.rAddExpenseOrIncomeScreen);
  }

  void showHighestTransactionDetails(BuildContext context) {
    final highestTransaction = context.read<HomeCubit>().fetchHighestTransaction();
    context.navigateTo(PartTimeDetails(transactionModel: highestTransaction));
  }

  @override
  Widget build(BuildContext context) {
    final homeCubit = BlocProvider.of<HomeCubit>(context);
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) async {
        if (state is HomeInitial) {
          homeCubit.getTheGeneralStatsModel();
        } else if (state is FetchedGeneralModelSuccState ||
            state is ModelExistsSuccState) {
          homeCubit.getNotificationList();
          homeCubit.fetchTopExpAndTopInc();
        }
      },
      builder: (context, state) {
        if (state is HomeInitial || state is ModelExistsFailState) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Scaffold(
            body: Column(
              children: [
                const Spacer(flex: 2),

                /// switch between expense and income.
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14.dp),
                    child: ExpensesAndIncomeHeader(
                        alignmentExpense: translator.activeLanguageCode == 'ar'
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        alignmentIncomeOrGoals: translator.activeLanguageCode == 'ar'
                            ? Alignment.centerLeft
                            : Alignment.centerRight,
                        onPressedIncome: () =>
                            homeCubit.isExpense ? homeCubit.isItExpense() : null,
                        onPressedExpense: () =>
                            !homeCubit.isExpense ? homeCubit.isItExpense() : null,
                        isExpense: homeCubit.isExpense),
                  ),
                ),
                Expanded(
                  flex: 12,
                  child: CardHome(
                    isExpense: homeCubit.isExpense,
                    generalStatsModel: homeCubit.generalStatsModel ??
                        GeneralStatsModel(
                          id: AppStrings.onlyId,
                          balance: 0,
                          topIncome: AppStrings.noIncYet.tr(),
                          topIncomeAmount: 0,
                          topExpense: AppStrings.noExpYet.tr(),
                          topExpenseAmount: 0,
                          latestCheck: DateTime.now(),
                          notificationList: [],
                        ),
                    title: homeCubit.isExpense
                        ? AppStrings.expenseSmall
                        : AppStrings.incomeSmall,
                    onAdd: () => onAddTransaction(context, homeCubit.isExpense),
                    onShow: () => homeCubit.generalStatsModel != null
                        ? showHighestTransactionDetails(context)
                        : null,
                  ),
                ),
                const Spacer(),
              ],
            ),
          );
        }
      },
    );
  }
}
