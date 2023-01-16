import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../styles/colors.dart';

class GradiantBackground extends StatelessWidget {
  const GradiantBackground({
    Key? key,
    this.gradiantColor =  AppColor.defaultLinearGradient,
    this.child,
    this.decorationImage,
    this.stops = const [0.0,0.2,0.8,0.95],
    this.begin = Alignment.topRight,
    this.end = Alignment.bottomLeft,
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
      decoration: BoxDecoration(
        image: decorationImage,
        gradient: LinearGradient(
          begin: begin,
          end: end,
          stops: stops,
          colors: gradiantColor,
        ),
      ),
      child: child,
    );
  }
}
