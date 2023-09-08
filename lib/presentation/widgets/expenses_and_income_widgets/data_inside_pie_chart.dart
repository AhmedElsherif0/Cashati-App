import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:temp/presentation/styles/colors.dart';
import 'package:temp/presentation/widgets/buttons/underline_text_button.dart';

import '../../../constants/app_strings.dart';
import '../../../data/repository/formats_mixin.dart';

class DataInsidePieChart extends StatelessWidget with FormatsMixin {
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
            flex: 5,
            child: Text(
                (maxExpenses.toInt() | totalExpenses.toInt() != 0)
                    ? '${AppStrings.total.tr()} ${header.tr()}'
                    : AppStrings.emptyShow.tr(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle1),
          ),
          if (maxExpenses.toInt()  | totalExpenses.toInt()  != 0)
            Expanded(
              flex: 6,
              child: ValueListenableBuilder(
                valueListenable: valueNotifier,
                builder: (_, double value, __) => Text(
                  ' ${currencyFormat(context,maxExpenses.toInt())}',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
            ),
          if (maxExpenses.toInt() | totalExpenses.toInt() == 0)
            Expanded(
              flex: 2,
              child: UnderLineTextButton(
                borderLineColor: AppColor.pineGreen,
                padding: translator.activeLanguageCode == 'ar' ? EdgeInsets.zero:null,
                text: AppStrings.backToHome.tr(),
                onPressed: (maxExpenses.toInt() | totalExpenses.toInt() == 0)
                    ? onPressToHome
                    : () {},
              ),
            ),
          const Spacer()
        ],
      ),
    );
  }
}
