import 'package:flutter/material.dart';

import '../../data/models/expenses/expenses_lists.dart';
import '../widgets/radio_button_list_tile.dart';

class ImportanceRadioButton extends StatelessWidget {
  const ImportanceRadioButton({
    Key? key,
    required this.onChange,
    required this.groupValue,
  }) : super(key: key);

  final void Function(Importance?) onChange;
  final Importance groupValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Spacer(),
        RadioButtonListTile(
            text: 'Important Expense',
            value: Importance.importantExpense,
            groupValue: groupValue,
            onChanged: onChange),
        const Spacer(flex: 3),
        RadioButtonListTile(
          text: 'Not Important Expense',
          value: Importance.notImportantExpense,
          groupValue: groupValue,
          onChanged: onChange,
        ),
        const Spacer(),
      ],
    );
  }
}
