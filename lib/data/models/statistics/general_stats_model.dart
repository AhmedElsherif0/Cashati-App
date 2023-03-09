import 'package:hive/hive.dart';
import 'package:temp/constants/app_strings.dart';
import 'package:temp/data/models/notification/notification_model.dart';
part 'general_stats_model.g.dart';

@HiveType(typeId: 7)
class GeneralStatsModel extends HiveObject {
  GeneralStatsModel( { required this.id,
    required this.balance,
    required this.topIncome,
    required this.topIncomeAmount,
    required this.topExpense,
    required this.topExpenseAmount,
    required this.latestCheck,
    required this.notificationList});
  // GeneralStatsModel.copyWith(
  //    );

  @HiveField(0)
   String id=AppStrings.theOnlyGeneralStatsModelID;
  @HiveField(1)
  late num balance=0;
  @HiveField(2)
  late String topIncome;
  @HiveField(3)
  late num topIncomeAmount;
  @HiveField(4)
  late String topExpense;
  @HiveField(5)
  late num topExpenseAmount;
  @HiveField(6)
  late DateTime latestCheck;
  @HiveField(7)
  late List<NotificationModel> notificationList;
}
