import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/cubit/add_exp_inc/add_exp_or_inc_cubit.dart';
import '../../business_logic/cubit/add_subcategory/add_subcategory_cubit.dart';
import '../../business_logic/cubit/confirm_payments/confirm_payment_cubit.dart';
import '../../business_logic/cubit/expense_repeat/expense_repeat_cubit.dart';
import '../../business_logic/cubit/global_cubit/global_cubit.dart';
import '../../business_logic/cubit/goals_cubit/goals_cubit.dart';
import '../../business_logic/cubit/home_cubit/home_cubit.dart';
import '../../business_logic/cubit/income_repeat/income_repeat_cubit.dart';
import '../../business_logic/cubit/statistics_cubit/statistics_cubit.dart';
import '../../business_logic/repository/general_stats_repo/general_stats_repo.dart';
import '../../business_logic/repository/transactions_repo/transaction_repo.dart';
import '../../data/repository/expenses_repo_impl/expenses_repo_impl.dart';
import '../../data/repository/general_stats_repo_impl/general_stats_repo_impl.dart';
import '../../data/repository/income_repo_impl/income_repo_impl.dart';

class AppBlocs {
  List<BlocProvider> providers() {
    final TransactionRepo _expensesRepository = ExpensesRepositoryImpl();
    final TransactionRepo _incomeRepository = IncomeRepositoryImpl();
    final GeneralStatsRepo _generalStatsRepository = GeneralStatsRepoImpl();
    return [
      BlocProvider(create: ((context) => GlobalCubit())),
      BlocProvider(
          create: ((context) =>
              HomeCubit(_generalStatsRepository)..getTheGeneralStatsModel())),
      BlocProvider(
          create: ((context) => AddExpOrIncCubit(
              _expensesRepository, _incomeRepository, _generalStatsRepository))),
      BlocProvider(create: ((context) => ExpenseRepeatCubit(_expensesRepository))),
      BlocProvider(create: ((context) => IncomeRepeatCubit(_incomeRepository))),
      BlocProvider(create: ((context) => AddSubcategoryCubit())),
      BlocProvider(create: ((context) => GoalsCubit())),
      BlocProvider(create: ((context) => ConfirmPaymentCubit())),
      BlocProvider(create: ((context) => StatisticsCubit(_expensesRepository))),
    ];
  }
}
