import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../presentation/screens/home/nav_bottom_screens/category_screen.dart';
import '../../../presentation/screens/home/nav_bottom_screens/home_screen.dart';
import '../../../presentation/screens/home/nav_bottom_screens/settings_screen.dart';
import '../../../presentation/screens/home/nav_bottom_screens/statistics_expenses_screen.dart';
import '../../../presentation/screens/home/nav_bottom_screens/statistics_income_screen.dart';

part 'global_state.dart';

class GlobalCubit extends Cubit<GlobalState> {
  GlobalCubit() : super(GlobalInitial());

  ////////////////////////language
  bool isEnglish = true;

  void changeLanguage(bool isCheck) {
    if(isCheck) {
      isEnglish = !isEnglish;
    }
    emit(LanguageChangedState());
  }

  int currentIndex = 0;

  List<Widget> nextPage = [
    const HomeScreen(),
    const ConfirmPayingScreen(),
    const ExpensesStatisticsScreen(),
    const IncomeStatisticsScreen(),
    const SettingsScreen()
  ];

  List<String> appBarTitle = [
    'Home',
    'Confirm Paying Today',
    'Statistics expenses',
    'Statistics Income',
    'Settings'
  ];

  void changePage({required int index}) {
    currentIndex = index;
    emit(ChangeScreenState());
  }

  void emitDrawer(context) {
    Scaffold.of(context).openDrawer();
    emit(OpenDrawerState());
  }

  ////////////////////////navigator
  Future navigate({VoidCallback? afterSuccess}) async {
    await Future.delayed(const Duration(milliseconds: 1500), () {});
    afterSuccess!();
  }
}
