//class ConfirmExpenseRepo implements  ConfirmExpenseRepo {
//
//
//   Future<void> addExpenseToBoxFromRepeatedBox({required ExpenseModel currentExpenseModel, num? newAmount})async {
//     DateTime today=DateTime.now();
//     final ExpenseModel  expenseModel=currentExpenseModel;
//     expenseModel.expenseAmount=newAmount??currentExpenseModel.expenseAmount;
//     expenseModel.expenseId=GUIDGen.generate();
//     expenseModel.expensePaymentDate=today;
//     expenseModel.expenseCreatedDate=today;
//
//
//     final allExpensesModel=Boxes.getExpensesModelBox();
//
//     await allExpensesModel.add(expenseModel);
//
//     print('Expenses values are ${allExpensesModel.values}');
//   }
//
//
//   List<ExpenseModel> getTodayPayments(){
//     Box<DailyExpenseModel> dailyBox=Hive.box('DailyExpenseModel');
//     Box<WeeklyExpenseModel> weeklyBox=Hive.box('WeeklyExpenseModel');
//     Box<MonthlyExpenseModel> monthlyBox=Hive.box('MonthlyExpenseModel');
//     Box<NoRepeatExpenseModel> noRepBox=Hive.box('NoRepeatExpenseModel');
//     List<DailyExpenseModel>dailyList=dailyBox.values.toList().cast<DailyExpenseModel>();
//     List<WeeklyExpenseModel>weeklyList=weeklyBox.values.toList().cast<WeeklyExpenseModel>();
//     List<MonthlyExpenseModel>monthlyList=monthlyBox.values.toList().cast<MonthlyExpenseModel>();
//     List<NoRepeatExpenseModel>noRepList=noRepBox.values.toList().cast<NoRepeatExpenseModel>();
//     List<ExpenseModel> todayList=[];
//     for(var item in dailyList){
//
//       // here we check confirmation date  Slide number 12
//       if(!checkSameDay(date: item.lastConfirmationDate)){
//         todayList.add(item.dailyExpenseModel);
//       }
//     }
//     for(var item in weeklyList){
//       if(checkSameDay(date: item.nextShownDate
//       )&&!checkSameDay(date: item.weekLastConfirmationDate) ||
//           checkNoConfirmedAndWeekly(
//               nextShownDate: item.nextShownDate,
//               lastConfirmedDate: item.weekLastConfirmationDate,
//               expensePayment: item.weekExpenseModel.expensePaymentDate)
//       ){
//         todayList.add(item.weekExpenseModel);
//       }
//     }
//     for(var item in monthlyList){
//       if(checkSameDay(date: item.nextShownDate )
//           &&!checkSameDay(date: item.monthLastConfirmationDate)||
//           checkNoConfirmedAndMonthly(
//               nextShownDate: item.nextShownDate,
//               lastConfirmedDate: item.monthLastConfirmationDate,
//               expensePayment: item.monthExpenseModel.expensePaymentDate)){
//         todayList.add(item.monthExpenseModel);
//       }
//     }
//     for(var item in noRepList){
//       if(checkSameDay(date: item.nextShownDate)
//           &&!checkSameDay(date: item.noRepLastConfirmationDate)){
//         todayList.add(item.noRepExpenseModel);
//       }
//
//     }
//
//     return todayList;
//   }
//   bool weeklyShowCheckings(WeeklyExpenseModel weeklyExpenseModel){
//     if(checkSameDay(date: weeklyExpenseModel.nextShownDate
//     )&&!checkSameDay(date: weeklyExpenseModel.weekLastConfirmationDate) ||
//         checkNoConfirmedAndWeekly(
//             nextShownDate: weeklyExpenseModel.nextShownDate,
//             lastConfirmedDate: weeklyExpenseModel.weekLastConfirmationDate,
//             expensePayment: weeklyExpenseModel.weekExpenseModel.expensePaymentDate)
//     ){
//       return true;
//     }else{
//       return false;
//     }
//   }
//   bool checkSameDay({required DateTime date}){
//     //DateTime today=DateTime(2022,12,5);
//
//
//     // the right today is below
//     DateTime today=DateTime.now();
//     // if(today.difference(date).inDays==0){
//     if(today.day==date.day&&today.month==today.month){
//       return true;
//     }else{
//       return false;
//     }
//   }
//   bool checkNoConfirmedAndWeekly({required DateTime nextShownDate,required DateTime lastConfirmedDate, required DateTime expensePayment}){
//
//
//     // for showing the payment weekly if it is not the same expense date day
//     final DateTime today=DateTime.now();
//     if(
//     //today.difference(expensePayment).inDays!=0&&
//     !checkSameDay(date: expensePayment)&&
//         today.difference(nextShownDate).inDays%7==0
//        // &&today.difference(lastConfirmedDate).inDays!=0
//         &&!checkSameDay(date: lastConfirmedDate)
//     ){
//       return true;
//     }else{
//       return false;
//     }
//   }
//   bool checkNoConfirmedAndMonthly({required DateTime nextShownDate,required DateTime lastConfirmedDate, required DateTime expensePayment}){
//     // for showing the payment weekly if he didn't take action
//     final DateTime today=DateTime.now();
//     if(
//     //today.difference(expensePayment).inDays!=0&&
//    !checkSameDay(date: expensePayment)&&
//         today.difference(nextShownDate).inDays%30==0
//         //&&today.difference(lastConfirmedDate).inDays!=0
//         &&!checkSameDay(date: lastConfirmedDate)
//    // &&expensePayment.isAfter(today)
//     ){
//       return true;
//     }else{
//       return false;
//     }
//   }
//
// // when Yes
//   DailyExpenseModel editDailyExpenseLastShown({required ExpenseModel theAddedExpense,required DateTime today}){
//     DailyExpenseModel theMatchingDailyExpense=Hive.box<DailyExpenseModel>('DailyExpenseModel').values.
//     where((element) => element.dailyExpenseModel.expenseId==theAddedExpense.expenseId).single;
//     print('Before Edit Daily ${theMatchingDailyExpense.lastConfirmationDate}');
//     theMatchingDailyExpense.lastConfirmationDate=today;
//     theMatchingDailyExpense.nextShownDate=today.add(Duration(days: 1));
//     theMatchingDailyExpense.lastShownDate=today;
//     return theMatchingDailyExpense;
//   }
//   Future saveDailyExpenseAndAddToRepeatBox(DailyExpenseModel theMatchingDailyExpense)async{
//     await theMatchingDailyExpense.save().then((value) => addExpenseToBoxFromRepeatedBox(currentExpenseModel: theMatchingDailyExpense.dailyExpenseModel));
//
//   }
//
//
//
//   Future saveDailyExpenseNoConfirm(DailyExpenseModel theMatchingDailyExpense)async{
//     await theMatchingDailyExpense.save();
//   }
//   Future saveWeeklyExpenseNoConfirm(WeeklyExpenseModel theMatchingWeeklyExpenseModel)async{
//     await theMatchingWeeklyExpenseModel.save();
//   }
//   Future saveMonthlyExpenseNoConfirm(MonthlyExpenseModel theMatchingMonthlyExpenseModel)async{
//     await theMatchingMonthlyExpenseModel.save();
//   }
//
//
//
//   WeeklyExpenseModel editWeeklyExpenseLastShown({required ExpenseModel theAddedExpense,required DateTime today}){
//     WeeklyExpenseModel theMatchingWeeklyExpenseModel= Hive.box<WeeklyExpenseModel>('WeeklyExpenseModel').values.
//     where((element) => element.weekExpenseModel.expenseId==theAddedExpense.expenseId).single;
//
//     // the right last confirmation date is below
//     theMatchingWeeklyExpenseModel.weekLastConfirmationDate=today;
//     theMatchingWeeklyExpenseModel.nextShownDate=today.add(Duration(days: 7));
//     theMatchingWeeklyExpenseModel.weekLastShownDate=today;
//     return theMatchingWeeklyExpenseModel;
//
//   }
//   Future saveWeeklyExpenseAndAddToRepeatBox(WeeklyExpenseModel theMatchingWeeklyExpenseModel)async{
//     await theMatchingWeeklyExpenseModel.save().then((value) => addExpenseToBoxFromRepeatedBox(currentExpenseModel:theMatchingWeeklyExpenseModel.weekExpenseModel));
//
//   }
//
//   MonthlyExpenseModel editMonthlyExpenseLastShown({required ExpenseModel theAddedExpense,required DateTime today}){
//     MonthlyExpenseModel theMatchingMonthlyExpenseModel= Hive.box<MonthlyExpenseModel>('MonthlyExpenseModel').values.
//     where((element) => element.monthExpenseModel.expenseId==theAddedExpense.expenseId).single;
//
//     theMatchingMonthlyExpenseModel.monthLastConfirmationDate=today;
//     theMatchingMonthlyExpenseModel.nextShownDate=today.add(Duration(days: 30));
//     theMatchingMonthlyExpenseModel.monthLastShownDate=today;
//     return theMatchingMonthlyExpenseModel;
//
//   }
//   Future saveMonthlyExpenseAndAddToRepeatBox(MonthlyExpenseModel theMatchingMonthlyExpenseModel)async{
//     await theMatchingMonthlyExpenseModel.save().then((value) => addExpenseToBoxFromRepeatedBox(currentExpenseModel:theMatchingMonthlyExpenseModel.monthExpenseModel));
//   }
//
//
//   NoRepeatExpenseModel editNoRepeatExpenseLastShown({required ExpenseModel theAddedExpense,required DateTime today}){
//     NoRepeatExpenseModel theMatchingNoRepExpenseModel= Hive.box<NoRepeatExpenseModel>('NoRepeatExpenseModel').values.
//     where((element) => element.noRepExpenseModel.expenseId==theAddedExpense.expenseId).single;
//
//     theMatchingNoRepExpenseModel.noRepLastConfirmationDate=today;
//     theMatchingNoRepExpenseModel.noRepLastShownDate=today;
//     theMatchingNoRepExpenseModel.nextShownDate=today;
//     return theMatchingNoRepExpenseModel;
//   }
//   Future saveNoRepeatExpenseAndDeleteRepeatBox(NoRepeatExpenseModel theMatchingNoRepExpenseModel)async{
//     await addExpenseToBoxFromRepeatedBox(currentExpenseModel:theMatchingNoRepExpenseModel.noRepExpenseModel).then((value) => theMatchingNoRepExpenseModel.delete());  }
//   Future deleteNoRepeatExpense(NoRepeatExpenseModel theMatchingNoRepExpenseModel)async{
//     await theMatchingNoRepExpenseModel.delete();
//   }
//
//
//   Future<void> onYesConfirmed({
//     required String currentRepeatType,
//     required ExpenseModel theAddedExpense})async{
//     DateTime today=DateTime.now();
//     print('working yes ..');
//     try{
//       if(currentRepeatType=='Daily'){
//
//         DailyExpenseModel theEditedDailyExpense= editDailyExpenseLastShown(theAddedExpense: theAddedExpense,today: today);
//         await saveDailyExpenseAndAddToRepeatBox(theEditedDailyExpense);
//         // print('After Edit Daily ${theMatchingDailyExpense.lastConfirmationDate}');
//
//       }if(currentRepeatType=='Weekly'){
//
//         WeeklyExpenseModel theEditedWeeklyExpense= editWeeklyExpenseLastShown(theAddedExpense: theAddedExpense, today: today);
//         await saveWeeklyExpenseAndAddToRepeatBox(theEditedWeeklyExpense);
//
//
//       }if(currentRepeatType=='Monthly'){
//
//         MonthlyExpenseModel theEditedMonthlyExpense= editMonthlyExpenseLastShown(theAddedExpense: theAddedExpense, today: today);
//         saveMonthlyExpenseAndAddToRepeatBox(theEditedMonthlyExpense);
//
//       }if(currentRepeatType=='No Repeat'){
//
//
//         NoRepeatExpenseModel theEditedNoRepeatedExpense= editNoRepeatExpenseLastShown(theAddedExpense: theAddedExpense,today: today);
//         await saveNoRepeatExpenseAndDeleteRepeatBox(theEditedNoRepeatedExpense);
//       }
//
//
//     }catch(error){
//       print('error on yes is $error');
//     }
//
// }
//   Future<void> onNoConfirmed({
//     required String currentRepeatType,
//     required ExpenseModel theAddedExpense})async{
//     DateTime today=DateTime.now();
//     if(currentRepeatType=='Daily'){
//       DailyExpenseModel theEditedDailyExpense=editDailyExpenseLastShown(theAddedExpense: theAddedExpense,today: today);
//       await saveDailyExpenseNoConfirm(theEditedDailyExpense);
//     }if(currentRepeatType=='Weekly'){
//
//       WeeklyExpenseModel theMatchingWeeklyExpenseModel=editWeeklyExpenseLastShown(theAddedExpense: theAddedExpense,today: today);
//       await saveWeeklyExpenseNoConfirm(theMatchingWeeklyExpenseModel);
//
//     }if(currentRepeatType=='Monthly'){
//
//       MonthlyExpenseModel theEditedMonthlyExpense=editMonthlyExpenseLastShown(theAddedExpense: theAddedExpense,today: today);
//       await saveMonthlyExpenseNoConfirm(theEditedMonthlyExpense);
//
//     }if(currentRepeatType=='No Repeat'){
//
//    NoRepeatExpenseModel theEditedNoRepeatExpense=  editNoRepeatExpenseLastShown(theAddedExpense: theAddedExpense, today: today);
//   await deleteNoRepeatExpense(theEditedNoRepeatExpense);
//
//     }
//
//   }
// }