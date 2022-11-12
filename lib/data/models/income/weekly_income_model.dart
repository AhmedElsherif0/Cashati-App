// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// part 'databases_models.g.dart';
//
// @HiveType(typeId: 7)
// class WeeklyIncomeModel extends HiveObject {
//   WeeklyIncomeModel();
//   WeeklyIncomeModel.copyWith({
//     required this.weekIncomeModel,
//     required this.weekLastConfirmationDate,
//     required this.nextShownDate,
//     required this.weekLastShownDate,
//     required this.weekIsLastConfirmed,
//     required this.weekCreationDate,
//   });
//   @HiveField(0)
//   late IncomeModel weekIncomeModel;
//   @HiveField(1)
//   late bool weekIsLastConfirmed ;
//   @HiveField(2)
//   late DateTime weekLastShownDate;
//   @HiveField(3)
//   late DateTime nextShownDate;
//   @HiveField(4)
//   late DateTime weekLastConfirmationDate;
//   @HiveField(5)
//   late DateTime weekCreationDate;
// }