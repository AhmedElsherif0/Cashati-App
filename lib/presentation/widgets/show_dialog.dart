import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/svg.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:temp/constants/app_strings.dart';
import 'package:temp/presentation/styles/decorations.dart';
import 'package:temp/presentation/widgets/buttons/elevated_button.dart';

import '../../constants/app_icons.dart';
import '../styles/colors.dart';
import 'buttons/custom_text_button.dart';
import 'custom_painter_dialog.dart';

mixin AlertDialogMixin {
  void _initSnackBar({context, message, Color backGroundColor = Colors.red}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Center(
        child: Text(message,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: AppColor.white)),
      ),
      duration: const Duration(milliseconds: 2500),
      backgroundColor: backGroundColor,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
    ));
  }

  void errorSnackBar({required BuildContext context, required String message}) =>
      _initSnackBar(context: context, message: message);

  void successSnackBar({required BuildContext context, required String message}) =>
      _initSnackBar(
          context: context, message: message, backGroundColor: AppColor.mintGreen);

  Future<void> _initAnimationDialog(
      {context, child, AnimatedWidget? transition}) async {
    await showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionBuilder: (ctx, a1, a2, child) {
          return transition ??
              SlideTransition(
                  position: Tween(begin: const Offset(1, 0), end: const Offset(0, 0))
                      .animate(a1),
                  child: child

                  /// if you need to rotate Transitions.
                  // angle: math.radians(a1.value * 360),
                  /// if you need to scale Transitions.
                  //  offset: const Offset(0.1, -15.0),
                  );
        },
        transitionDuration: AppDecorations.duration600ms,
        pageBuilder: (BuildContext buildContext, Animation animation,
                Animation secondaryAnimation) =>
            child);
  }

  Future<void> newAmountDialog(
      {required double amount,
      required Function onUpdate,
      required BuildContext context,
      required TextEditingController changedAmountCtrl}) {
    return _initAnimationDialog(
        context: context,
        child: Center(
          child: DecoratedBox(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            child: AlertDialog(
              title: Text('${AppStrings.update.tr()} ${AppStrings.amount.tr()}'),
              content: TextFormField(
                keyboardType: TextInputType.number,
                controller: changedAmountCtrl,
                decoration: InputDecoration(
                    hintText: "$amount", labelText: AppStrings.paidAmount.tr()),
              ),
              actions: [
                CustomElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    text: AppStrings.cancel.tr()),
                CustomElevatedButton(
                    onPressed: () {
                      onUpdate();
                      Navigator.of(context).pop();
                    },
                    text: AppStrings.update.tr()),
              ],
            ),
          ),
        ));
  }

  Future<void> showYesOrNoDialog(
      {required String title,
      required String message,
      required Function onYes,
      Function? onNo,
      required BuildContext context}) {
    return _initAnimationDialog(
      context: context,
      child: Center(
        child: AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            CustomElevatedButton(
                onPressed: () => [onYes(), Navigator.of(context).pop()],
                text: AppStrings.yes.tr()),
            CustomElevatedButton(
                onPressed: () => [onNo ?? () {}, Navigator.of(context).pop()],
                text: AppStrings.no.tr()),
          ],
        ),
      ),
    );
  }

  Future<void> showSuccessfulDialog(BuildContext context, String message) async {
    bool isEnglish = translator.activeLanguageCode == 'en';
    await _initAnimationDialog(
        context: context,
        child: Center(
          child: DecoratedBox(
            decoration: AppDecorations.decoratedTextDecoration(radius: 20.dp),
            child: SizedBox(
              height: 50.h,
              width: 80.w,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(12.dp),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 20.dp),
                        child: SvgPicture.asset(AppIcons.successfullyAdded),
                      ),
                      Wrap(
                        children: [
                          Text(
                            message,
                            style: Theme.of(context).textTheme.headline4,
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                      CustomTextButton(
                        alignment:
                            isEnglish ? Alignment.bottomRight : Alignment.bottomLeft,
                        onPressed: () => Navigator.of(context).pop(),
                        text: AppStrings.back.tr(),
                        icon: Icons.arrow_back_ios,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  Future<void> showSettingDialog(
      {required BuildContext context, Widget? child}) async {
    await _initAnimationDialog(
        context: context,
        child: Center(
          child: DecoratedBox(
            decoration: AppDecorations.decoratedTextDecoration(radius: 20),
            child: AnimatedContainer(
              duration: AppDecorations.duration600ms,
              curve: Curves.easeInToLinear,
              height: 50.h,
              width: 70.w,
              child: child,
            ),
          ),
        ));
  }

  Future<void> showPrivacyAndTermsDialog(
      {required BuildContext context, Widget? child}) async {
    await _initAnimationDialog(
        context: context,
        child: Center(
          child: DecoratedBox(
            decoration: AppDecorations.decoratedTextDecoration(radius: 20),
            child: AnimatedContainer(
              duration: AppDecorations.duration200ms,
              curve: Curves.easeInToLinear,
              height: 70.h,
              width: 80.w,
              child: child,
            ),
          ),
        ));
  }

  Future<void> showSuccessfulDialogNoOptions(
      BuildContext context, String message) async {
    await _initAnimationDialog(
        context: context,
        child: Center(
          child: DecoratedBox(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.dp), color: AppColor.white),
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
                  CustomTextButton(
                    onPressed: () => Navigator.pop(context),
                    text: AppStrings.back.tr(),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Future<void> showLoadingDialog(BuildContext context) async {
    await _initAnimationDialog(
        context: context,
        child: Center(
          child: DecoratedBox(
            decoration: const BoxDecoration(color: Colors.white),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppStrings.loading.tr(),
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
        ));
  }

  /// Goals Dialog ely taaalaaaa3 3eeein omy.
  Future<void> showGoalsDialog(
      {required BuildContext context,
      required Function onPressedYesFunction,
      required String infoMessage}) async {
    await _initAnimationDialog(
        context: context,
        child: GoalsDialogBody(
            onPressedNoFunction: () => Navigator.of(context).pop(),
            onPressedYesFunction: onPressedYesFunction,
            infoMessage: infoMessage));
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

class GoalsDialogBody extends StatelessWidget {
  const GoalsDialogBody(
      {super.key,
      required this.onPressedYesFunction,
      required this.onPressedNoFunction,
      required this.infoMessage});

  final Function onPressedYesFunction;
  final Function onPressedNoFunction;
  final String infoMessage;

  @override
  Widget build(BuildContext context) {
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
                            style:
                                textTheme.subtitle2?.copyWith(color: AppColor.black)),
                        TextSpan(
                            text: '${AppStrings.yourGoals.tr()} ',
                            style: textTheme.headline4),
                        TextSpan(
                          text: '${AppStrings.after.tr()} $infoMessage ',
                          style: textTheme.subtitle2?.copyWith(color: AppColor.black),
                        )
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                Text(AppStrings.readyToSaveMoney.tr(), style: textTheme.headline6),
                Expanded(
                  flex: 4,
                  child: Row(
                    children: [
                      const Spacer(),
                      CustomTextButton(
                          onPressed: () => onPressedNoFunction(),
                          text: AppStrings.no.tr(),
                          isVisible: false,
                          textStyle:
                              textTheme.headline6?.copyWith(color: AppColor.grey)),
                      const Spacer(flex: 2),
                      Expanded(
                          flex: 9, child: SvgPicture.asset(AppIcons.magneticIcon)),
                      const Spacer(flex: 2),
                      CustomTextButton(
                          onPressed: () => onPressedYesFunction(),
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
  }
}
