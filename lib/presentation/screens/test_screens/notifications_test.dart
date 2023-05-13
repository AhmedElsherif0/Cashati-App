import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/business_logic/cubit/home_cubit/home_cubit.dart';
import 'package:temp/business_logic/cubit/home_cubit/home_state.dart';
import 'package:temp/presentation/styles/colors.dart';
import 'package:temp/presentation/views/confirm_paying_expense.dart';
import 'package:temp/presentation/views/custom_notification_tile.dart';
import 'package:temp/presentation/widgets/notification_confirm.dart';

import '../../widgets/custom_app_bar.dart';

class NotificationTestScreen extends StatefulWidget {
  const NotificationTestScreen({Key? key}) : super(key: key);

  @override
  State<NotificationTestScreen> createState() => _NotificationTestScreenState();
}

class _NotificationTestScreenState extends State<NotificationTestScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchNotifications();
  }

  fetchNotifications() {
    BlocProvider.of<HomeCubit>(context).getNotificationList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0.5.h),
      body: Column(
        children: [
          const CustomAppBar(
              firstIcon: Icons.arrow_back_ios,
              isEndIconVisible: false,
              title: 'Notifications'),
          BlocBuilder<HomeCubit, HomeState>(
  builder: (context, state) {
    return Expanded(
            child: ListView.builder(
              itemCount:
                  BlocProvider.of<HomeCubit>(context).notificationList!.length,
              itemBuilder: (_, index) => CustomNotificationTile(
                  dateTime: BlocProvider.of<HomeCubit>(context)
                      .notificationList![index]
                      .checkedDate
                      .toString(),
                  firstIcon:context.read<HomeCubit>().notificationList![index].didTakeAction?const Icon(
                    Icons.check_circle_outline,
                    color: AppColor.green,
                  ): const Icon(
                    Icons.flag_circle_rounded,
                    color: AppColor.red,
                  ),
                  onPressedNotification: () {
                    showDialog(
                        context: context,
                        builder: (ctx) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 2.w,vertical: 30.h),

                            child: NotifyingConfirmPaying(
                                onEditAmount: (){
                                 // BlocProvider.of<HomeCubit>(context).notificationList![index].amount = amount;
                                },
                                onDetails: (){},
                                notificationModel: BlocProvider.of<HomeCubit>(context).notificationList![index],
                                date:  BlocProvider.of<HomeCubit>(context).notificationList![index]
                                .checkedDate.toString(),
                                onDelete: (){},
                                onCancel: (){},
                                onConfirm: (){
                                  context.read<HomeCubit>().onYesTransactionNotification(BlocProvider.of<HomeCubit>(context).notificationList![index]);
                                }),
                          );
                        });
                  },
                  subTitle: BlocProvider.of<HomeCubit>(context)
                      .notificationList![index]
                      .modelName,
                  title:
                      "${BlocProvider.of<HomeCubit>(context).notificationList![index].typeName}"),
            ),
          );
  },
),
        ],
      ),
    );
  }
}
