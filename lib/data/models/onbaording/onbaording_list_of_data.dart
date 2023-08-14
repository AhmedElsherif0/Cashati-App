import 'package:localize_and_translate/localize_and_translate.dart';

import '../../../constants/app_icons.dart';

class OnBoardingModel {
  final String image;
  final String description;
  final String buttonTitle;

  OnBoardingModel({
    required this.image,
    required this.description,
    required this.buttonTitle,
  });
}

class OnBoardingData {
  final List<OnBoardingModel> _myData = [
    OnBoardingModel(
      description: "All- in -one finance tracker",
      image: AppIcons.onBoarding1,
      buttonTitle: 'Next',
    ),
    OnBoardingModel(
        description: "Save your money and \n gain points.",
        image: AppIcons.onBoarding2,
        buttonTitle: 'Next'),
    OnBoardingModel(
        description: "Track and analysis your \n  daily expenses.",
        image: AppIcons.onBoarding3,
        buttonTitle: 'Start'),
  ];

  final List<String> _englishCurrency = [
    'EGP',
    'USD',
    /*   'EUR',
    'GBP',
    'SAR',
    'AED',
    'RUB',
    'JPY',
    'INR',
    'BRL',
    'KWD',
    'QAR',
    'SYP',
    'BTC'*/
  ];

  final List<String> _arabicCurrency = [
    'المصرية',
    'الامريكية',
    /* 'الاوربية',
    'الانجليزية',
    'السعودية',
    'الامارتية',
    'الروبية',
    'اليابانية',
    'الهندية',
    'البرازيلية',
    'الكوتية',
    'القطرية',
    'السورية',
    'البت كوين(BTC)'*/
  ];

  List<String> get getCurrency =>
      translator.activeLanguageCode == 'en' ? _englishCurrency : _arabicCurrency;

  List<OnBoardingModel> get getOnBoardingData => _myData;
}
