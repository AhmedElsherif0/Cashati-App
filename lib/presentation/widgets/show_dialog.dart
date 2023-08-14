import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/svg.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:temp/constants/app_strings.dart';
import 'package:temp/presentation/widgets/buttons/elevated_button.dart';
import 'package:temp/presentation/widgets/setting_choosen_component.dart';
import '../../constants/app_icons.dart';
import '../styles/colors.dart';
import 'custom_painter_dialog.dart';
import 'buttons/custom_text_button.dart';

mixin AlertDialogMixin {
  AlertDialog newAmountDialog(
      {required double amount,
      required Function onUpdate,
      required BuildContext context,
      required TextEditingController changedAmountCtrl}) {
    return AlertDialog(
      title: const Text(AppStrings.updatePaidAmount),
      content: TextFormField(
        keyboardType: TextInputType.number,
        controller: changedAmountCtrl,
        decoration:
            InputDecoration(hintText: "$amount", labelText: AppStrings.paidAmount),
      ),
      actions: [
        CustomElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            text: AppStrings.cancel.tr()),
        CustomElevatedButton(
            onPressed: () {
              onUpdate();
              Navigator.of(context).pop();
            },
            text: AppStrings.update.tr()),
      ],
    );
  }

  AlertDialog showYesOrNoDialog(
      {required String title,
      required String message,
      required Function onYes,
      required Function onNo,
      required BuildContext context}) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        CustomElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              onYes();
            },
            text: AppStrings.yes.tr()),
        CustomElevatedButton(
            onPressed: () {
              onNo();
              Navigator.of(context).pop();
            },
            text: AppStrings.no.tr()),
      ],
    );
  }

  void showSuccessfulDialog(BuildContext context, String title, String message) {
    bool isEnglish = translator.activeLanguageCode == 'en';
    _customAlertDialog(
      context: context,
      title: title,
      actionButton: [
        DecoratedBox(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.dp)),
          child: SizedBox(
            height: 40.h,
            width: 80.w,
            child: Center(
              child: Column(
                children: [
                  Expanded(
                    flex: 4,
                    child: SvgPicture.asset('assets/icons/successfully_added.svg'),
                  ),
                  const Spacer(flex: 3),
                  Expanded(
                    flex: 4,
                    child: Wrap(
                      children: [
                        Text(message, style: Theme.of(context).textTheme.headline4)
                      ],
                    ),
                  ),
                  CustomTextButton(
                    alignment:
                        isEnglish ? Alignment.bottomRight : Alignment.bottomLeft,
                    icon: Icons.arrow_back_ios,
                    onPressed: () => Navigator.of(context).pop(),
                    text: AppStrings.back,
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  void showSettingDialog(
      {required BuildContext context, required String title, required Widget child}) {
    _customAlertDialog(context: context, title: title, actionButton: [
      DecoratedBox(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.dp)),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 1200),
          curve: Curves.easeInToLinear,
          height: 50.h,
          width: 70.w,
          child: Center(child: child),
        ),
      )
    ]);
  }

  void showSuccessfulDialogNoOptions(
      BuildContext context, String title, String message) {
    _customAlertDialog(
      context: context,
      title: title,
      actionButton: [
        DecoratedBox(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.dp)),
          child: AnimatedContainer(
            //  transform: Matrix4.rotationY(30),
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInToLinear,
            height: 30.h,
            width: 70.w,
            child: Center(
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: SvgPicture.asset('assets/icons/successfully_added.svg'),
                  ),
                  const Spacer(flex: 2),
                  Expanded(
                    flex: 3,
                    child: Wrap(
                      children: [
                        Text(message, style: Theme.of(context).textTheme.headline4)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  void showLoadingDialog(BuildContext context) {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return Center(
            child: Container(
              color: Colors.white,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppStrings.loading,
                        style: Theme.of(context)
                            .textTheme
                            .headline3
                            ?.copyWith(letterSpacing: 3)),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(AppStrings.back),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void showLogoutDialog(String title, BuildContext context, String message,
      {required void Function() onPressed}) {
    _customAlertDialog(
      context: context,
      title: title,
      actionButton: [
        Wrap(children: [
          Text(
            message,
            style: const TextStyle(
                fontWeight: FontWeight.w500, color: AppColor.primaryColor),
          )
        ]),
        Row(
          children: [
            CustomTextButton(
              onPressed: () => Navigator.of(context).pop(false),
              text: AppStrings.notYet,
            ),
            CustomTextButton(
              onPressed: onPressed,
              text: AppStrings.sure,
            )
          ],
        )
      ],
    );
  }

  /// Goals Dialog ely taaalaaaa3 3eeein omy.
  Future<void> showGoalsDialog(
      {required BuildContext context,
      required Function onPressedYesFunction,
      required Function onPressedNoFunction,
      required String infoMessage}) async {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 600),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          final size = MediaQuery.of(context).size;
          final textTheme = Theme.of(context).textTheme;
          return Center(
            child: SizedBox(
              height: 40.h,
              width: 90.w,
              child: CustomPaint(
                size: Size(size.width, size.height),
                painter: RPSCustomPainter(),
                child: Center(
                    child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0.dp),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(flex: 4, child: SvgPicture.asset(AppIcons.helloRafiki)),
                      Flexible(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: '${AppStrings.youWillAchieveYour.tr()} ',
                                  style: textTheme.subtitle2
                                      ?.copyWith(color: AppColor.black)),
                              TextSpan(
                                  text: '${AppStrings.yourGoals.tr()} ',
                                  style: textTheme.headline4),
                              TextSpan(
                                text: '${AppStrings.after.tr()} $infoMessage ',
                                style: textTheme.subtitle2
                                    ?.copyWith(color: AppColor.black),
                              )
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(AppStrings.readyToSaveMoney.tr(),
                          style: textTheme.headline6),
                      Expanded(
                        flex: 4,
                        child: Row(
                          children: [
                            const Spacer(),
                            CustomTextButton(
                                onPressed: () => onPressedNoFunction(),
                                text: AppStrings.no.tr(),
                                isVisible: false,
                                textStyle: textTheme.headline6
                                    ?.copyWith(color: AppColor.grey)),
                            const Spacer(flex: 2),
                            Expanded(
                                flex: 9,
                                child: SvgPicture.asset(AppIcons.magneticIcon)),
                            const Spacer(flex: 2),
                            CustomTextButton(
                                onPressed: () {
                                  onPressedYesFunction();
                                },
                                text: AppStrings.yes.tr(),
                                isVisible: false),
                            const Spacer(),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
              ),
            ),
          );
        });
  }

  errorSnackBar({required BuildContext context, required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColor.white),
      ),
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.red,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
    ));
  }
}

/// This uses a platform-appropriate mechanism to show users multiple choices.
///
///

void _customAlertDialog(
    {required BuildContext context,
    required String title,
    Widget? message,
    List<Widget>? actionButton}) async {
  const duration6hundred = Duration(milliseconds: 800);
  switch (defaultTargetPlatform) {
    case TargetPlatform.android:
      await showDialog<void>(
        context: context,
        builder: (BuildContext context) => Center(
          child: SingleChildScrollView(
            child: AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1)),
              titleTextStyle: const TextStyle(color: Colors.black),
              title: title.isEmpty
                  ? null
                  : Text(title,
                      style: Theme.of(context).textTheme.headline3,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center),
              content: message,
              actions: actionButton,
            ),
          ),
        ),
        barrierDismissible: true,
        barrierLabel: 'data',
        barrierColor: AppColor.black.withOpacity(0.3),
      );
      return;
    case TargetPlatform.iOS:
      await showCupertinoDialog<void>(
        context: context,
        builder: (context) {
          return SizedBox(
            height: 30.h,
            child: CupertinoAlertDialog(
              insetAnimationDuration: duration6hundred,
              insetAnimationCurve: Curves.easeInOut,
              title: title.isEmpty
                  ? null
                  : Text(title, style: Theme.of(context).textTheme.subtitle1),
              content: message,
              actions: actionButton ?? [],
              scrollController: FixedExtentScrollController(initialItem: 1),
            ),
          );
        },
      );
      return;
    default:
      assert(false, 'Unexpected platform $defaultTargetPlatform');
  }
}
