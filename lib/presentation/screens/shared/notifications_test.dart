import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:intl/intl.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:temp/business_logic/cubit/home_cubit/home_cubit.dart';
import 'package:temp/business_logic/cubit/home_cubit/home_state.dart';
import 'package:temp/constants/app_strings.dart';
import 'package:temp/presentation/styles/colors.dart';
import 'package:temp/presentation/views/custom_notification_tile.dart';
import 'package:temp/presentation/widgets/notification_confirm.dart';

import '../../widgets/custom_app_bar.dart';

class NotificationTestScreen extends StatefulWidget {
  const NotificationTestScreen({Key? key}) : super(key: key);

  @override
  State<NotificationTestScreen> createState() => _NotificationTestScreenState();
}

//TODO make this as main notification screen and delete other screen

class _NotificationTestScreenState extends State<NotificationTestScreen> {
  @override
  void initState() {
    super.initState();
    fetchNotifications();
  }

  fetchNotifications() => BlocProvider.of<HomeCubit>(context).getNotificationList();

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
          BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              return Expanded(
                child: ListView.builder(
                  itemCount:
                      BlocProvider.of<HomeCubit>(context).notificationList!.length,
                  itemBuilder: (_, index) => CustomNotificationTile(
                      isActionTaken: context
                          .read<HomeCubit>()
                          .notificationList![index]
                          .didTakeAction,
                      dateTime: DateFormat.yMMMd().format(
                          BlocProvider.of<HomeCubit>(context)
                              .notificationList![index]
                              .checkedDate),
                      firstIcon: context
                              .read<HomeCubit>()
                              .notificationList![index]
                              .didTakeAction
                          ? const Icon(Icons.check_circle_outline,
                              color: AppColor.green)
                          : const Icon(Icons.flag_circle_rounded, color: AppColor.red),
                      onPressedNotification: () {
                        if (!context
                            .read<HomeCubit>()
                            .notificationList![index]
                            .didTakeAction) {
                          showDialog(
                              context: context,
                              builder: (ctx) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 2.w, vertical: 30.h),
                                  child: NotifyingConfirmPaying(
                                      onEditAmount: () {
                                        //TODO edit notification amount paid on that day

                                        // BlocProvider.of<HomeCubit>(context).notificationList![index].amount = amount;
                                      },
                                      onDetails: () {},
                                      notificationModel:
                                          BlocProvider.of<HomeCubit>(context)
                                              .notificationList![index],
                                      date: BlocProvider.of<HomeCubit>(context)
                                          .notificationList![index]
                                          .checkedDate
                                          .toString(),
                                      onDelete: () {},
                                      onCancel: () {
                                        Navigator.pop(context);
                                      },
                                      onConfirm: () {
                                        context
                                            .read<HomeCubit>()
                                            .onYesTransactionNotification(
                                                BlocProvider.of<HomeCubit>(context)
                                                    .notificationList![index]);
                                        Navigator.pop(context);
                                      }),
                                );
                              });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                            "Action Has been taken already on ${context.read<HomeCubit>().notificationList![index].modelName}",
                            maxLines: 2,
                          )));
                        }
                      },
                      subTitle: BlocProvider.of<HomeCubit>(context)
                          .notificationList![index]
                          .modelName,
                      title: BlocProvider.of<HomeCubit>(context)
                          .notificationList![index]
                          .typeName),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
