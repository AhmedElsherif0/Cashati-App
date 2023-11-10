import 'package:flutter/material.dart';

import '../data/local/cache_helper.dart';
import 'end_points.dart';

enum LanguageType { english, arabic }

const String arabic = "ar";
const String english = "en";
const String localizationPath = "assets/i18n";

const Locale arabicLocal = Locale('ar');
const Locale englishLocal = Locale('en');

extension LanguageTypeExtension on LanguageType {
  String getValue() {
    switch (this) {
      case LanguageType.english:
        return english;
      case LanguageType.arabic:
        return arabic;
    }
  }
}

class LanguageManager {
  Future<void> changeAppLanguage() async {
    String currentLang = await _getAppLanguage();
    CacheHelper.saveDataSharedPreference(
        key: appLanguageSharedKey, value: currentLang == arabic ? english : arabic);
  }

  Future<Locale> getLocal() async {
    String currentLang = await _getAppLanguage();
    return currentLang == LanguageType.arabic.getValue() ? arabicLocal : englishLocal;
  }

  Future<String> _getAppLanguage() async {
    String? language =
        CacheHelper.getDataFromSharedPreference(key: appLanguageSharedKey);
    return language != null && language.isNotEmpty
        ? language
        : LanguageType.english.getValue();
  }
}
