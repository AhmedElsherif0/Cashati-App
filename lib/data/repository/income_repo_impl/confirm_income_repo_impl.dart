// import 'package:temp/data/local/hive/hive_database.dart';
// import 'package:temp/data/models/income/income_repeat_details_model.dart';
//
// import '../../../business_logic/repository/income_repo/confirm_income_repo.dart';
// import '../../local/hive/app_boxes.dart';
// import '../../local/hive/id_generator.dart';
// import '../../models/income/income_model.dart';
//
// class ConfirmIncomeRepoImpl implements ConfirmIncomeRepo {
//   final HiveHelper _hiveHelper = HiveHelper();
//
//   @override
//   Future<void> addIncomeToBoxFromRepeatedBox(
//       {required IncomeModel currentIncomeModel, num? newAmount}) async {
//     DateTime today = DateTime.now();
//     final IncomeModel incomeModel = currentIncomeModel;
//     incomeModel.amount = newAmount ?? currentIncomeModel.amount;
//     incomeModel.id = GUIDGen.generate();
//     incomeModel.paymentDate = today;
//     incomeModel.createdDate = today;
//
//     final allIncomeBox = _hiveHelper.getBox(boxName: AppBoxes.incomeModel);
//
//     await allIncomeBox.add(incomeModel);
//
//     print('allIncomeModel values are ${allIncomeBox.values}');
//   }
//
//   List<IncomeModel> getTodayPayments() {
//     final allIncomeBox = _hiveHelper.getBox(boxName: AppBoxes.expenseRepeatTypes);
//     List<IncomeRepeatDetailsModel> incomeList =
//     allIncomeBox.values.toList().cast<IncomeRepeatDetailsModel>();
//     List<IncomeModel> todayList = [];
//     for (var item in incomeList) {
//       // here we check confirmation date  Slide number 12
//       if (!checkSameDay(date: item.lastConfirmationDate)) {
//         todayList.add(item.incomeModel);
//       }
//     }
//     for (var item in incomeList) {
//       if (checkSameDay(date: item.nextShownDate) &&
//               !checkSameDay(date: item.lastConfirmationDate) ||
//           checkNoConfirmedAndWeekly(
//               nextShownDate: item.nextShownDate,
//               lastConfirmedDate: item.lastConfirmationDate,
//               incomePayment: item.incomeModel.paymentDate)) {
//         todayList.add(item.incomeModel);
//       }
//     }
//     for (var item in incomeList) {
//       if (checkSameDay(date: item.nextShownDate) &&
//               !checkSameDay(date: item.lastConfirmationDate) ||
//           checkNoConfirmedAndMonthly(
//               nextShownDate: item.nextShownDate,
//               lastConfirmedDate: item.lastConfirmationDate,
//               incomePayment: item.incomeModel.paymentDate)) {
//         todayList.add(item.incomeModel);
//       }
//     }
//     for (var item in incomeList) {
//       if (checkSameDay(date: item.nextShownDate) &&
//           !checkSameDay(date: item.lastConfirmationDate)) {
//         todayList.add(item.incomeModel);
//       }
//     }
//
//     return todayList;
//   }
//
//   bool checkSameDay({required DateTime date}) {
//     //DateTime today=DateTime(2022,12,5);
//
//     // the right today is below
//     DateTime today = DateTime.now();
//     // if(today.difference(date).inDays==0){
//     if (today.day == date.day && today.month == today.month) {
//       return true;
//     } else {
//       return false;
//     }
//   }
//
//   bool checkNoConfirmedAndWeekly(
//       {required DateTime nextShownDate,
//       required DateTime lastConfirmedDate,
//       required DateTime incomePayment}) {
//     //TODO change today.difference to check same day to check day and month only as 0 days doesn't let the income shows at the start of the day
//     // for showing the payment weekly if he didn't take action
//     final DateTime today = DateTime.now();
//     if (today.difference(incomePayment).inDays != 0 &&
//         today.difference(nextShownDate).inDays % 7 == 0 &&
//         today.difference(lastConfirmedDate).inDays != 0) {
//       return true;
//     } else {
//       return false;
//     }
//   }
//
//   bool checkNoConfirmedAndMonthly(
//       {required DateTime nextShownDate,
//       required DateTime lastConfirmedDate,
//       required DateTime incomePayment}) {
//     // for showing the payment weekly if he didn't take action
//     final DateTime today = DateTime.now();
//     if (today.difference(incomePayment).inDays != 0 &&
//         today.difference(nextShownDate).inDays % 30 == 0 &&
//         today.difference(lastConfirmedDate).inDays != 0) {
//       return true;
//     } else {
//       return false;
//     }
//   }
//
// // when Yes
//   IncomeRepeatDetailsModel editDailyIncomeLastShown(
//       {required IncomeModel theAddedIncome, required DateTime today}) {
//     IncomeRepeatDetailsModel theMatchingDailyIncome =
//         _hiveHelper.getBox(boxName: AppBoxes.incomeRepeatTypes)
//             .values
//             .where((element) =>
//                 element.dailyIncomeModel.incomeId == theAddedIncome.id)
//             .single;
//     print('Before Edit Daily ${theMatchingDailyIncome.lastConfirmationDate}');
//     theMatchingDailyIncome.lastConfirmationDate = today;
//     theMatchingDailyIncome.nextShownDate = today.add(const Duration(days: 1));
//     theMatchingDailyIncome.lastShownDate = today;
//     return theMatchingDailyIncome;
//   }
//
//   /// ahmed elsherif refactored till here.
//   Future saveDailyIncomeAndAddToRepeatBox(
//       DailyIncomeModel theMatchingDailyIncome) async {
//     await theMatchingDailyIncome.save().then((value) =>
//         addIncomeToBoxFromRepeatedBox(
//             currentIncomeModel: theMatchingDailyIncome.dailyIncomeModel));
//   }
//
//   Future saveDailyIncomeNoConfirm(
//       DailyIncomeModel theMatchingDailyIncome) async {
//     await theMatchingDailyIncome.save();
//   }
//
//   Future saveWeeklyIncomeNoConfirm(
//       WeeklyIncomeModel theMatchingWeeklyIncomeModel) async {
//     await theMatchingWeeklyIncomeModel.save();
//   }
//
//   Future saveMonthlyIncomeNoConfirm(
//       MonthlyIncomeModel theMatchingMonthlyIncomeModel) async {
//     await theMatchingMonthlyIncomeModel.save();
//   }
//
//   WeeklyIncomeModel editWeeklyIncomeLastShown(
//       {required IncomeModel theAddedIncome, required DateTime today}) {
//     WeeklyIncomeModel theMatchingWeeklyIncomeModel =
//         Hive.box<WeeklyIncomeModel>('WeeklyIncomeModel')
//             .values
//             .where((element) =>
//                 element.weekIncomeModel.incomeId == theAddedIncome.incomeId)
//             .single;
//
//     // the right last confirmation date is below
//     theMatchingWeeklyIncomeModel.weekLastConfirmationDate = today;
//     theMatchingWeeklyIncomeModel.nextShownDate = today.add(Duration(days: 7));
//     theMatchingWeeklyIncomeModel.weekLastShownDate = today;
//     return theMatchingWeeklyIncomeModel;
//   }
//
//   Future saveWeeklyIncomeAndAddToRepeatBox(
//       WeeklyIncomeModel theMatchingWeeklyIncomeModel) async {
//     await theMatchingWeeklyIncomeModel.save().then((value) =>
//         addIncomeToBoxFromRepeatedBox(
//             currentIncomeModel: theMatchingWeeklyIncomeModel.weekIncomeModel));
//   }
//
//   MonthlyIncomeModel editMonthlyIncomeLastShown(
//       {required IncomeModel theAddedIncome, required DateTime today}) {
//     MonthlyIncomeModel theMatchingMonthlyIncomeModel =
//         Hive.box<MonthlyIncomeModel>('MonthlyIncomeModel')
//             .values
//             .where((element) =>
//                 element.monthIncomeModel.incomeId == theAddedIncome.incomeId)
//             .single;
//
//     theMatchingMonthlyIncomeModel.monthLastConfirmationDate = today;
//     theMatchingMonthlyIncomeModel.nextShownDate = today.add(Duration(days: 30));
//     theMatchingMonthlyIncomeModel.monthLastShownDate = today;
//     return theMatchingMonthlyIncomeModel;
//   }
//
//   Future saveMonthlyIncomeAndAddToRepeatBox(
//       MonthlyIncomeModel theMatchingMonthlyIncomeModel) async {
//     await theMatchingMonthlyIncomeModel.save().then((value) =>
//         addIncomeToBoxFromRepeatedBox(
//             currentIncomeModel:
//                 theMatchingMonthlyIncomeModel.monthIncomeModel));
//   }
//
//   NoRepeatIncomeModel editNoRepeatIncomeLastShown(
//       {required IncomeModel theAddedIncome, required DateTime today}) {
//     NoRepeatIncomeModel theMatchingNoRepIncomeModel =
//         Hive.box<NoRepeatIncomeModel>('NoRepeatIncomeModel')
//             .values
//             .where((element) =>
//                 element.noRepIncomeModel.incomeId == theAddedIncome.incomeId)
//             .single;
//
//     theMatchingNoRepIncomeModel.noRepLastConfirmationDate = today;
//     theMatchingNoRepIncomeModel.noRepLastShownDate = today;
//     theMatchingNoRepIncomeModel.nextShownDate = today;
//     return theMatchingNoRepIncomeModel;
//   }
//
//   Future saveNoRepeatIncomeAndDeleteRepeatBox(
//       NoRepeatIncomeModel theMatchingNoRepIncomeModel) async {
//     await addIncomeToBoxFromRepeatedBox(
//             currentIncomeModel: theMatchingNoRepIncomeModel.noRepIncomeModel)
//         .then((value) => theMatchingNoRepIncomeModel.delete());
//   }
//
//   Future deleteNoRepeatIncome(
//       NoRepeatIncomeModel theMatchingNoRepIncomeModel) async {
//     await theMatchingNoRepIncomeModel.delete();
//   }
//
//   Future<void> onYesConfirmed(
//       {String? currentRepeatType, required IncomeModel theAddedIncome}) async {
//     DateTime today = DateTime.now();
//     if (currentRepeatType == 'Daily') {
//       DailyIncomeModel theEditedDailyIncome = editDailyIncomeLastShown(
//           theAddedIncome: theAddedIncome, today: today);
//       await saveDailyIncomeAndAddToRepeatBox(theEditedDailyIncome);
//       // print('After Edit Daily ${theMatchingDailyExpense.lastConfirmationDate}');
//
//     }
//     if (currentRepeatType == 'Weekly') {
//       WeeklyIncomeModel theEditedWeeklyIncome = editWeeklyIncomeLastShown(
//           theAddedIncome: theAddedIncome, today: today);
//       await saveWeeklyIncomeAndAddToRepeatBox(theEditedWeeklyIncome);
//     }
//     if (currentRepeatType == 'Monthly') {
//       MonthlyIncomeModel theEditedMonthlyIncome = editMonthlyIncomeLastShown(
//           theAddedIncome: theAddedIncome, today: today);
//       saveMonthlyIncomeAndAddToRepeatBox(theEditedMonthlyIncome);
//     }
//     if (currentRepeatType == 'No Repeat') {
//       NoRepeatIncomeModel theEditedNoRepeatedIncome =
//           editNoRepeatIncomeLastShown(
//               theAddedIncome: theAddedIncome, today: today);
//       await saveNoRepeatIncomeAndDeleteRepeatBox(theEditedNoRepeatedIncome);
//     }
//   }
//
//   Future<void> onNoConfirmed(
//       {String? currentRepeatType, required IncomeModel theAddedIncome}) async {
//     DateTime today = DateTime.now();
//     if (currentRepeatType == 'Daily') {
//       DailyIncomeModel theEditedDailyIncome = editDailyIncomeLastShown(
//           theAddedIncome: theAddedIncome, today: today);
//       await saveDailyIncomeNoConfirm(theEditedDailyIncome);
//     }
//     if (currentRepeatType == 'Weekly') {
//       WeeklyIncomeModel theMatchingWeeklyIncomeModel =
//           editWeeklyIncomeLastShown(
//               theAddedIncome: theAddedIncome, today: today);
//       await saveWeeklyIncomeNoConfirm(theMatchingWeeklyIncomeModel);
//     }
//     if (currentRepeatType == 'Monthly') {
//       MonthlyIncomeModel theEditedMonthlyIncome = editMonthlyIncomeLastShown(
//           theAddedIncome: theAddedIncome, today: today);
//       await saveMonthlyIncomeNoConfirm(theEditedMonthlyIncome);
//     }
//     if (currentRepeatType == 'No Repeat') {
//       NoRepeatIncomeModel theEditedNoRepeatIncome = editNoRepeatIncomeLastShown(
//           theAddedIncome: theAddedIncome, today: today);
//       await deleteNoRepeatIncome(theEditedNoRepeatIncome);
//     }
//   }
// }
