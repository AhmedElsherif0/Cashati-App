import 'package:hive/hive.dart';

part 'income_model.g.dart';

@HiveType(typeId: 3)
class IncomeModel {
  IncomeModel();

  IncomeModel.copyWith({
    required this.id,
    required this.name,
    required this.amount,
    required this.comment,
    required this.isReceiveNotification,
    required this.addAuto,
    required this.createdDate,
    required this.mainCategory,
    required this.paymentDate,
    required this.received,
    required this.repeat,
    required this.subCategory,
  });

  @HiveField(0)
  late String id;
  @HiveField(1)
  late String name;
  @HiveField(2)
  late num amount;
  @HiveField(3)
  late String mainCategory;
  @HiveField(4)
  late String subCategory;
  @HiveField(5)
  late String repeat;
  @HiveField(6)
  late String comment;
  @HiveField(7)
  late bool isReceiveNotification;
  @HiveField(8)
  late bool addAuto;
  @HiveField(9)
  late bool received;
  @HiveField(10)
  late DateTime paymentDate;
  @HiveField(11)
  late DateTime createdDate;
}
