import '../../../constants/app_icons.dart';
import 'onboarding_data.dart';

class OnBoardingData {
  final List<OnBoardingModel> _myData = [
    OnBoardingModel(
      description: "All- in -one finance tracker \n gain points.",
      image: AppIcons.onBoarding1,
      buttonTitle: 'Next',
    ),
    OnBoardingModel(
        description: "Save your money and \n daily expenses.",
        image: AppIcons.onBoarding2,
        buttonTitle: 'Next'),
    OnBoardingModel(
        description: "Track and analysis your",
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
