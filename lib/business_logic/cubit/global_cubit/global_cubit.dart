import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:temp/notification_manager.dart';

import '../../../constants/app_strings.dart';
import '../../../constants/end_points.dart';
import '../../../constants/language_manager.dart';
import '../../../data/local/cache_helper.dart';
import '../../../data/models/onbaording/onbaording_list_of_data.dart';
import '../../../data/repository/helper_class.dart';

part 'global_state.dart';

enum CurrencyPayment { EGP, USD }

class GlobalCubit extends Cubit<GlobalState> with HelperClass {
  GlobalCubit() : super(GlobalInitial());

  ////////////////////////language
  bool isEnglish = false;
  bool isArabic = false;
  bool isEnable = false;
  bool isLanguage = translator.activeLanguageCode == 'en';
  LanguageManager languageManager = LanguageManager();
  late TimeOfDay chosenTime;

  final NotificationsManagerHandler notificationsManagerHandler =
      NotificationsManagerHandler();
  final NotificationManager _notificationManager = NotificationManager();

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

  initializeNotificationTime() {
    final time = notificationsManagerHandler.fetchCurrentSavedTime().split(":");
    if (time.first.isNotEmpty) {
      chosenTime =
          TimeOfDay(hour: int.parse(time.first), minute: int.parse(time.last ?? "00"));
    } else {
      chosenTime = TimeOfDay(hour: 9, minute: 0);
    }
    _initializeNotificationEnabled();
  }

  _initializeNotificationEnabled() {
    isEnable =
        notificationsManagerHandler.fetchCurrentSavedTime().isNotEmpty ? true : false;
  }

  String getNotificationTime() {
    final currSavedTime = notificationsManagerHandler.fetchCurrentSavedTime();
    if (currSavedTime.isNotEmpty) {
      return _convertTime(
          " ${_timeMinusTwelve(currSavedTime)} ${_replacePmAm(currSavedTime, isLanguage)}",
          isLanguage);
    } else {
      return _convertTime("9:00 ${_replacePmAm("9:00", isLanguage)}", isLanguage);
    }
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

  void enableNotifications({required bool value}) async {
    isEnable = value;

    if (isEnable) {
      await _notificationManager.scheduleDailyNotification(
          hour: chosenTime.hour, minute: chosenTime.minute);
      //  chosenTime=TimeOfDay(hour: int.parse(notificationsManagerHandler.fetchCurrentSavedTime().split(":").first), minute: int.parse(notificationsManagerHandler.fetchCurrentSavedTime().split(":").last??"00"));
      await notificationsManagerHandler.saveTime(
          hour: chosenTime.hour, minute: chosenTime.minute);

      print("Saved Time in Enabled Which is ${chosenTime}");
      emit(SavedDailyNotification());
    } else {
      await _notificationManager.cancelNotification();
      await notificationsManagerHandler.clearTime();
      emit(CanceledDailyNotification());
    }
    // emit(ChangeEnableNotifications());
  }

  void changeNotificationTime({required BuildContext context}) async {
    final chosenTimePicker =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (chosenTimePicker != null) {
      chosenTime = chosenTimePicker;

      await notificationsManagerHandler.saveTime(
          hour: chosenTime.hour, minute: chosenTime.minute);
      print("Saved Time Which is ${chosenTime}");
      emit(ChangeNotificationTime());
      await _notificationManager.cancelNotification().whenComplete(() async {
        emit(CanceledDailyNotification());
        await _notificationManager
            .scheduleDailyNotification(
                hour: chosenTime.hour, minute: chosenTime.minute)
            .whenComplete(() => isEnable = true);
        emit(SavedDailyNotification());
      });
    }
  }

  void emitDrawer() {
    emit(OpenDrawerState());
  }

  String _convertTime(String time, bool toEnglish) {
    String convertedTime = '';
    if (toEnglish) {
      for (int i = 0; i < time.length; i++) {
        final String char = time[i];
        convertedTime += arabicToEnglishNum(char);
      }
    } else {
      for (int i = 0; i < time.length; i++) {
        final String char = time[i];
        final String convertedChar = engToArabNum(char);
        convertedTime += convertedChar;
      }
    }
    return convertedTime;
  }

  String _timeMinusTwelve(String convertedTime) {
    final splitTime = convertedTime.split(":");
    if (int.parse(splitTime.first) >= 12) {
      return "${int.parse(splitTime.first) - 12}:${splitTime.last}";
    } else {
      return convertedTime;
    }
  }

  String _replacePmAm(String savedTime, bool isEnglishLang) {
    if (int.parse(savedTime.split(":").first) > 12) {
      return isEnglishLang ? "PM" : 'م';
    } else {
      return isEnglishLang ? "AM" : 'ص';
    }
  }

/*  bool isArabicTime(String time) {
    final arabicTimeRegex = RegExp(r'^[٠-٩]+(:[٠-٥٩]+)?[مص]$');
    return arabicTimeRegex.hasMatch(time);
  }*/

/* String convertTimeToEnglish(String time) {

    String convertedTime = '';
    for (int i = 0; i < time.length; i++) {
      final String char = time[i];
      final String convertedChar = arabicToEnglish[char] ?? char;
      convertedTime += convertedChar;
    }

    return convertedTime;
  }*/
}
