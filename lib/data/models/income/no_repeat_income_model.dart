// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// part 'databases_models.g.dart';
//
// @HiveType(typeId: 9)
// class NoRepeatIncomeModel extends HiveObject {
//   NoRepeatIncomeModel();
//   NoRepeatIncomeModel.copyWith({
//     required this.noRepLastShownDate,
//     required this.noRepLastConfirmationDate,
//     required this.nextShownDate,
//     required this.noRepIsLastConfirmed,
//     required this.noRepCreationDate,
//     required this.noRepIncomeModel,
//   });
//   @HiveField(0)
//   late IncomeModel noRepIncomeModel;
//   @HiveField(1)
//   late bool noRepIsLastConfirmed ;
//   @HiveField(2)
//   late DateTime noRepLastShownDate;
//   @HiveField(3)
//   late DateTime nextShownDate;
//   @HiveField(4)
//   late DateTime noRepLastConfirmationDate;
//   @HiveField(5)
//   late DateTime noRepCreationDate;
// }