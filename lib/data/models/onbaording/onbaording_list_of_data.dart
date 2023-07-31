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
  final List<String> _currency = [
    'EGP',
    'USD',
    'EUR',
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
    'BTC'
  ];

  List<String> get getCurrency => _currency;

  List<OnBoardingModel> get getOnBoardingData => _myData;
}
