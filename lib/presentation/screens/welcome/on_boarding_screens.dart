import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../../constants/app_strings.dart';
import '../../../data/local/cache_helper.dart';
import '../../../data/models/onbaording/onbaording_list_of_data.dart';
import '../../../data/repository/helper_class.dart';
import '../../router/app_router_names.dart';
import '../../styles/colors.dart';
import '../../widgets/buttons/elevated_button.dart';
import '../../widgets/common_texts/logo_name.dart';

class OnBoardScreens extends StatefulWidget {
  const OnBoardScreens({Key? key}) : super(key: key);

  @override
  State<OnBoardScreens> createState() => _OnBoardScreensState();
}

class _OnBoardScreensState extends State<OnBoardScreens> with HelperClass {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;

  final myData = OnBoardingData().getOnBoardingData;

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentIndex < 2) _currentIndex++;
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentIndex,
          duration: const Duration(seconds: 1),
          curve: Curves.easeIn,
        );
      }
    });
  }

  void onNext(context) {
    if (_currentIndex < 2) {
      _currentIndex++;
      _pageController.animateToPage(_currentIndex,
          duration: const Duration(seconds: 1), curve: Curves.easeIn);
    } else {
      onStart(context);
    }
  }

  void onStart(context) async {
    await CacheHelper.saveDataSharedPreference(key: 'OnBoardDone', value: true);
    Navigator.pushReplacementNamed(context, AppRouterNames.rHomeRoute);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _mobileOnBoardingScreen(context);
  }

  _mobileOnBoardingScreen(context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (value) => setState(() => _currentIndex = value),
        itemCount: myData.length,
        itemBuilder: (context, index) {
          return Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.dp),
              child: Column(
                children: [
                  const Spacer(),
                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                        onPressed: () => onStart(context),
                        child: Text(AppStrings.skip.tr(),
                            style: textTheme.bodyText2?.copyWith(letterSpacing: 2)),
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 5,
                      child: Image.asset(myData[index].image, fit: BoxFit.contain)),
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        Row(
                          //textDirection: TextDirection.RTL,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(AppStrings.welcomeTo.tr(),
                                style: textTheme.headline3),
                            SizedBox(width: 2.w),
                            const LogoName(),
                          ],
                        ),
                        Text('${AppStrings.onBoardingDesc}$index'.tr(),
                            style: textTheme.subtitle2, textAlign: TextAlign.center)
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            myData.length,
                            (index) => Container(
                              margin: EdgeInsets.only(right: 4.dp),
                              height: 1.2.h,
                              width: _currentIndex == index ? 12.w : 3.w,
                              decoration: BoxDecoration(
                                color: _currentIndex == index
                                    ? AppColor.primaryColor
                                    : AppColor.grey,
                                borderRadius: BorderRadius.circular(20.0.dp),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 3.h),
                        CustomElevatedButton(
                          onPressed: () => onNext(context),
                          text: '${AppStrings.onBoardingButton}$index'.tr(),
                          borderRadius: 6.dp,
                          width: 80.w,
                          height: 6.h,
                        ),
                      ],
                    ),
                  ),
                  const Spacer()
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _tabletOnBoardingScreen(context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: PageView.builder(
          controller: _pageController,
          onPageChanged: (value) => setState(() => _currentIndex = value),
          itemCount: myData.length,
          itemBuilder: (context, index) {
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.dp),
                child: Column(
                  children: [
                    const Spacer(),
                    Expanded(
                      flex: 2,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: TextButton(
                          onPressed: () => onStart(context),
                          child: Text(AppStrings.skip.tr(),
                              style: textTheme.bodyText2?.copyWith(letterSpacing: 2)),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child:
                                Image.asset(myData[index].image, fit: BoxFit.contain),
                          ),
                          Expanded(
                            flex: 3,
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Welcome to ', style: textTheme.headline3),
                                      const LogoName(),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    myData[index].description,
                                    style: textTheme.subtitle2,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              myData.length,
                              (index) => Container(
                                margin: EdgeInsets.only(right: 4.dp),
                                height: 1.2.h,
                                width: _currentIndex == index ? 12.w : 3.w,
                                decoration: BoxDecoration(
                                  color: _currentIndex == index
                                      ? AppColor.primaryColor
                                      : AppColor.grey,
                                  borderRadius: BorderRadius.circular(20.0.dp),
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          CustomElevatedButton(
                            onPressed: () => onStart(context),
                            text: myData[index].buttonTitle,
                            borderRadius: 5.5.dp,
                            width: 80.w,
                            height: 8.h,
                          ),
                        ],
                      ),
                    ),
                    const Spacer()
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
