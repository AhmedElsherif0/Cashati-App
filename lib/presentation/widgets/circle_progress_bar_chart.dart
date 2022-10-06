import 'package:flutter/material.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/presentation/styles/colors.dart';

class CircularProgressBarChart extends StatefulWidget {
  const CircularProgressBarChart({
    Key? key,
    required this.maxExpenses,
    required this.totalExpenses,
  }) : super(key: key);

  final double maxExpenses;
  final ValueNotifier<double> totalExpenses;

  @override
  State<CircularProgressBarChart> createState() =>
      _CircularProgressBarChartState();
}

class _CircularProgressBarChartState extends State<CircularProgressBarChart> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: SimpleCircularProgressBar(
          size: 43.w,
          maxValue: widget.maxExpenses,
          backStrokeWidth: 12.sp,
          progressStrokeWidth: 12.sp,
          valueNotifier: widget.totalExpenses,
          backColor: AppColor.grey,
          progressColors: const [AppColor.secondColor],
          animationDuration: 3,
          onGetText: (totalExpenses) {
            final text = widget.totalExpenses.value != 0.0
                ? 'Total Expenses \n ${totalExpenses.toStringAsFixed(2)}LE'
                : 'No Data To Show \n';
            return Text(text,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.copyWith(color: AppColor.pineGreen));
          },
        ),
      ),
    );
  }
}
