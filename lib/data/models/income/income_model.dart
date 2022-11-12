// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// part 'databases_models.g.dart';
//
// @HiveType(typeId: 5)
// class IncomeModel extends HiveObject {
//   IncomeModel();
//   IncomeModel.copyWith({
//     required this.incomeId,
//     required this.incomeName,
//     required this.incomeAmount,
//     required this.incomeComment,
//     required this.isReceiveNotification,
//     required this.incomeAddAuto,
//     required this.incomeCreatedDate,
//     required this.incomeMainCateg,
//     required this.incomePaymentDate,
//     required this.incomeReceived,
//     required this.incomeRepeat,
//     required this.incomeSubCateg,
//   });
//   @HiveField(0)
//   late String incomeId;
//   @HiveField(1)
//   late String incomeName;
//   @HiveField(2)
//   late num incomeAmount;
//   @HiveField(3)
//   late String incomeMainCateg;
//   @HiveField(4)
//   late String incomeSubCateg;
//   @HiveField(5)
//   late String incomeRepeat;
//   @HiveField(6)
//   late String incomeComment;
//   @HiveField(7)
//   late bool incomeAddAuto;
//   @HiveField(8)
//   late bool isReceiveNotification;
//   @HiveField(9)
//   late bool incomeReceived;
//   @HiveField(10)
//   late DateTime incomePaymentDate;
//   @HiveField(11)
//   late DateTime incomeCreatedDate;
// }