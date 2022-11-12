// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// part 'databases_models.g.dart';

// @HiveType(typeId: 8)
// class MonthlyIncomeModel extends HiveObject {
//   MonthlyIncomeModel();
//   MonthlyIncomeModel.copyWith({
//     required this.monthIncomeModel,
//     required this.monthLastConfirmationDate,
//     required this.nextShownDate,
//     required this.monthLastShownDate,
//     required this.monthIsLastConfirmed,
//     required this.monthCreationDate,
//   });
//   @HiveField(0)
//   late IncomeModel monthIncomeModel;
//   @HiveField(1)
//   late bool monthIsLastConfirmed ;
//   @HiveField(2)
//   late DateTime monthLastShownDate;
//   @HiveField(3)
//   late DateTime nextShownDate;
//   @HiveField(4)
//   late DateTime monthLastConfirmationDate;
//   @HiveField(5)
//   late DateTime monthCreationDate;
// }