import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import 'package:temp/presentation/widgets/gradiant_background.dart';

import '../../../data/local/cache_helper.dart';
import '../../router/app_router_names.dart';

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
    return Scaffold(
      body: GradiantBackground(
        child: Center(
          child: Column(
            children: [
              const Spacer(flex: 3),
              Expanded(
                flex: 4,
                child: SizedBox(
                  width: 40.w,
                  child: SvgPicture.asset('assets/icons/cashati_logo.svg'),
                ),
              ),
              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }
}
