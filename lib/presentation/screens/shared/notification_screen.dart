import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:intl/intl.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:temp/business_logic/cubit/global_cubit/global_cubit.dart';
import 'package:temp/business_logic/cubit/home_cubit/home_state.dart';
import 'package:temp/presentation/styles/colors.dart';
import 'package:temp/presentation/widgets/notification_confirm.dart';

import '../../../business_logic/cubit/home_cubit/home_cubit.dart';
import '../../../constants/app_strings.dart';
import '../../../data/models/notification/notification_model.dart';
import '../../views/custom_app_bar.dart';
import '../../views/custom_notification_tile.dart';
import '../../widgets/show_dialog.dart';

class NotificationScreen extends StatelessWidget with AlertDialogMixin {
  const NotificationScreen({Key? key}) : super(key: key);

  void _onConfirm(BuildContext context, NotificationModel notification) {
    context.read<HomeCubit>().onYesTransactionNotification(notification);
    Navigator.pop(context);
  }

  void _onPressedNotification(BuildContext context, NotificationModel notification) {
    if (!notification.didTakeAction) {
      showDialog(
          context: context,
          builder: (ctx) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 30.h),
              child: NotifyingConfirmPaying(
                  onEditAmount: () {
                    //TODO edit notification amount paid on that day

                    // BlocProvider.of<HomeCubit>(context).notificationList![index].amount = amount;
                  },
                  onDetails: () {},
                  notificationModel: notification,
                  date: DateFormat.yMMMd(
                          context.read<GlobalCubit>().isLanguage ? "en" : "ar")
                      .format(notification.checkedDate),
                  onDelete: () {},
                  onCancel: () => Navigator.pop(context),
                  onConfirm: () => _onConfirm(context, notification)),
            );
          });
    } else {
      successSnackBar(
          context: context,
          message: '${AppStrings.successfullyConfirmedYour.tr()}'
              ' ${notification.typeName.toLowerCase().tr()}'
              ' ${notification.modelName}.');
    }
  }

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
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                return ListView.builder(
                    itemCount:
                        BlocProvider.of<HomeCubit>(context).notificationList!.length,
                    itemBuilder: (context, index) {
                      final notification =
                          context.read<HomeCubit>().notificationList![index];
                      return CustomNotificationTile(
                          isActionTaken: notification.didTakeAction,
                          dateTime: DateFormat.yMMMd(
                                  context.read<GlobalCubit>().isLanguage ? "en" : "ar")
                              .format(notification.checkedDate),
                          firstIcon: notification.didTakeAction
                              ? const Icon(Icons.check_circle_outline,
                                  color: AppColor.green)
                              : const Icon(Icons.flag_circle_rounded,
                                  color: AppColor.red),
                          onPressedNotification: () =>
                              _onPressedNotification(context, notification),
                          subTitle: notification.modelName,
                          title: notification.typeName.toLowerCase().tr());
                    });
              },
            ),
          ),
        ],
      ),
    );
  }
}
