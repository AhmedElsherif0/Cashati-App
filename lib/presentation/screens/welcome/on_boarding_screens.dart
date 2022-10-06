import 'dart:async';

import 'package:flutter/material.dart';
import 'package:temp/data/local/cache_helper.dart';
import 'package:temp/presentation/router/app_router_names.dart';
import 'package:temp/presentation/styles/colors.dart';
import 'package:temp/presentation/widgets/logo_name.dart';

import '../../../data/models/onbaording/onbaording_list_of_data.dart';

class OnBoardScreens extends StatefulWidget {
  const OnBoardScreens({Key? key}) : super(key: key);

  @override
  State<OnBoardScreens> createState() => _OnBoardScreensState();
}

class _OnBoardScreensState extends State<OnBoardScreens> {
  int _currentIndex = 0;
  final PageController _controller = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_currentIndex < 2) _currentIndex++;
      _controller.animateToPage(
        _currentIndex,
        duration: const Duration(seconds: 2),
        curve: Curves.easeIn,
      );
    });
  }

  final myData = OnBoardingData().myData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Directionality(
          textDirection: TextDirection.ltr,
          child: PageView.builder(
            controller: _controller,
            onPageChanged: (value) => setState(() => _currentIndex = value),
            itemCount: myData.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(30, 117, 20, 20),
                child: Column(
                  children: [
                    Image.asset(myData[index].img),
                    Row(
                      children: [
                        Text(
                          'Welcome to ',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: AppColor.pineGreen),
                        ),
                        const LogoName(),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Column(
                        children: [
                          Text(
                            myData[index].description,
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(fontSize: 20, height: 2),
                          ),
                          Text(
                            myData[index].extraDescription,
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(fontSize: 20, height: 2),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 100),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: SizedBox(
                              height: 56,
                              width: 320,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16)),
                                  backgroundColor: AppColor.primaryColor,
                                ),
                                onPressed: () {
                                  if (_currentIndex < 2) {
                                    _currentIndex++;
                                    _controller.animateToPage(
                                      _currentIndex,
                                      duration: const Duration(seconds: 1),
                                      curve: Curves.easeIn,
                                    );
                                  } else {
                                    navigateToHomeScreen(context);
                                  }
                                },
                                child: Text(
                                  myData[index].buttonTitle,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                          fontSize: 24, color: AppColor.white),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              myData.length,
                              (index) => Container(
                                margin: const EdgeInsets.only(right: 5),
                                height: 6,
                                width: _currentIndex == index ? 70 : 10,
                                decoration: BoxDecoration(
                                  color: _currentIndex == index
                                      ? AppColor.primaryColor
                                      : AppColor.grey,
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                        onPressed: () => navigateToHomeScreen(context),
                        child: const Text(
                          'skip',
                          style: TextStyle(color: AppColor.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
    );
  }

  void navigateToHomeScreen(context) {
    CacheHelper.saveDataSharedPreference(key: 'onBoardDone', value: true);
    Navigator.pushReplacementNamed(context, AppRouterNames.rHomeRoute);
  }
}
