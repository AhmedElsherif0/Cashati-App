import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:temp/constants/app_strings.dart';

import 'custom_text_button.dart';

class CancelConfirmTextButton extends StatelessWidget {
  const CancelConfirmTextButton(
      {Key? key, required this.onCancel, required this.onConfirm})
      : super(key: key);

  final void Function() onCancel;
  final void Function() onConfirm;

  @override
  Widget build(BuildContext context) {
    final isEnglish = translator.activeLanguageCode == 'en';
    return Row(
      textDirection: isEnglish ? TextDirection.rtl:TextDirection.ltr,
      children: [
       if(isEnglish) const Spacer(),
        Expanded(
          flex: 8,
          child: CustomTextButton(
              isVisible: false,
              onPressed: onCancel,
              text: AppStrings.cancel.tr(),
              alignment: isEnglish? Alignment.bottomRight: Alignment.bottomLeft),
        ),
        const Spacer(flex: 4),
        Expanded(
          flex: isEnglish ?  7:5,
          child: CustomTextButton(
              onPressed: onConfirm, text: AppStrings.confirm.tr(), isVisible: false),
        ),
      ],
    );
  }
}
