// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// part 'databases_models.g.dart';
//
// @HiveType(typeId: 6)
// class DailyIncomeModel extends HiveObject {
//   DailyIncomeModel();
//   DailyIncomeModel.copyWith({
//     required this.dailyIncomeModel,
//     required this.lastConfirmationDate,
//     required this.nextShownDate,
//     required this.lastShownDate,
//     required this.isLastConfirmed,
//     required this.creationDate,
//   });
//   @HiveField(0)
//   late IncomeModel dailyIncomeModel;
//   @HiveField(1)
//   late bool isLastConfirmed ;
//   @HiveField(2)
//   late DateTime lastShownDate;
//   @HiveField(3)
//   late DateTime nextShownDate;
//   @HiveField(4)
//   late DateTime lastConfirmationDate;
//   @HiveField(5)
//   late DateTime creationDate;
// }