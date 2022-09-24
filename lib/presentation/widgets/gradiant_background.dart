import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../styles/colors.dart';

class GradiantBackground extends StatelessWidget {
  const GradiantBackground({
    Key? key,
    this.gradiantColor = const [AppColor.white, AppColor.primaryColor],
    this.child,
    this.decorationImage,
    this.stops = const [0.5, 0.8],
    this.begin = Alignment.topCenter,
    this.end = Alignment.bottomCenter,
  }) : super(key: key);

  final List<Color> gradiantColor;
  final Widget? child;
  final DecorationImage? decorationImage;
  final List<double> stops;
  final Alignment begin;
  final Alignment end;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      child: child,
      decoration: BoxDecoration(
        image: decorationImage,
        gradient: LinearGradient(
          begin: begin,
          end: end,
          stops: stops,
          colors: gradiantColor,
        ),
      ),
    );
  }
}
