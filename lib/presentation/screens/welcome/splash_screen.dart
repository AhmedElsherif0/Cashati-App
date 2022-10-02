import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:temp/presentation/widgets/gradiant_background.dart';

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

    /*Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacementNamed(
        context,
        AppRouterNames.rOnBoardingRoute,
      ),
    );*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradiantBackground(
        child: Center(
          child: Column(
            children: [
              const Spacer(flex: 4),
              Image.asset('assets/images/Cashati_Logo.png'),
              const Spacer(flex: 4),
            ],
          ),
        ),
      ),
    );
  }
}
