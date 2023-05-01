import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:temp/data/models/notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationsApi {
  static final _notificationPlugins = FlutterLocalNotificationsPlugin();
  static const _detailsIOS = DarwinNotificationDetails();
  static StreamController streamController = StreamController.broadcast();

  static initialize() async {
    const initAndroid =
        AndroidInitializationSettings('@drawable/success_confirmation');
    const initIOS = DarwinInitializationSettings();
    const initSettings = InitializationSettings(android: initAndroid, iOS: initIOS);
    await _notificationPlugins.initialize(initSettings,
        onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse);
  }

  static void _onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    if (notificationResponse.payload != null) {
      const NotificationResponse(
          notificationResponseType: NotificationResponseType.selectedNotification);
      streamController.add(notificationResponse.payload);
    }
  }

  Future _notificationDetails() async => const NotificationDetails(
      android: AndroidNotificationDetails('channelId', 'channelName',
          channelDescription: 'channelSubTitle', importance: Importance.max),
      iOS: _detailsIOS);

  Future showNotification({required NotificationsModel notifyModel}) async {
    await _notificationPlugins.show(notifyModel.id, notifyModel.title,
        notifyModel.subTitle, await _notificationDetails(),
        payload: notifyModel.payLoad);
  }

  Future<void> cancelAllNotifications() async =>
      await _notificationPlugins.cancelAll();

  Future showSpecificScheduledNotification(
      {required NotificationsModel notifyModel}) async {
    await _notificationPlugins.zonedSchedule(
        notifyModel.id,
        notifyModel.title,
        notifyModel.subTitle,
        tz.TZDateTime.from(notifyModel.dateTime, tz.local),
        await _notificationDetails(),
        payload: notifyModel.payLoad,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future showDailyNotification({required NotificationsModel notifyModel}) async {
    tz.initializeTimeZones();
    await _notificationPlugins.zonedSchedule(
        notifyModel.id,
        notifyModel.title,
        notifyModel.subTitle,
        _scheduleDaily(notifyModel.dateTime),
        await _notificationDetails(),
        payload: notifyModel.payLoad,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  tz.TZDateTime _scheduleDaily(DateTime currentDate) {
    final scheduledDate = tz.TZDateTime.from(currentDate, tz.local);

    /// this condistion to check if the time not in the past.
    return scheduledDate.isBefore(currentDate)
        ? scheduledDate.add(const Duration(days: 1))
        : scheduledDate;
  }

  tz.TZDateTime _scheduleWeekly(DateTime time) {
    final now = DateTime.now().toLocal();
    final scheduledDate = tz.TZDateTime(
        tz.local, now.year, now.month, now.day, time.hour, time.minute, time.second);

    /// this condistion to check if the time not in the past.
    return scheduledDate.isBefore(now)
        ? scheduledDate.add(const Duration(days: 7))
        : scheduledDate;
  }

/*
  tz.TZDateTime _scheduleRepeatedDate(int scheduleTime, DateTime time) {
    final now = tz.TZDateTime.now(tz.local);
    final scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day,
        time.hour, time.minute, time.second);
    return scheduledDate.isBefore(now)
        ? scheduledDate.add(Duration(days: scheduleTime))
        : scheduledDate;
  }
*/
}
