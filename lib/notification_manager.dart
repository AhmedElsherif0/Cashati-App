import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:temp/constants/app_strings.dart';
import 'package:temp/data/local/cache_helper.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationManager {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();
  bool isNotificationScheduled = false;

  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@drawable/success_confirmation'); // Replace 'app_icon' with your app's icon name
    final InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    tz.initializeTimeZones();
  }

  Future<void> scheduleDailyNotification({int hour = 21, int minute = 0}) async {
    if (isNotificationScheduled) {
      print('Notification is already scheduled.');
      return;
    }

    final DateTime now = DateTime.now();
    final DateTime scheduledDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    if (scheduledDateTime.isBefore(now)) {
      print('Scheduled time has already passed for today.');
      return;
    }

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'channel_id',
      'channel_name',

      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
    );
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0, // Notification ID
      'Cashati Transactions',
      'Register your today\'s transactions to track your money history',
      tz.TZDateTime.from(scheduledDateTime, tz.local),
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );

    isNotificationScheduled = true;
    print('Daily notification scheduled for ${scheduledDateTime.toString()}.');
  }

  Future<void> cancelNotification() async {
    await flutterLocalNotificationsPlugin.cancelAll();
    isNotificationScheduled = false;
    print('Notification canceled.');
  }
}
class NotificationsManagerHandler{
  final CacheHelper cacheHelper=CacheHelper();
  Future saveInitialNotification()async{
    if(CacheHelper.sharedPreferences.getString(AppStrings.reminderSharedPref) != null){
      print("No Saved Time yet");
      return;
    }else{
      try{
        await CacheHelper.saveDataSharedPreference(key:AppStrings.reminderSharedPref,value:"9:00");
        print("No Saving Time");
      }catch(error){
        print("Error Saving time ${error}");
      }

    }

  }

  Future<bool>saveTime({required int hour,required int minute})async{
   return await CacheHelper.saveDataSharedPreference(key: AppStrings.reminderSharedPref, value: "$hour:$minute");
  }
  Future<bool>clearTime()async{
    return await CacheHelper.saveDataSharedPreference(key: AppStrings.reminderSharedPref, value: "");
  }
  String fetchCurrentSavedTime(){
    return CacheHelper.sharedPreferences.getString(AppStrings.reminderSharedPref)??"";

  }

}
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   final NotificationManager notificationManager = NotificationManager();
//   await notificationManager.init();
//
//   // Schedule daily notification at 9 pm
//   await notificationManager.scheduleDailyNotification(hour: 21, minute: 0);
//
//   // Uncomment the line below to cancel the notification
//   // await notificationManager.cancelNotification();
// }