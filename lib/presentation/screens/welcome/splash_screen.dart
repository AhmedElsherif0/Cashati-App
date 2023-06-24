import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/data/models/notifications.dart';
import 'package:temp/notifications_api.dart';
import 'package:temp/presentation/widgets/gradiant_background.dart';

import '../../../constants/app_icons.dart';
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
    Timer(const Duration(seconds: 2), () {
      bool? onBoardingData =
          CacheHelper.getDataFromSharedPreference(key: 'OnBoardDone');
      bool? onWelcome = CacheHelper.getDataFromSharedPreference(key: 'onWelcome');
      debugPrint('onBoarding is = $onBoardingData');
      if (onBoardingData == null && onWelcome ==null) {
        Navigator.pushReplacementNamed(context, AppRouterNames.rWelcomeScreen);
      } else if (onBoardingData == null ) {
        Navigator.pushReplacementNamed(context, AppRouterNames.rOnBoardingRoute);
      } else {
        Navigator.pushReplacementNamed(context, AppRouterNames.rHomeRoute);
      }
    });
    _onClickNotify(context);
  }

  StreamSubscription _onClickNotify(context) =>
      NotificationsApi.streamController.stream.listen(
          (event) => Navigator.of(context).pushNamed(AppRouterNames.rNotification));

  @override
  void dispose() {
    _onClickNotify(context).cancel();
    super.dispose();
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
                      child: SvgPicture.asset(AppIcons.cashatiLogoSVG),
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
                                await notifyApi.showSpecificScheduledNotification(
                                  notifyModel: NotificationsModel(
                                      id: 2,
                                      title: 'saied',
                                      subTitle: 'income Result from notification',
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
                              await notifyApi.showDailyNotification(
                                  notifyModel: NotificationsModel(
                                      id: 1,
                                      title: 'Repeat',
                                      subTitle: 'Expense Result from notification',
                                      dateTime: DateTime.now(),
                                      payLoad: 'hello.0'));
                              print('hello');
                            },
                          ),
                        ),
                        Expanded(
                          child:
                              CustomElevatedButton(text: 'Remove', onPressed: () {}),
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
