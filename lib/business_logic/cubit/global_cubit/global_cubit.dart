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
  String selectedCurrency = AppStrings.chooseCurrency;
  String curr = 'LE';
  String curr1 = 'جنية';
  int currentIndex = 0;

  List<String> get getCurrency => translator.activeLanguageCode == 'en'
      ? _boardingData.englishCurrency
      : _boardingData.arabicCurrency;

  void changeCurrency() {
    selectedCurrency = AppStrings.chooseCurrency.tr();
    if (isLanguage) selectedCurrency = isEnglish ? 'EGP' : 'USD';
    if (!isLanguage) selectedCurrency = isArabic ? 'المصرية' : 'الامريكية';
    print('changeCurrency is $selectedCurrency');
    onChangeCurrency(selectedCurrency);
  }

  void onChangeCurrency(String? value) {
    selectedCurrency = value!;
    translator.activeLanguageCode == 'en'
        ? curr = _currencySign()
        : curr1 = _currencySign();
    CacheHelper.saveDataSharedPreference(key: appCurrencyKey, value: selectedCurrency);
    emit(CurrencyChangedState());
  }

  void onChangeLanguage(bool value) {
    isLanguage = translator.activeLanguageCode == 'en';
    isEnglish = value;
    languageManager.changeAppLanguage();
    onChangeCurrency(_returnTheRightValue());
    emit(LanguageChangedState());
  }

  String _returnTheRightValue() {
    if (isLanguage && selectedCurrency == 'المصرية') return selectedCurrency = 'EGP';
    if (!isLanguage && selectedCurrency == 'EGP') return selectedCurrency = 'المصرية';
    if (isLanguage && selectedCurrency == 'الامريكية') return selectedCurrency = 'USD';
    if (!isLanguage && selectedCurrency == 'USD')
      return selectedCurrency = 'الامريكية';
    return selectedCurrency;
  }

  String _currencySign() {
    switch (selectedCurrency) {
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
