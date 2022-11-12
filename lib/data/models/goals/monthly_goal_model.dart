// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// part 'databases_models.g.dart';

// @HiveType(typeId: 15)
// class MonthlyGoalModel extends HiveObject {
//   MonthlyGoalModel();
//   MonthlyGoalModel.copyWith({
//     required this.monthlyGoalModel,
//     required this.nextShownDate,
//     required this.goalCreationDate,
//     required  this.goalIsLastConfirmed,
//     required this.goalLastConfirmationDate,
//     required this.goalLastShownDate,
//     required this.goalStartSavingDate,
//
//   });
//   @HiveField(0)
//   late GoalModel monthlyGoalModel;
//   @HiveField(1)
//   late bool goalIsLastConfirmed ;
//   @HiveField(2)
//   late DateTime goalLastShownDate;
//   @HiveField(3)
//   late DateTime nextShownDate;
//   @HiveField(4)
//   late DateTime goalLastConfirmationDate;
//   @HiveField(5)
//   late DateTime goalCreationDate;
//   @HiveField(6)
//   late DateTime goalStartSavingDate;
// }