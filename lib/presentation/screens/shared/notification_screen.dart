import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

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
          const CustomAppBar(
              firstIcon: Icons.arrow_back_ios,
              isEndIconVisible: false,
              title: 'Notofications'),
          Expanded(
            child: ListView.builder(
              itemCount: 8,
              itemBuilder: (_, index) => CustomNotificationTile(
                  isActionTaken:false ,

                  dateTime: '3h',
                  firstIcon: const Icon(Icons.check_circle_outline),
                  onPressedNotification: () {},
                  title: 'Goal Confirmation Success',
                  subTitle:
                      'You have Successfully confirmed your expense for food'),
            ),
          ),
        ],
      ),
    );
  }
}
