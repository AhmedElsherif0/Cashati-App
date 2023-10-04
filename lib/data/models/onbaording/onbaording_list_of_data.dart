import 'package:temp/constants/app_images.dart';

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
        image: AppImages.onBoarding1,
        buttonTitle: 'Next'),
    OnBoardingModel(
        description: "Save your money and \n gain points.",
        image: AppImages.onBoarding2,
        buttonTitle: 'Next'),
    OnBoardingModel(
        description: "Track and analysis your \n  daily expenses.",
        image: AppImages.onBoarding3,
        buttonTitle: 'Start'),
  ];

  final List<String> englishCurrency = ['EGP', 'USD'];

  final List<String> arabicCurrency = ['الامريكية', 'المصرية'];

  List<OnBoardingModel> get getOnBoardingData => _myData;
}
