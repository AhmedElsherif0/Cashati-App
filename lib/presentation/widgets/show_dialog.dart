import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import '../styles/colors.dart';
import 'custom_text_button.dart';

mixin AlertDialogMixin {
  void showSuccessfulDialog(
      BuildContext context, String title, String message) {
    _customAlertDialog(
      context: context,
      title: title,
      actionButton: [
        DecoratedBox(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.sp)),
          child: SizedBox(
            height: 40.h,
            width: 80.w,
            child: Center(
              child: Column(
                children: [
                  Expanded(
                    flex: 4,
                    child:
                        SvgPicture.asset('assets/icons/successfully_added.svg'),
                  ),
                  const Spacer(flex: 3),
                  Expanded(
                    flex: 4,
                    child: Wrap(
                      children: [
                        Text(message,
                            style: Theme.of(context).textTheme.headline4)
                      ],
                    ),
                  ),
                  CustomTextButton(
                    alignment: Alignment.bottomRight,
                    icon: Icons.arrow_back_ios,
                    onPressed: () => Navigator.of(context).pop(),
                    text: 'Back',
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
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.white,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Loading",
                      style: Theme.of(context)
                          .textTheme
                          .headline3
                          ?.copyWith(letterSpacing: 3),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Back'),
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
              text: 'Not yet',
            ),
            CustomTextButton(
              onPressed: onPressed,
              text: 'Sure',
            )
          ],
        )
      ],
    );
  }
}

/// This uses a platform-appropriate mechanism to show users multiple choices.
///
///
const duration6hundred = Duration(milliseconds: 800);

void _customAlertDialog(
    {required BuildContext context,
    required String title,
    Widget? message,
    List<Widget>? actionButton}) async {
  switch (defaultTargetPlatform) {
    case TargetPlatform.android:
      await showDialog<void>(
        context: context,
        builder: (BuildContext context) => Center(
          child: SingleChildScrollView(
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(1)),
              titleTextStyle: const TextStyle(color: Colors.black),
              title: Text(title ?? '',
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
        barrierColor: AppColor.black.withOpacity(0.7),
      );
      return;
    case TargetPlatform.iOS:
      await showCupertinoDialog<void>(
        context: context,
        builder: (context) {
          return SizedBox(
            height: 250,
            child: CupertinoAlertDialog(
              insetAnimationDuration: duration6hundred,
              insetAnimationCurve: Curves.easeInOut,
              title: title.isEmpty
                  ? null
                  : Text(title ?? '',
                      style: Theme.of(context).textTheme.subtitle1),
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
