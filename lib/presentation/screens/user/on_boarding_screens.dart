import 'dart:async';

import 'package:flutter/material.dart';
import 'package:temp/data/color_converter/hex_colors.dart';
import 'package:temp/data/local/cache_helper.dart';
import 'package:temp/presentation/router/app_router.dart';
import 'package:temp/presentation/router/app_router_names.dart';
import 'package:temp/presentation/styles/colors.dart';
import 'package:temp/presentation/styles/themes.dart';

class Data {
  final String img;
  final String description;
  final String extraDescription;
  final String buttonTitle;

  Data({
    required this.extraDescription,
    required this.img,
    required this.description,
    required this.buttonTitle,
  });
}

class OnBoardScreens extends StatefulWidget {
  const OnBoardScreens({Key? key}) : super(key: key);

  @override
  State<OnBoardScreens> createState() => _OnBoardScreensState();
}

class _OnBoardScreensState extends State<OnBoardScreens> {
  int _currentIndex = 0;
  final PageController _controller = PageController(
    initialPage: 0,
  );

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

  List<Data> myData = [
    Data(
        description: "All- in -one finance tracker",
        img: 'assets/on_boarding/onboarding_1.png',
        buttonTitle: 'Next',
        extraDescription: ''),
    Data(
        description: "Save your money and",
        img: 'assets/on_boarding/onboarding_2.png',
        buttonTitle: 'Next',
        extraDescription: 'gain points.'),
    Data(
        description: "Track and analysis your",
        img: 'assets/on_boarding/onboarding_3.png',
        buttonTitle: 'Start',
        extraDescription: 'daily expenses.'),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: Scaffold(
        body: Directionality(
          textDirection: TextDirection.ltr,
          child: PageView.builder(
            controller: _controller,
            onPageChanged: (value) {
             setState(() {
               _currentIndex = value;
             });
            },
            itemCount: myData.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(30, 117, 20, 20),
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(myData[index].img),
                    Row(
                      children: [
                        Text(
                          'Welcome to ',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: HexColor('#3C5A40')),
                        ),
                        Text(
                          'CA',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: HexColor('#000000')),
                        ),
                        Text(
                          '\$',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: HexColor('#3C5A40')),
                        ),
                        Text(
                          'HATI',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: HexColor('#000000')),
                        ),
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
                      padding: const EdgeInsets.only(bottom: 190),
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
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    backgroundColor: HexColor('#80BF88')),
                                onPressed: () {
                                  if (_currentIndex < 2) {
                                    _currentIndex++;
                                    _controller.animateToPage(
                                      _currentIndex,
                                      duration: const Duration(seconds: 1),
                                      curve: Curves.easeIn,
                                    );
                                  } else {

                                    CacheHelper.saveDataSharedPreference(
                                        key: 'onBoardDone', value: true);
                                    Navigator.of(context).pushReplacementNamed(AppRouterNames.rHomeRoute);

                                  }
                                },
                                child: Text(
                                  myData[index].buttonTitle,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                          fontSize: 24, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                myData.length,
                                (index) => Container(
                                  margin: EdgeInsets.only(right: 5),
                                  height: 6,
                                  width: _currentIndex == index ? 70 : 10,
                                  decoration: BoxDecoration(
                                    color:_currentIndex == index ? HexColor('80BF88'):AppColor.grey,
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 250),
                      child: TextButton(
                          onPressed: () {
                            CacheHelper.saveDataSharedPreference(
                                key: 'onBoardDone', value: true);
                            Navigator.of(context).pushReplacementNamed(AppRouterNames.rHomeRoute);
                          },
                          child: Text(
                            'skip',
                            style: TextStyle(color: HexColor('#9C9C9C')),
                          )),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

