/*
import '../../../data/models/income/income_repeat_details_model.dart';
import '../../../data/models/income/income_model.dart';
import '../../../data/models/income/income_types_model.dart';
import '../../../data/models/income/no_repeat_income_model.dart';
import '../../../data/models/income/weekly_income_model.dart';

abstract class ConfirmIncomeRepo {

Future<void> addIncomeToBoxFromRepeatedBox({required IncomeModel currentIncomeModel, num? newAmount});


List<IncomeModel> getTodayPayments();
bool checkSameDay({required DateTime date});
bool checkNoConfirmedAndWeekly({required DateTime nextShownDate,required DateTime lastConfirmedDate, required DateTime incomePayment});
bool checkNoConfirmedAndMonthly({required DateTime nextShownDate,required DateTime lastConfirmedDate, required DateTime incomePayment});

// when Yes
IncomeRepeatDetailsModel editDailyIncomeLastShown({required IncomeModel theAddedIncome,required DateTime today});
Future saveDailyIncomeAndAddToRepeatBox(IncomeRepeatDetailsModel theMatchingDailyIncome);



Future saveDailyIncomeNoConfirm(IncomeRepeatDetailsModel theMatchingDailyIncome);
Future saveWeeklyIncomeNoConfirm(WeeklyIncomeModel theMatchingWeeklyIncomeModel);
Future saveMonthlyIncomeNoConfirm(MonthlyIncomeModel theMatchingMonthlyIncomeModel);



WeeklyIncomeModel editWeeklyIncomeLastShown({required IncomeModel theAddedIncome,required DateTime today});
Future saveWeeklyIncomeAndAddToRepeatBox(WeeklyIncomeModel theMatchingWeeklyIncomeModel);

MonthlyIncomeModel editMonthlyIncomeLastShown({required IncomeModel theAddedIncome,required DateTime today});
Future saveMonthlyIncomeAndAddToRepeatBox(MonthlyIncomeModel theMatchingMonthlyIncomeModel);


NoRepeatIncomeModel editNoRepeatIncomeLastShown({required IncomeModel theAddedIncome,required DateTime today});
Future saveNoRepeatIncomeAndDeleteRepeatBox(NoRepeatIncomeModel theMatchingNoRepIncomeModel);
Future deleteNoRepeatIncome(NoRepeatIncomeModel theMatchingNoRepIncomeModel);


Future<void> onYesConfirmed({
  String? currentRepeatType,
  required IncomeModel theAddedIncome});
Future<void> onNoConfirmed({
  String? currentRepeatType,
  required IncomeModel theAddedIncome});

}*/
