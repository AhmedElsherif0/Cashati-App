import 'package:hive/hive.dart';
import 'package:temp/data/models/notification/notification_model.dart';
part 'general_stats_model.g.dart';

@HiveType(typeId: 7)
class GeneralStatsModel extends HiveObject {
  GeneralStatsModel();
  GeneralStatsModel.copyWith(
      {required this.balance,
      required this.topIncome,
      required this.topIncomeAmount,
      required this.topExpense,
      required this.topExpenseAmount,
      required this.latestCheck,
      required this.notificationList});

  @HiveField(0)
  late num balance;
  @HiveField(1)
  late String topIncome;
  @HiveField(2)
  late num topIncomeAmount;
  @HiveField(3)
  late String topExpense;
  @HiveField(4)
  late num topExpenseAmount;
  @HiveField(5)
  late DateTime latestCheck;
  @HiveField(6)
  late List<NotificationModel> notificationList;
}
