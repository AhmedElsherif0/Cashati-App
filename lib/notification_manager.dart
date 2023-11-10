import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:temp/constants/app_strings.dart';
import 'package:temp/data/local/cache_helper.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationManager {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  bool isNotificationScheduled = false;

  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings(
            '@drawable/success_confirmation'); // Replace 'app_icon' with your app's icon name
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    tz.initializeTimeZones();
  }

  NotificationDetails _platformChannelSpecifics() {
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('channel_id', 'channel_name',
            importance: Importance.max, priority: Priority.high, playSound: true);

    return NotificationDetails(android: androidPlatformChannelSpecifics);
  }

  DateTime _scheduledDateTime(int hour, int minute) {
    final DateTime now = DateTime.now();
    final DateTime scheduledDateTime =
        DateTime(now.year, now.month, now.day, hour, minute);
    if (scheduledDateTime.isBefore(now)) {
      print('Scheduled time has already passed for today.');
    }
    return scheduledDateTime;
  }

  Future<void> scheduleDailyNotification({int hour = 21, int minute = 0}) async {
    if (isNotificationScheduled) {
      print('Notification is already scheduled.');
      return;
    }

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0, // Notification ID
      'Cashati Transactions',
      'Register your today\'s transactions to track your money history',
      tz.TZDateTime.from(_scheduledDateTime(hour, minute), tz.local),
      _platformChannelSpecifics(),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );

    isNotificationScheduled = true;
    print('Daily notification scheduled for ${_scheduledDateTime.toString()}.');
  }

  Future<void> cancelNotification() async {
    await flutterLocalNotificationsPlugin.cancelAll();
    isNotificationScheduled = false;
    print('Notification canceled.');
  }
}

class NotificationsManagerHandler {
  Future saveInitialNotification() async {
    if (CacheHelper.sharedPreferences.getString(AppStrings.reminderSharedPref) !=
        null) {
      print("No Saved Time yet");
      return;
    } else {
      try {
        await CacheHelper.saveDataSharedPreference(
            key: AppStrings.reminderSharedPref, value: "9:00");
        print("No Saving Time");
      } catch (error) {
        print("Error Saving time ${error}");
      }
    }
  }

  Future<bool> saveTime({required int hour, required int minute}) async {
    return await CacheHelper.saveDataSharedPreference(
        key: AppStrings.reminderSharedPref, value: "$hour:$minute");
  }

  Future<bool> clearTime() async {
    return await CacheHelper.saveDataSharedPreference(
        key: AppStrings.reminderSharedPref, value: "");
  }

  String fetchCurrentSavedTime() {
    return CacheHelper.getDataFromSharedPreference(
            key: AppStrings.reminderSharedPref) ??
        "";
  }
}
