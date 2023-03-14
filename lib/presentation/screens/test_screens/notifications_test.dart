import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/business_logic/cubit/home_cubit/home_cubit.dart';
import 'package:temp/presentation/views/custom_notification_tile.dart';

import '../../widgets/custom_app_bar.dart';

class NotificationTestScreen extends StatelessWidget {
  const NotificationTestScreen({Key? key}) : super(key: key);

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
              itemCount: BlocProvider.of<HomeCubit>(context).notificationList!.length,
              itemBuilder: (_, index) => CustomNotificationTile(
                  dateTime: BlocProvider.of<HomeCubit>(context).notificationList![index].checkedDate.toString(),
                  firstIcon: const Icon(Icons.check_circle_outline),
                  onPressedNotification: () {},
                  title:BlocProvider.of<HomeCubit>(context).notificationList![index].modelName,
                  subTitle:
                  BlocProvider.of<HomeCubit>(context).notificationList![index].typeName),
            ),
          ),
        ],
      ),
    );
  }
}
