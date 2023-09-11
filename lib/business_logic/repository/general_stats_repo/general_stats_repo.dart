import 'package:temp/data/models/notification/notification_model.dart';
import 'package:temp/data/models/statistics/general_stats_model.dart';

abstract class GeneralStatsRepo {
  Future<void> addTheGeneralStateModel();
  Future<void> plusBalance({required num amount});
  Future<void> minusBalance({required num amount});
  Future<List<NotificationModel>> getNotifications({required bool didOpenAppToday});
  Future<List<NotificationModel>> fetchedNotifications();
  Future<void> addNotification(NotificationModel notificationModel);
  Future<void> deleteNotification(NotificationModel notificationModel);
  bool isGeneralModelExists();
  Future<GeneralStatsModel> getTheGeneralStatsModel();
  Future<void> fetchTopExpenseAndTopIncome();
  Future<void> changeStatusOfNotification(NotificationModel notificationModel);
}
