import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:temp/business_logic/cubit/global_cubit/global_cubit.dart';
import 'package:temp/constants/end_points.dart';
import 'package:temp/notifications_api.dart';
import 'package:temp/presentation/widgets/gradiant_background.dart';

import '../../../constants/app_icons.dart';
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
    _onClickNotify(context);
    Timer(const Duration(seconds: 2), () {
      bool? onBoardingData =
          CacheHelper.getDataFromSharedPreference(key: 'OnBoardDone');
      bool? onWelcome = CacheHelper.getDataFromSharedPreference(key: 'onWelcome');
      isCurrency();
      debugPrint('onBoarding is = $onBoardingData');
      _whichScreenToNavigate(onBoardingData: onBoardingData, onWelcome: onWelcome);
    });
  }

  void isCurrency() {
    final currencyKey = CacheHelper.getDataFromSharedPreference(key: appCurrencyKey);
    debugPrint('currencyKey is = $currencyKey');
    if (currencyKey != null) context.read<GlobalCubit>().onChangeCurrency(currencyKey);
  }

  void _whichScreenToNavigate({onBoardingData, onWelcome}) {
    if (onBoardingData == null && onWelcome == null) {
      Navigator.pushReplacementNamed(context, AppRouterNames.rWelcomeScreen);
    } else if (onBoardingData == null) {
      Navigator.pushReplacementNamed(context, AppRouterNames.rOnBoardingRoute);
    } else {
      Navigator.pushReplacementNamed(context, AppRouterNames.rHomeRoute);
    }
  }

  StreamSubscription _onClickNotify(BuildContext context) =>
      NotificationsApi.streamController.stream.listen(
          (event) => Navigator.of(context).pushNamed(AppRouterNames.rNotification));

  @override
  void dispose() {
    _onClickNotify(context).cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
