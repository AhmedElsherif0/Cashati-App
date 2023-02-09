import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/data/models/notifications.dart';
import 'package:temp/notificationsApi.dart';
import 'package:temp/presentation/screens/home/nav_bottom_screens/home_screen.dart';

import 'package:temp/presentation/widgets/gradiant_background.dart';

import '../../../data/local/cache_helper.dart';
import '../../router/app_router_names.dart';
import '../../widgets/buttons/elevated_button.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
     Timer(const Duration(microseconds: 3), () {
      bool? onBoardingData =
          CacheHelper.getDataFromSharedPreference(key: 'onBoardDone');
      debugPrint('onBoarding is = $onBoardingData');
      if (onBoardingData == null) {
        Navigator.pushReplacementNamed(
            context, AppRouterNames.rOnBoardingRoute);
      } else {
        Navigator.pushReplacementNamed(context, AppRouterNames.rHomeRoute);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final notifyApi = NotificationsApi();
    return Scaffold(
      body: GradiantBackground(
        child: Center(
          child: Column(
            children: [
              const Spacer(flex: 2),
              Expanded(
                flex: 4,
                child: Column(children: [
                  Expanded(
                    flex: 4,
                    child: SizedBox(
                      width: 40.w,
                      child: SvgPicture.asset('assets/icons/cashati_logo.svg'),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Expanded(
                          child: CustomElevatedButton(
                              text: 'simple',
                              onPressed: () async {
                                print('hello');
                                await notifyApi.showNotification(
                                  notifyModel: NotificationsModel(
                                      id: 0,
                                      title: 'ahmed',
                                      subTitle: 'welcome everybody',
                                      dateTime: DateTime.now(),
                                      payLoad: 'hello.0'),
                                );
                              }),
                        ),
                        Expanded(
                          child: CustomElevatedButton(
                              text: 'specific',
                              onPressed: () async {
                                /// here we can add specific time
                                await notifyApi
                                    .showSpecificScheduledNotification(
                                  notifyModel: NotificationsModel(
                                      id: 2,
                                      title: 'saied',
                                      subTitle:
                                          'income Result from notification',
                                      dateTime: DateTime.now().add(
                                        Duration(seconds: 10),
                                      ),
                                      payLoad: 'hello.0'),
                                );
                              }),
                        ),
                        Expanded(
                            child: CustomElevatedButton(
                                text: 'Repeat',
                                onPressed: () async {
                                  print('schedule');
                                  await notifyApi.showRepeatScheduledNotification(
                                      notifyModel: NotificationsModel(
                                          id: 1,
                                          title: 'ashraf',
                                          subTitle:
                                              'Expense Result from notification',
                                          dateTime: DateTime.now()
                                              .add(const Duration(seconds: 10)),
                                          payLoad: 'hello.0'));
                                  print('hello');
                                })),
                        Expanded(
                          child: CustomElevatedButton(
                              text: 'Remove', onPressed: () {}),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
