import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
        Column(
          children: [
            const Spacer(flex: 4),
            Image.asset('assets/images/cashati_logo.png'),
            const Spacer(flex: 4),
          ],
        ),
      ),
    );
  }
}
