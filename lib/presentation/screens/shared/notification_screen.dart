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
            child: BlocBuilder<HomeCubit, HomeState>(
  builder: (context, state) {
    return ListView.builder(
              itemCount:  BlocProvider.of<HomeCubit>(context).notificationList!.length,
              itemBuilder: (_, index) => CustomNotificationTile(
                  isActionTaken: context
                      .read<HomeCubit>()
                      .notificationList![index]
                      .didTakeAction,
                  dateTime: DateFormat.yMMMd( context
                      .read<GlobalCubit>().isLanguage?"en":"ar").format(
                      context
                          .read<HomeCubit>()
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
                                  date: DateFormat.yMMMd( context
                                      .read<GlobalCubit>().isLanguage?"en":"ar").format(
                                      context
                                          .read<HomeCubit>()
                                          .notificationList![index]
                                          .checkedDate),
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
                            '${AppStrings.successfullyConfirmedYour.tr()} ${context.read<HomeCubit>()
                                .notificationList![index]
                                .typeName.toLowerCase().tr()} ${ context.read<HomeCubit>()
                                .notificationList![index]
                                .modelName}.',
                            maxLines: 2,
                          )));
                    }
                  },
                  subTitle: BlocProvider.of<HomeCubit>(context)
                      .notificationList![index]
                      .modelName,
                  title: BlocProvider.of<HomeCubit>(context)
                      .notificationList![index]
                      .typeName.toLowerCase().tr()),
            );
  },
),
          ),
        ],
      ),
    );
  }
}
