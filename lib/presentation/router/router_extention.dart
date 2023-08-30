import 'package:flutter/material.dart';

extension NavigatorExtensions on BuildContext {
  Future<T?> push<T>(Widget pageRoute) =>
      _navigator.push<T>(MaterialPageRoute(builder: (context) => pageRoute));

  NavigatorState get _navigator => Navigator.of(this);

  void pop<T>([T? result]) => _navigator.pop(result);
}
