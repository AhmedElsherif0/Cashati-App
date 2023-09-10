import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:temp/constants/app_strings.dart';

class PrivacyPolicyAndTermsWidget extends StatelessWidget {
  const PrivacyPolicyAndTermsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  RichText(
        maxLines: 3,
        text: TextSpan(
            text: AppStrings.byUsingApp.tr(),
            style: Theme.of(context).textTheme.bodySmall,
            children: [
          TextSpan(
              text: AppStrings.privacyPolicy.tr(),style: Theme.of(context).textTheme.bodySmall!.copyWith(decoration: TextDecoration.underline),
              recognizer: TapGestureRecognizer()..onTap = () {
                showDialog(context: context, builder: (context){
                  return AlertDialog(
                    content: Container(
                      height: 80.h,

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Text(AppStrings.privacyPolicy,style: Theme.of(context).textTheme.headlineMedium),
                      Expanded(child: SingleChildScrollView(child: Text(AppStrings.cashatiPrivacy))),
                        ],
                      ),
                    ),
                  );

                });
              }),
          TextSpan(text: AppStrings.and.tr(),style: Theme.of(context).textTheme.bodySmall,),

              TextSpan(
                  text: AppStrings.termsConditions.tr(),
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(decoration: TextDecoration.underline),
                  recognizer: TapGestureRecognizer()..onTap = () {
                    showDialog(context: context, builder: (context){
                      return AlertDialog(
                        content: Container(
                          height: 80.h,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(AppStrings.termsConditions,style: Theme.of(context).textTheme.headlineMedium),
                              Expanded(child: SingleChildScrollView(child: Text(AppStrings.cashatiTerms))),
                            ],
                          ),
                        ),
                      );
                    });
                  }),
        ]));
  }
}
