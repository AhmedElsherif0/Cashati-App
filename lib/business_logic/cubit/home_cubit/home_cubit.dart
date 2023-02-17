import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp/business_logic/repository/general_stats_repo/general_stats_repo.dart';
import 'package:temp/presentation/router/app_router_names.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.generalStatsRepo) : super(HomeInitial());
  final GeneralStatsRepo generalStatsRepo;
  bool isExpense = true;

  Future addTheGeneralStatsModel()async{
    if(generalStatsRepo.getTheGeneralStatsModel().isInBox){
      print('General stats model is in box already ${generalStatsRepo.getTheGeneralStatsModel()}');
      return;
    }else{
      await generalStatsRepo.addTheGeneralStateModel();
    }
  }

  void isItExpense() {
    isExpense = !isExpense;
    emit(SuccessState());
  }

  void onAddExpense(BuildContext context) {
    Navigator.of(context).pushNamed(AppRouterNames.rAddExpenseOrIncomeScreen);
  }

  void onAddIncome(BuildContext context) {
    Navigator.of(context).pushNamed(AppRouterNames.rAddExpenseOrIncomeScreen);
  }

  void onShowExpense() {}

  void onShowIncome() {}
}
