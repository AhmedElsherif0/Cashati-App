// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// part 'databases_models.g.dart';
//
// @HiveType(typeId: 0)
// class ExpenseModel extends HiveObject {
//   ExpenseModel();
//   ExpenseModel.copyWith({
//     required this.expenseId,
//     required this.expenseName,
//     required this.expenseAmount,
//     required this.expenseComment,
//     required this.expenseRepeat,
//     required this.expenseMainCateg,
//     required this.expenseAddAuto,
//     required this.expensePriority,
//     required this.expenseSubCateg,
//     required this.isReceiveNotification,
//     required this.isExpensePaid,
//     required this.expenseCreatedDate,
//     required this.expensePaymentDate,
//   });
//   @HiveField(0)
//   late String expenseId;
//   @HiveField(1)
//   late String expenseName;
//   @HiveField(2)
//   late num expenseAmount;
//   @HiveField(3)
//   late String expenseMainCateg;
//   @HiveField(4)
//   late String expenseSubCateg;
//   @HiveField(5)
//   late bool expensePriority;
//   @HiveField(6)
//   late String expenseRepeat;
//   @HiveField(7)
//   late String expenseComment;
//   @HiveField(8)
//   late bool isReceiveNotification;
//   @HiveField(9)
//   late bool expenseAddAuto;
//   @HiveField(10)
//   late bool isExpensePaid;
//   @HiveField(11)
//   late DateTime expensePaymentDate;
//   @HiveField(12)
//   late DateTime expenseCreatedDate;
// }
