import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
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
    return SizedBox(
      height: 26.h,
      child: InkWell(
        onTap: onPressedNotification,
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 12.sp),
          elevation: 2,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.sp))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Text('$dateTime',
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
                            iconSize: 36.sp,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 8,
                        child: Visibility(
                          visible:!isActionTaken! ,
                          child: Text(
                            "$title Confirmation Required",
                            style: Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 15),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          replacement: Text(
                            "$title Confirmed Successfully",
                            style: Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 15),
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
                          child: Text(
                            "Don’t forget to confirm your $title  $subTitle you have added before.",
                            style: Theme.of(context).textTheme.overline!.copyWith(fontSize: 15),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 4,
                          ),
                          replacement: Text(
                            "You have successfully confirmed your $title  $subTitle.",
                            style: Theme.of(context).textTheme.overline!.copyWith(fontSize: 15),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 4,
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
