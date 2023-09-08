import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:temp/constants/end_points.dart';
import 'package:temp/constants/language_manager.dart';

import '../../../constants/app_strings.dart';
import '../../../data/local/cache_helper.dart';
import '../../../data/models/onbaording/onbaording_list_of_data.dart';

part 'global_state.dart';

enum CurrencyPayment { EGP, USD }

class GlobalCubit extends Cubit<GlobalState> {
  GlobalCubit() : super(GlobalInitial());

  ////////////////////////language
  bool isEnglish = false;
  bool isArabic = false;
  bool isEnable = false;
  bool isLanguage = translator.activeLanguageCode == 'en';
  LanguageManager languageManager = LanguageManager();

  /// Currency
  final OnBoardingData _boardingData = OnBoardingData();
  String selectedValue = AppStrings.chooseCurrency.tr();
  String curr = 'LE';
  String curr1 = 'جنية';

  List<String> get getCurrency => translator.activeLanguageCode == 'en'
      ? _boardingData.englishCurrency
      : _boardingData.arabicCurrency;

  void changeCurrency() {
    if (isLanguage) selectedValue = isEnglish ? 'EGP' : 'USD';
    if (!isLanguage) selectedValue = isArabic ? 'المصرية' : 'الامريكية';
    print('changeCurrency is $selectedValue');
    onChangeCurrency(selectedValue);
  }

  void onChangeCurrency(String? value) {
    selectedValue = value!;
    translator.activeLanguageCode == 'en'
        ? curr = currencySign()
        : curr1 = currencySign();
    CacheHelper.saveDataSharedPreference(key: appCurrencyKey, value: selectedValue);
    emit(CurrencyChangedState());
  }

  String currencySign() {
    switch (selectedValue) {
      case 'EGP':
        curr = 'LE';
        break;
      case 'المصرية':
        curr1 = 'جنية';
        break;
      case 'USD':
        curr = '\$';
        break;
      case 'الامريكية':
        curr1 = 'دولار';
        break;
    }
    return translator.activeLanguageCode == 'en' ? curr : curr1;
  }

  void onChangeLanguage(bool value) {
    isLanguage = translator.activeLanguageCode == 'en';
    isEnglish = value;
    languageManager.changeAppLanguage();
    emit(LanguageChangedState());
  }

  void swapLangBGColor(bool isValue) {
    isEnglish = isValue;
    isArabic = !isValue;
    emit(ChangeLanguageBGColorState());
  }

  void swapCurrencyBGColor(bool isValue) {
    isEnglish = isValue;
    isArabic = !isValue;
    emit(ChangeCurrencyBGColorState());
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
