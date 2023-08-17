import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:temp/constants/app_strings.dart';

import '../styles/colors.dart';

class CustomNotificationTile extends StatelessWidget {
  const CustomNotificationTile({
    required this.title,
    this.firstIcon = const Icon(Icons.chat),
    Key? key,
    this.onPressedNotification,
    required this.subTitle,
    required this.dateTime,
    required this.isActionTaken,
  }) : super(key: key);

  final String title;
  final String subTitle;
  final String dateTime;
  final Widget? firstIcon;
  final bool? isActionTaken;
  final VoidCallback? onPressedNotification;

  @override
  Widget build(BuildContext context) {
    final isEnglish = translator.activeLanguageCode == 'en';
    return SizedBox(
      height: 26.h,
      child: InkWell(
        onTap: onPressedNotification,
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 12.dp, vertical: 12.dp),
          elevation: 2,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.dp))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment:
                  isEnglish ? CrossAxisAlignment.start : CrossAxisAlignment.end,
              children: [
                Align(
                  alignment: isEnglish ? Alignment.topRight : Alignment.topLeft,
                  child: Text(dateTime,
                      style: Theme.of(context).textTheme.overline,
                      overflow: TextOverflow.ellipsis),
                ),
                Expanded(
                  flex: 4,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: AppColor.white,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: onPressedNotification,
                            icon: firstIcon!,
                            color: Colors.green,
                            iconSize: 36.dp,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 8,
                        child: Visibility(
                          visible: !isActionTaken!,
                          replacement: Text(
                            "${title.tr()} ${AppStrings.confirmedSuccessfully.tr()}",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(fontSize: 15),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          child: Text(
                            "${title.tr()} ${AppStrings.confirmationRequired.tr()}",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(fontSize: 15),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Row(
                    children: [
                      const Spacer(flex: 2),
                      Expanded(
                        flex: 8,
                        child: Visibility(
                          visible:!isActionTaken! ,
                          replacement: Text('${AppStrings.successfullyConfirmedYour.tr()} ${title.tr()} ${subTitle.tr()}.',
                            style: Theme.of(context)
                                .textTheme
                                .overline!
                                .copyWith(fontSize: 15),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 4,
                          ),
                          child: Text('${AppStrings.confirmationReminder.tr()} ${title.tr()} ${subTitle.tr()} ${AppStrings.youHaveAddedBefore.tr()}.',
                            style: Theme.of(context)
                                .textTheme
                                .overline!
                                .copyWith(fontSize: 15),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 4
                          ),
                        ),
                      ),
                      const Spacer()
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
