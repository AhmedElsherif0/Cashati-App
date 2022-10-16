import 'package:flutter/material.dart';

import '../../data/models/expenses/expenses_lists.dart';
import '../widgets/expenses_and_income_widgets/radio_button_list_tile.dart';

class ImportanceRadioButton extends StatelessWidget {
  const ImportanceRadioButton({
    Key? key,
    required this.onChange,
    required this.groupValue, required this.firstRadio, required this.secondRadio,
  }) : super(key: key);

  final void Function(Importance?) onChange;
  final Importance groupValue;
  final String firstRadio;
  final String secondRadio;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Spacer(),
        RadioButtonListTile(
            text: firstRadio,
            value: Importance.importantExpense,
            groupValue: groupValue,
            onChanged: onChange),
        const Spacer(flex: 3),
        RadioButtonListTile(
          text: secondRadio,
          value: Importance.notImportantExpense,
          groupValue: groupValue,
          onChanged: onChange,
        ),
        const Spacer(),
      ],
    );
  }
}
