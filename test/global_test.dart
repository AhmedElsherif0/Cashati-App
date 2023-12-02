import 'package:flutter_test/flutter_test.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:temp/constants/app_strings.dart';

void main() {
  String _changeCurrency(bool isLanguage, bool isEnglish, [bool isArabic = false]) {
    String selectedCurrency = AppStrings.chooseCurrency.tr();

    if (isLanguage) {
      selectedCurrency = isEnglish ? 'EGP' : 'USD';
    } else {
      selectedCurrency = isArabic ? 'المصرية' : 'الامريكية';
    }
    return selectedCurrency;
  }

  test('changeCurrency sets selectedCurrency correctly', () {
    // Initialize the variables and function dependencies.
    bool isLanguage = true;
    bool isEnglish = true;
    String expectedCurrency;

    expectedCurrency = 'EGP';
    expect(_changeCurrency(isLanguage, isEnglish), expectedCurrency);

    isEnglish = false;
    expectedCurrency = 'USD';
    expect(_changeCurrency(isLanguage, isEnglish), expectedCurrency);

    isLanguage = false;
    bool isArabic = true;
    expectedCurrency = 'المصرية';
    expect(_changeCurrency(isLanguage, isEnglish, isArabic), expectedCurrency);

    isArabic = false;
    expectedCurrency = 'الامريكية';
    expect(_changeCurrency(isLanguage, isEnglish, isArabic), expectedCurrency);
  });
  test('_currencySign returns the correct currency sign', () {
    // Create a mock translator object with a language code.
    final translator = MockTranslator();
    translator.activeLanguageCode = 'en';

    // Create an instance of the class that contains the _currencySign method.
    CurrencyService currencyService = CurrencyService(translator);

    // Test when selectedCurrency is 'EGP' and language is 'en'.
    currencyService.selectedCurrency = 'EGP';
    expect(currencyService._currencySign(), 'LE');

    // Test when selectedCurrency is 'USD' and language is 'en'.
    currencyService.selectedCurrency = 'USD';
    expect(currencyService._currencySign(), '\$');

    // Test when selectedCurrency is 'المصرية' and language is 'en'.
    translator.activeLanguageCode = 'ar';
    currencyService = CurrencyService(translator);
    currencyService.selectedCurrency = 'المصرية';
    expect(currencyService._currencySign(), 'جنية');

    // Test when selectedCurrency is 'الامريكية' and language is 'en'.
    currencyService.selectedCurrency = 'الامريكية';
    expect(currencyService._currencySign(), 'دولار');

    // Change the language to 'ar' and test when selectedCurrency is 'المصرية'.
    translator.activeLanguageCode = 'ar';
    currencyService.selectedCurrency = 'المصرية';
    expect(currencyService._currencySign(), 'جنية');

    // Test when selectedCurrency is 'الامريكية' and language is 'ar'.
    currencyService.selectedCurrency = 'الامريكية';
    expect(currencyService._currencySign(), 'دولار');
  });
}

abstract class Translator {
  late String activeLanguageCode;

  String translate(String key);
}

class MockTranslator implements Translator {
  late String activeLanguageCode;

  @override
  String translate(String key) {
    // Implement translation logic for your tests.
    return key;
  }
}

class CurrencyService {
  CurrencyService(this.translator);

  String selectedCurrency = AppStrings.chooseCurrency;
  final Translator translator;

  String _currencySign() {
    String curr = "LE";
    String curr1 = "جنية";

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
}
