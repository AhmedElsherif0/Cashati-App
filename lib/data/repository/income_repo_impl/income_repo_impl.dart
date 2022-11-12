// // class IncomeRepositoryImpl implements  IncomeRepository {
//
//
// Future<void> addIncomeToIncomeBox({
//   required String incomeName,
//   required num incomeAmount,
//   required String incomeMainCateg,
//   required String incomeSubCateg,
//   required String incomeComment,
//   required String incomeRepeat,
//   required DateTime incomePaymentDate,
//   required DateTime incomeCreatedDate,
// })async {
//
//   final  incomeModel=IncomeModel.copyWith(
//       incomeId: GUIDGen.generate(),
//       incomeName: incomeName,
//       incomeAmount: incomeAmount,
//       incomeMainCateg: incomeMainCateg,
//       incomeSubCateg: incomeSubCateg,
//       incomeComment:incomeComment ,
//       incomeRepeat: incomeRepeat,
//       incomeAddAuto: false,
//       incomeReceived: false,
//       isReceiveNotification: false,
//       incomeCreatedDate: incomeCreatedDate,
//       incomePaymentDate: incomePaymentDate
//   );
//
//
//   final allIncomeBox=Boxes.fetchIncomeModelBox();
//   if(isEqualToday(date: incomeModel.incomePaymentDate)){
//     await allIncomeBox.add(incomeModel);
//     await addToRepeatedBoxes(incomeModel.incomeRepeat,incomeModel);
//   }else{
//     await addToRepeatedBoxes(incomeModel.incomeRepeat,incomeModel);
//   }
//
//
//   print('Income values are ${allIncomeBox.values}');
// }
// Future<void> addToRepeatedBoxes(String repeat,IncomeModel incomeModel)async{
//   if(repeat==AppStrings.daily)
//   {
//     addDailyIncomeToRepeatedBox(incomeModel);
//   }else if(repeat==AppStrings.weekly){
//     addWeeklyIncomeToRepeatedBox(incomeModel);
//
//   }else if(repeat==AppStrings.monthly){
//     addMonthlyIncomeToRepeatedBox(incomeModel);
//   }else if(repeat==AppStrings.noRepeat){
//     addNoRepeatIncomeToRepeatedBox(incomeModel);
//   }
// }
// DateTime putNextShownDate({required DateTime incomePaymentDate,required String repeatType}){
//   DateTime today=DateTime.now();
//   switch(repeatType){
//     case 'Daily':
//
//       return incomePaymentDate;
//
//     case 'Weekly':
//     //if(expensePaymentDate.day==today.day&&expensePaymentDate.month==today.month&&expensePaymentDate.year==today.year){
//       if(incomePaymentDate.difference(today).inDays==0){
//         return incomePaymentDate.add(Duration(days: 7));
//       }else{
//         // return expensePaymentDate.add(Duration(days: 7));
//         // the right return is below
//         return incomePaymentDate;
//       }
//     case 'Monthly':
//       if(incomePaymentDate.difference(today).inDays==0){
//         return incomePaymentDate.add(Duration(days: 30));
//       }else{
//         return incomePaymentDate;
//       }
//     case 'No Repeat':
//       return incomePaymentDate;
//
//     default:
//       return today;
//   }
//
// }
// bool isEqualToday({required DateTime date}){
//   //DateTime today=DateTime(2022,12,5);
//
//
//   // the right today is below
//   DateTime today=DateTime.now();
//   // if(today.difference(date).inDays==0){
//   if(today.day==date.day&&today.month==today.month&&today.year==date.year){
//     return true;
//   }else{
//     return false;
//   }
// }
// Future addDailyIncomeToRepeatedBox(IncomeModel incomeModel)async{
//   //TODO add copyWith so we can put paramaters
//   DateTime today =DateTime.now();
//   final box=Boxes.fetchDailyIncomeBox();
//   final DailyIncomeModel dailyIncomeModel=DailyIncomeModel.copyWith(
//       dailyIncomeModel: incomeModel,
//       lastConfirmationDate: today,
//       nextShownDate: putNextShownDate(
//           incomePaymentDate:  incomeModel.incomePaymentDate
//           , repeatType: AppStrings.daily),
//       lastShownDate: today,
//       isLastConfirmed: false,
//       creationDate: today);
//
//   await box.add(dailyIncomeModel);
//
// }
// Future addWeeklyIncomeToRepeatedBox(IncomeModel incomeModel)async{
//   //TODO add copyWith so we can put paramaters
//   DateTime today =DateTime.now();
//   final box=Boxes.fetchWeeklyIncomeBox();
//   final WeeklyIncomeModel weeklyIncomeModel=WeeklyIncomeModel.copyWith(
//       weekIncomeModel: incomeModel,
//       weekLastConfirmationDate: today,
//       nextShownDate: putNextShownDate(
//           incomePaymentDate:  incomeModel.incomePaymentDate
//           , repeatType: 'Weekly'),
//       weekLastShownDate: today,
//       weekIsLastConfirmed: false,
//       weekCreationDate: today);
//
//   await box.add(weeklyIncomeModel);
//
// }
// Future addMonthlyIncomeToRepeatedBox(IncomeModel incomeModel)async{
//   //TODO add copyWith so we can put paramaters
//   DateTime today =DateTime.now();
//   final monthlyBox=Boxes.fetchMonthlyIncomeBox();
//   final MonthlyIncomeModel monthlyIncomeModel=MonthlyIncomeModel.copyWith(
//       monthIncomeModel: incomeModel,
//       monthLastConfirmationDate:today ,
//       nextShownDate: putNextShownDate(incomePaymentDate: incomeModel.incomePaymentDate, repeatType: AppStrings.monthly),
//       monthLastShownDate: today,
//       monthIsLastConfirmed: false,
//       monthCreationDate: today);
//
//   await monthlyBox.add(monthlyIncomeModel);
//
// }
// Future addNoRepeatIncomeToRepeatedBox(IncomeModel incomeModel)async{
//   //TODO add copyWith so we can put paramaters
//   DateTime today =DateTime.now();
//   final noRepeatBox=Boxes.fetchNoRepeatIncomeBox();
//   final NoRepeatIncomeModel noRepeatIncomeModel=NoRepeatIncomeModel.copyWith(
//       noRepLastShownDate: putNextShownDate(incomePaymentDate:incomeModel.incomePaymentDate,
//           repeatType: 'No Repeat'
//       ),
//       noRepLastConfirmationDate: today,
//       nextShownDate: incomeModel.incomePaymentDate,
//       noRepIsLastConfirmed: false,
//       noRepCreationDate: today,
//       noRepIncomeModel: incomeModel);
//
//   await noRepeatBox.add(noRepeatIncomeModel);
//
// }
//
//
//
//
// //}