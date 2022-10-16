import 'package:flutter/material.dart';

import 'custom_text_button.dart';

class CancelConfirmTextButton extends StatelessWidget {
  const CancelConfirmTextButton(
      {Key? key, required this.onCancel, required this.onConfirm})
      : super(key: key);

  final void Function() onCancel;
  final void Function() onConfirm;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        Expanded(
          flex: 8,
          child: CustomTextButton(
              isVisible: false,
              onPressed: onCancel,
              text: 'Cancel',
              alignment: Alignment.bottomLeft),
        ),
        const Spacer(flex: 4),
        Expanded(
          flex: 5,
          child: CustomTextButton(
              onPressed: onConfirm, text: 'Confirm', isVisible: false),
        ),
      ],
    );
  }
}
