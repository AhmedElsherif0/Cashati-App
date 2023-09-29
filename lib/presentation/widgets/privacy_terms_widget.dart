import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:temp/constants/app_strings.dart';
import 'package:temp/presentation/widgets/buttons/custom_text_button.dart';
import 'package:temp/presentation/widgets/show_dialog.dart';

class PrivacyPolicyAndTermsWidget extends StatelessWidget with AlertDialogMixin {
  const PrivacyPolicyAndTermsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return RichText(
        maxLines: 3,
        text: TextSpan(
            text: AppStrings.byUsingApp.tr(),
            style: textTheme.bodySmall,
            children: [
              TextSpan(
                  text: AppStrings.privacyPolicy.tr(),
                  style: textTheme.bodySmall!
                      .copyWith(decoration: TextDecoration.underline),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      showPrivacyAndTermsDialog(
                        context: context,
                        child: const UiPrivacyAndTermsDialog(
                          header: 'Privacy and Policy',
                          bodyTitle: AppStrings.cashatiPrivacy,
                        ),
                      );
                    }),
              TextSpan(text: ' ${AppStrings.and.tr()} ', style: textTheme.bodySmall),
              TextSpan(
                  text: AppStrings.termsConditions.tr(),
                  style: textTheme.bodySmall!
                      .copyWith(decoration: TextDecoration.underline),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      showPrivacyAndTermsDialog(
                        context: context,
                        child: const UiPrivacyAndTermsDialog(
                          header: 'Terms And Conditions',
                          bodyTitle: AppStrings.cashatiTerms,
                        ),
                      );
                    }),
            ]));
  }
}

class UiPrivacyAndTermsDialog extends StatelessWidget {
  const UiPrivacyAndTermsDialog(
      {super.key, required this.header, required this.bodyTitle});

  final String header;
  final String bodyTitle;

  Widget customButton(context, text, isEnglish) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: CustomTextButton(
            text: text,
            onPressed: Navigator.of(context).pop,
            alignment: isEnglish ? Alignment.centerLeft : Alignment.centerRight),
      );

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isEnglish = translator.activeLanguageCode == 'en';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 2.h),
                Text(header, style: textTheme.headlineMedium),
              ],
            ),
          ),
        ),
        SizedBox(height: 2.h),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SingleChildScrollView(
              child: Text(bodyTitle, style: textTheme.bodySmall),
            ),
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          customButton(context, 'Cancel', isEnglish),
          customButton(context, 'Agree', !isEnglish),
        ]),
      ],
    );
  }
}
