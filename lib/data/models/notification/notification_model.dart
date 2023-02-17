import 'package:hive/hive.dart';
part 'notification_model.g.dart';
@HiveType(typeId: 5)
class NotificationModel extends HiveObject {
  NotificationModel(
      {required this.id,
      required this.modelName,
      required this.typeName,
      required this.amount,
      required this.didTakeAction,
      required this.actionDate,
      required this.icon,
      required this.payLoad,
      required this.checkedDate});

  @HiveField(0)
   late String id;
  @HiveField(1)
  late String modelName;
  @HiveField(2)
  late String typeName;
  @HiveField(3)
  late num amount;
  @HiveField(4)
  late bool didTakeAction;
  @HiveField(5)
  late DateTime actionDate;
  @HiveField(6)
  late DateTime checkedDate;
  @HiveField(7)
  String? icon;
  @HiveField(8)
  String? payLoad;

}
