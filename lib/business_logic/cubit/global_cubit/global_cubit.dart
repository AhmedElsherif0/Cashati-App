import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:temp/constants/language_manager.dart';

part 'global_state.dart';

class GlobalCubit extends Cubit<GlobalState> {
  GlobalCubit() : super(GlobalInitial());

  ////////////////////////language
  LanguageManager languageManager = LanguageManager();
  bool isEnglish = false;
  bool isArabic = false;
  bool isEnable = false;
  bool isLanguage = translator.activeLanguageCode == 'en';

  void changeLanguage(bool value) {
    isLanguage = translator.activeLanguageCode == 'en';
    isEnglish = value;
    languageManager.changeAppLanguage();
    emit(LanguageChangedState());
  }

  void changeLangBGColor(bool isValue) {
    isEnglish = isValue;
    isArabic = !isValue;
  }

  int currentIndex = 0;

  void changePage({required int index}) {
    currentIndex = index;
    emit(ChangeScreenState());
  }

  void enableNotifications({required bool value}) {
    isEnable = value;
    emit(ChangeEnableNotifications());
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
