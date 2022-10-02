import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../views/tab_bar_view.dart';
import '../../widgets/circle_progress_bar_chart.dart';
import '../../widgets/drop_down_button.dart';

class ExpensesScreen extends StatelessWidget {
  const ExpensesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Column(
            children: [
              Text('Daily expenses', style: textTheme.headline2),
              const DefaultDropDownButton(
                defaultText: 'Choose day',
                items: ['Day 1', 'Day 2', 'Day 3', 'Day 4', 'Day 5'],
              ),
              Spacer(),
              const Expanded(
                flex: 12,
                child: CircularProgressBarChart(
                  maxValue: 10000,
                ),
              ),
              Expanded(
                flex: 24,
                child: CustomTabBarView(
                  currentIndex: 0,
                  onTapTabBar: (value) {},
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
