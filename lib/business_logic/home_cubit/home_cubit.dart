import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);
  bool isSelect = true;
  void changeExpensesAndIncome(){
    isSelect = !isSelect;
    emit(SuccessState());
  }

}