import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/presentation/styles/colors.dart';
import 'package:temp/presentation/widgets/underline_text_button.dart';

class CircularProgressBarChart extends StatefulWidget {
  const CircularProgressBarChart({
    Key? key,
    required this.maxExpenses,
    required this.totalExpenses,
    required this.onPressToHome,
  }) : super(key: key);

  final double maxExpenses;
  final void Function() onPressToHome;
  final double totalExpenses;

  @override
  State<CircularProgressBarChart> createState() =>
      _CircularProgressBarChartState();
}

class _CircularProgressBarChartState extends State<CircularProgressBarChart> {
  final ValueNotifier<double> _valueNotifier = ValueNotifier<double>(0);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: DashedCircularProgressBar.aspectRatio(
          aspectRatio: 1.95,
          backgroundColor: AppColor.pinkishGrey,
          foregroundColor: AppColor.secondColor,
          animationCurve: Curves.decelerate,
          animationDuration: const Duration(seconds: 5),
          animation: true,
          backgroundStrokeWidth: 10.sp,
          foregroundStrokeWidth: 10.sp,
          circleCenterAlignment: Alignment.center,
          corners: StrokeCap.butt,
          startAngle: -80,
          ltr: false,
          progress: widget.totalExpenses,
          maxProgress: widget.maxExpenses,
          valueNotifier: _valueNotifier,
          child: Center(
            child: Column(
              children: [
                const Spacer(flex: 5),
                Text(
                    widget.totalExpenses != 0.0
                        ? 'Total Expenses'
                        : 'No Data To Show',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle1),
                if (widget.totalExpenses != 0)
                  ValueListenableBuilder(
                    valueListenable: _valueNotifier,
                    builder: (_, double value, __) => Text(
                      '${value.toInt()} LE',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                if (widget.totalExpenses == 0)
                  UnderLineTextButton(
                      text: 'Back To Home',
                      onPressed: widget.onPressToHome,
                      textStyle: const TextStyle(fontWeight: FontWeight.w500)),
                const Spacer(flex: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
