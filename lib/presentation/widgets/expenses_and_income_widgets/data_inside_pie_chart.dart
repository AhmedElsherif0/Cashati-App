import 'package:flutter/material.dart';
import 'package:temp/presentation/widgets/expenses_and_income_widgets/underline_text_button.dart';

class DataInsidePieChart extends StatelessWidget {
  const DataInsidePieChart(
      {Key? key,
      required this.totalExpenses,
      required this.valueNotifier,
      required this.onPressToHome,
      required this.header,
      required this.maxExpenses})
      : super(key: key);
  final num totalExpenses;
  final num maxExpenses;
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
            child: Text(
                (maxExpenses.toInt() | totalExpenses.toInt() != 0)
                    ? 'Total $header'
                    : ' Empty Show',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle1),
          ),
          if (maxExpenses.toInt()  | totalExpenses.toInt()  != 0)
            Expanded(
              flex: 5,
              child: ValueListenableBuilder(
                valueListenable: valueNotifier,
                builder: (_, double value, __) => Text(
                  ' ${maxExpenses.toInt()}LE',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
            ),
          if (maxExpenses.toInt() | totalExpenses.toInt() == 0)
            Expanded(
              child: Center(
                child: UnderLineTextButton(
                  padding: EdgeInsets.zero,
                  text: 'Back To Home',
                  onPressed: (maxExpenses.toInt() | totalExpenses.toInt() == 0)
                      ? onPressToHome
                      : () {},
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
