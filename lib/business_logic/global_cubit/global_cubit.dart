import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../presentation/screens/home/nav_bottom_screens/category_screen.dart';
import '../../presentation/screens/home/nav_bottom_screens/home_screen.dart';
import '../../presentation/screens/home/nav_bottom_screens/settings_screen.dart';
import '../../presentation/screens/home/nav_bottom_screens/statistics_expenses_screen.dart';
import '../../presentation/screens/home/nav_bottom_screens/statistics_income_screen.dart';

part 'global_state.dart';

class GlobalCubit extends Cubit<GlobalState> {
  GlobalCubit() : super(GlobalInitial());

  static GlobalCubit get(context) => BlocProvider.of(context);
  ////////////////////////language
  bool isEnglish = true;
  void changeLanguage() {
    isEnglish != isEnglish;
    emit(LanguageChangedState());
  }
  int currentIndex = 0;
  List<Widget> nextPage = [
    const HomeScreen(),
    const CategoryScreen(),
    const ExpensesStatisticsScreen(),
    const IncomeStatisticsScreen(),
    const SettingsScreen()
  ];

  void changePage({required int index}){
    currentIndex = index;
    emit(ChangeScreenState());
  }

  ////////////////////////navigator
  Future navigate({VoidCallback? afterSuccess}) async {
    await Future.delayed(const Duration(milliseconds: 1500), () {});
    afterSuccess!();
  }
}
