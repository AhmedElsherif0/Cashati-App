import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import '../styles/colors.dart';
import 'custom_text_button.dart';

mixin AlertDialogMixin {

  void showAlertDialog(BuildContext context, String title, String message) {
    _customAlertDialog(
      context: context,
      title: title,
      actionButton: [
        DecoratedBox(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.sp)),
          child: SizedBox(
            height: 40.h,
            width: 80.w,
            child: Center(
              child: Column(
                children: [
                  const Spacer(),
                  Expanded(
                    flex: 3,
                    child: SvgPicture.asset(
                        'assets/icons/successfully_added.svg'),
                  ),
                  const Spacer(),
                  Expanded(
                    flex: 3,
                    child: Wrap(
                      children: [
                        Text(
                          message,
                          style: Theme.of(context).textTheme.headline6,
                        )
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
}

/*void showMeAlertDialog(BuildContext context, state) {
  _customAlertDialog(
    context: context,
    title: state,
    actionButton: [
      CustomOutlineButton(
        onPressed: () => Navigator.pop(context),
        text: 'Close',
      )
    ],
  );
}*/

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

/// This uses a platform-appropriate mechanism to show users multiple choices.
///
///
 const duration6hundred =  Duration(milliseconds: 800);

void _customAlertDialog(

    {required BuildContext context,
    required String title,
    Widget? message,
    required List<Widget> actionButton}) async {
  switch (defaultTargetPlatform) {
    case TargetPlatform.android:
      await showDialog<void>(
        context: context,
          builder: (BuildContext context)  =>
            Center(
              child: SingleChildScrollView(
                child: AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  titleTextStyle: const TextStyle(color: Colors.black),
                  title: Text(title,
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
              title: Text(title, style: Theme.of(context).textTheme.subtitle1),
              content: message,
              actions: actionButton,
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
