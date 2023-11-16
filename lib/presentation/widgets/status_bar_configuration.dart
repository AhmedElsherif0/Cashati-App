import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

mixin ConfigurationStatusBar {
  void statusBarConfig() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark),
    );
  }

  void setOrientationPortraitUP() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }
}
