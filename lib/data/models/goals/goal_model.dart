// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// part 'databases_models.g.dart';
//
// @HiveType(typeId: 12)
// class GoalModel extends HiveObject {
//   GoalModel();
//   GoalModel.copyWith({
//     required this.goalComment,
//     required this.goalCreatedDay,
//     required this.goalId,
//     required  this.goalName,
//     required this.goalRemainingAmount,
//     required this.goalRemainingPeriod,
//     required this.goalSaveAmount,
//     required this.goalSaveAmountRepeat,
//     required this.goalTotalAmount,
//     required this.goalStartSavingDate,
//   });
//   @HiveField(0)
//   late String goalId;
//   @HiveField(1)
//   late String goalName ;
//   @HiveField(2)
//   late num goalTotalAmount ;
//   @HiveField(3)
//   late num goalSaveAmount ;
//   @HiveField(4)
//   late num goalRemainingAmount ;
//   @HiveField(5)
//   late String goalSaveAmountRepeat;
//   @HiveField(6)
//   late String goalComment;
//   @HiveField(7)
//   late int goalRemainingPeriod;
//   @HiveField(8)
//   late DateTime goalCreatedDay;
//   @HiveField(9)
//   late DateTime goalStartSavingDate;
// }