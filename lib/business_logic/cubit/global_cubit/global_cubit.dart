import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:temp/constants/end_points.dart';
import 'package:temp/constants/language_manager.dart';
import 'package:temp/notification_manager.dart';

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
   late TimeOfDay chosenTime;

  final NotificationsManagerHandler notificationsManagerHandler=NotificationsManagerHandler();
  final NotificationManager _notificationManager=NotificationManager();
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
   initializeNotificationTime(){
     chosenTime=TimeOfDay(hour: int.parse(notificationsManagerHandler.fetchCurrentSavedTime().split(":").first), minute: int.parse(notificationsManagerHandler.fetchCurrentSavedTime().split(":").last));
  }
  initializeNotificationEnabled(){
    if(notificationsManagerHandler.fetchCurrentSavedTime().isNotEmpty){
      isEnable=true;
    }else{
      isEnable=false;
    }
  }
  String getNotificationTime(){
    if(notificationsManagerHandler.fetchCurrentSavedTime().isNotEmpty){
      return convertTime(" ${timeMinusTwelve(notificationsManagerHandler.fetchCurrentSavedTime())} ${replacePmAm(notificationsManagerHandler.fetchCurrentSavedTime(),isLanguage)}",isLanguage);

    }else{
      return convertTime("9:00 ${replacePmAm("9:00",isLanguage)}",isLanguage);

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

  void enableNotifications({required bool value})async {
    isEnable = value;
    if(isEnable){
      await _notificationManager.scheduleDailyNotification(hour: chosenTime.hour,minute: chosenTime.minute);
      emit(SavedDailyNotification());
    }else{
      await _notificationManager.cancelNotification();
      await notificationsManagerHandler.clearTime();
      emit(CanceledDailyNotification());
    }
    // emit(ChangeEnableNotifications());

  }
  void changeNotificationTime({required BuildContext context})async {
    final chosenTimePicker=await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if(chosenTimePicker!=null){
      chosenTime=chosenTimePicker;

      await notificationsManagerHandler.saveTime(hour: chosenTime.hour, minute: chosenTime.minute);
      print("Saved Time Which is ${chosenTime}");
      emit(ChangeNotificationTime());
      await _notificationManager.cancelNotification();
      emit(CanceledDailyNotification());
      await _notificationManager.scheduleDailyNotification(hour: chosenTime.hour,minute: chosenTime.minute);
      emit(SavedDailyNotification());

    }else{

    }
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
  String convertTime(String time, bool toEnglish) {
    final Map<String, String> arabicToEnglish = {
      '٠': '0',
      '١': '1',
      '٢': '2',
      '٣': '3',
      '٤': '4',
      '٥': '5',
      '٦': '6',
      '٧': '7',
      '٨': '8',
      '٩': '9',
    };

    final Map<String, String> englishToArabic = {
      '0': '٠',
      '1': '١',
      '2': '٢',
      '3': '٣',
      '4': '٤',
      '5': '٥',
      '6': '٦',
      '7': '٧',
      '8': '٨',
      '9': '٩',
    };

    String convertedTime = '';
    if (toEnglish) {
      for (int i = 0; i < time.length; i++) {
        final String char = time[i];
        final String convertedChar = arabicToEnglish[char] ?? char;
        convertedTime += convertedChar;
      }
    } else {
      for (int i = 0; i < time.length; i++) {
        final String char = time[i];
        final String convertedChar = englishToArabic[char] ?? char;
        convertedTime += convertedChar;
      }
    }
    return convertedTime;


  }
  timeMinusTwelve(String convertedTime){
    if(int.parse(convertedTime.split(":").first)>=12){
      return "${int.parse(convertedTime.split(":").first)-12}:${convertedTime.split(":").last}";
    }else{
      return convertedTime;
    }


  }

  bool isArabicTime(String time) {
    final arabicTimeRegex = RegExp(r'^[٠-٩]+(:[٠-٥٩]+)?[مص]$');
    return arabicTimeRegex.hasMatch(time);
  }

  String convertTimeToEnglish(String time) {
    final Map<String, String> arabicToEnglish = {
      '٠': '0',
      '١': '1',
      '٢': '2',
      '٣': '3',
      '٤': '4',
      '٥': '5',
      '٦': '6',
      '٧': '7',
      '٨': '8',
      '٩': '9',
    };

    String convertedTime = '';
    for (int i = 0; i < time.length; i++) {
      final String char = time[i];
      final String convertedChar = arabicToEnglish[char] ?? char;
      convertedTime += convertedChar;
    }

    return convertedTime;
  }

  // String convertTimePMOrAm(String time, bool toEnglish) {
  //   if (isArabicTime(time)) {
  //     if (toEnglish) {
  //       return convertTimeToEnglish(time);
  //     } else {
  //       return time.replaceAll('م', 'PM').replaceAll('ص', 'AM');
  //     }
  //   } else {
  //     if (toEnglish) {
  //       return time;
  //     } else {
  //       return time.replaceAll('PM', 'م').replaceAll('AM', 'ص');
  //     }
  //   }
  // }
  String replacePmAm(String savedTime,bool isEnglishLang){
    if(int.parse(savedTime.split(":").first)>12){
      return  isEnglishLang?  "PM":'م';

    }else{
      return  isEnglishLang?  "AM":'ص';
    }
  }
}
