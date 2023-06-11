import 'package:flutter/material.dart';
import 'package:temp/presentation/widgets/expenses_and_income_widgets/underline_text_button.dart';

class DataInsidePieChart extends StatelessWidget {
  const DataInsidePieChart(
      {Key? key,
      required this.totalExpenses,
      required this.valueNotifier,
      required this.onPressToHome,
      required this.header})
      : super(key: key);
  final num totalExpenses;
  final ValueNotifier<double> valueNotifier;
  final void Function() onPressToHome;
  final String header;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Spacer(),
          Expanded(
            flex: 4,
            child: Text(totalExpenses != 0 ? 'Total $header' : ' Empty Show',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle1),
          ),
          if (totalExpenses != 0)
            Expanded(
              flex: 5,
              child: ValueListenableBuilder(
                valueListenable: valueNotifier,
                builder: (_, double value, __) => Text(
                  '${value.toInt()}LE',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
            ),
          if (totalExpenses == 0)
            Expanded(
              child: Center(
                child: UnderLineTextButton(
                  padding: EdgeInsets.zero,
                  text: 'Back To Home',
                  onPressed: totalExpenses == 0 ? onPressToHome : () {},
                  textStyle: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            ),
          const Spacer()
        ],
      ),
    );
  }
}
