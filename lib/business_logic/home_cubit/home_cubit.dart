import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  bool isExpense = true;
  void isItExpense() {
    isExpense = !isExpense;
    emit(SuccessState());
  }

  void onAddExpense(){

  }
  void onAddIncome(){

  }
  void onShowExpense(){

  }
  void onShowIncome(){

  }
}
