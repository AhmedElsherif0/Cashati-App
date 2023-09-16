import 'package:flutter/material.dart';

import '../router/app_router.dart';

extension NavigatorExtensions on BuildContext {
  NavigatorState get _navigator => Navigator.of(this);

  Future navigateTo(Widget screen) async =>
      await _navigator.push(AppRouter.pageBuilderRoute(child: screen));

  void pops<T>([T? result]) => _navigator.pop(result);
}

extension StringExtentions on String {
  double toDouble() => double.parse(this);

  num? toNum() => num.tryParse(this);
}
