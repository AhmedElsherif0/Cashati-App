import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp/presentation/router/app_router_names.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  bool isExpense = true;
  void isItExpense() {
    isExpense = !isExpense;
    emit(SuccessState());
  }

  void onAddExpense(BuildContext context){
    Navigator.of(context).pushNamed(AppRouterNames.rAddExpenseOrIncomeScreen);
  }
  void onAddIncome(BuildContext context){
    Navigator.of(context).pushNamed(AppRouterNames.rAddExpenseOrIncomeScreen);

  }
  void onShowExpense(){

  }
  void onShowIncome(){

  }
}
