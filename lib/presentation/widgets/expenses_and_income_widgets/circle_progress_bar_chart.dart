import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/presentation/styles/colors.dart';
import 'package:temp/presentation/widgets/expenses_and_income_widgets/data_inside_pie_chart.dart';

class CircularProgressBarChart extends StatefulWidget {
  const CircularProgressBarChart({
    Key? key,
    required this.maxExpenses,
    required this.totalExpenses,
    required this.onPressToHome,
    required this.header,
  }) : super(key: key);

  final double maxExpenses;
  final void Function() onPressToHome;
  final double totalExpenses;
  final String header;

  @override
  State<CircularProgressBarChart> createState() =>
      _CircularProgressBarChartState();
}

class _CircularProgressBarChartState extends State<CircularProgressBarChart> {
  final ValueNotifier<double> _valueNotifier = ValueNotifier<double>(0);

  @override
  Widget build(BuildContext context) {
    List list = [];
    return SingleChildScrollView(
      child: Center(
        child: DashedCircularProgressBar.aspectRatio(
          aspectRatio: 1.95,
          startAngle: -80,
          backgroundStrokeWidth: 10.sp,
          foregroundStrokeWidth: 10.sp,
          animationDuration: const Duration(seconds: 3),
          animation: true,
          ltr: false,
          backgroundColor: AppColor.pinkishGrey,
          foregroundColor: AppColor.secondColor,
          animationCurve: Curves.decelerate,
          circleCenterAlignment: Alignment.center,
          progress: widget.totalExpenses,
          maxProgress: widget.maxExpenses,
          valueNotifier: _valueNotifier,
          child: Center(
            child: SizedBox(
              height: 15.h,
              child: DataInsidePieChart(
                header: widget.header,
                valueNotifier: _valueNotifier,
              totalExpenses: widget.totalExpenses,
              onPressToHome: widget.onPressToHome),
            ),
          ),
          ),
        ),
    );
  }
}
