import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../../constants/app_strings.dart';
import '../../widgets/custom_app_bar.dart';
import '../../views/custom_notification_tile.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0.5.h),
      body: Column(
        children: [
           CustomAppBar(
              firstIcon: Icons.arrow_back_ios,
              isEndIconVisible: false,
              title: AppStrings.notifications.tr()),
          Expanded(
            child: ListView.builder(
              itemCount: 8,
              itemBuilder: (_, index) => CustomNotificationTile(
                  isActionTaken:false ,
                  dateTime: AppStrings.threeHours.tr(),
                  firstIcon: const Icon(Icons.check_circle_outline),
                  onPressedNotification: () {},
                  title: AppStrings.goalConfirmationSuccess.tr(),
                  subTitle:
                      AppStrings.successfullyConfirmedExpenseFood.tr()),
            ),
          ),
        ],
      ),
    );
  }
}
