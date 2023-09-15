import 'package:flutter/material.dart';

extension NavigatorExtensions on BuildContext {
  Future<T?> navigateTo<T>(Widget pageRoute) =>
      _navigator.push<T>(MaterialPageRoute(builder: (_) => pageRoute));

  NavigatorState get _navigator => Navigator.of(this);

  void pops<T>([T? result]) => _navigator.pop(result);
}

extension StringExtentions on String {
  double toDouble() => double.parse(this);
  num? toNum() => num.tryParse(this);
}
