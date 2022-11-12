// class ExpensesRepositoryImpl implements  ExpensesRepository {
//
// Future<void> addExpenseToExpensesBox({
//   required String expenseName,
//   required num expenseAmount,
//   required String expenseMainCateg,
//   required String expenseSubCateg,
//   required String expenseComment,
//   required String expenseRepeat,
//   required bool expensePriority,
//   required bool isExpensePaid,
//   required DateTime expensePaymentDate,
//   required DateTime expenseCreatedDate,
// })async {
//
//   final  expenseModel=ExpenseModel.copyWith(
//       expenseAmount: expenseAmount,
//       expenseComment: expenseComment,
//       expenseId:GUIDGen.generate() ,
//       expenseName:expenseName ,
//       expenseRepeat: expenseRepeat,
//       expenseMainCateg: expenseMainCateg,
//       expenseAddAuto: false,
//       expensePriority: expensePriority,
//       expenseSubCateg: expenseSubCateg,
//       isReceiveNotification: false,
//       isExpensePaid: isEqualToday(date: expensePaymentDate),
//       expenseCreatedDate: DateTime.now(),
//       expensePaymentDate: expensePaymentDate);
//
//
//   final allExpensesModel=Boxes.getExpensesModelBox();
//   if(isEqualToday(date: expenseModel.expensePaymentDate)){
//     await allExpensesModel.add(expenseModel);
//     await addToRepeatedBoxes(expenseModel.expenseRepeat,expenseModel);
//   }else{
//     await addToRepeatedBoxes(expenseModel.expenseRepeat,expenseModel);
//   }
//
//
//   print('Expenses values are ${allExpensesModel.values}');
// }
// Future<void> addToRepeatedBoxes(String repeat,ExpenseModel expenseModel)async{
//   if(repeat==AppStrings.daily)
//   {
//     addDailyExpenseToRepeatedBox(expenseModel);
//   }else if(repeat==AppStrings.weekly){
//     addWeeklyExpenseToRepeatedBox(expenseModel);
//
//   }else if(repeat==AppStrings.monthly){
//     addMonthlyExpenseToRepeatedBox(expenseModel);
//   }else if(repeat==AppStrings.noRepeat){
//     addNoRepeatExpenseToRepeatedBox(expenseModel);
//   }
// }
// DateTime putNextShownDate({required DateTime expensePaymentDate,required String repeatType}){
//   DateTime today=DateTime.now();
//   switch(repeatType){
//     case 'Daily':
//
//       return expensePaymentDate;
//
//     case 'Weekly':
//     //if(expensePaymentDate.day==today.day&&expensePaymentDate.month==today.month&&expensePaymentDate.year==today.year){
//       if(
//
//       // expensePaymentDate.difference(today).inDays==0
//       checkSameDay(date: expensePaymentDate)
//       ){
//         return expensePaymentDate.add(Duration(days: 7));
//       }else{
//         // return expensePaymentDate.add(Duration(days: 7));
//         // the right return is below
//         return expensePaymentDate;
//       }
//     case 'Monthly':
//       if(
//       //expensePaymentDate.difference(today).inDays==0
//       checkSameDay(date: expensePaymentDate)
//       ){
//         return expensePaymentDate.add(Duration(days: 30));
//       }else{
//         return expensePaymentDate;
//       }
//     case 'No Repeat':
//       return expensePaymentDate;
//
//     default:
//       return DateTime.now();
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
// Future addDailyExpenseToRepeatedBox(ExpenseModel expenseModel)async{
//   //TODO add copyWith so we can put paramaters
//   DateTime today =DateTime.now();
//   final box=Boxes.getDailyExpensesModelBox();
//   final DailyExpenseModel dailyExpenseModel=DailyExpenseModel();
//   dailyExpenseModel.dailyExpenseModel=expenseModel;
//   dailyExpenseModel.creationDate=today;
//   dailyExpenseModel.isLastConfirmed=false;
//   dailyExpenseModel.lastShownDate=today;
//   dailyExpenseModel.nextShownDate=putNextShownDate(
//       expensePaymentDate:  expenseModel.expensePaymentDate
//       , repeatType: 'Daily');
//   dailyExpenseModel.lastConfirmationDate=today;
//   await box.add(dailyExpenseModel);
//
// }
// Future addWeeklyExpenseToRepeatedBox(ExpenseModel expenseModel)async{
//   //TODO add copyWith so we can put paramaters
//   DateTime today =DateTime.now();
//   final box=Boxes.getWeeklyExpensesModelBox();
//   final WeeklyExpenseModel weeklyExpenseModel=WeeklyExpenseModel();
//   weeklyExpenseModel.weekExpenseModel=expenseModel;
//   weeklyExpenseModel.weekCreationDate=today;
//   weeklyExpenseModel.weekIsLastConfirmed=false;
//   weeklyExpenseModel.weekLastShownDate=today;
//   weeklyExpenseModel.weekLastConfirmationDate=today;
//   // the right confirmation date is below
//   // weeklyExpenseModel.weekLastConfirmationDate=DateTime.now();
//   weeklyExpenseModel.nextShownDate=putNextShownDate(
//       expensePaymentDate:  expenseModel.expensePaymentDate
//       , repeatType: 'Weekly');
//   await box.add(weeklyExpenseModel);
//
// }
// Future addMonthlyExpenseToRepeatedBox(ExpenseModel expenseModel)async{
//   //TODO add copyWith so we can put paramaters
//   DateTime today =DateTime.now();
//   final monthlyBox=Boxes.getMonthlyExpensesModelBox();
//   final MonthlyExpenseModel monthlyExpenseModel=MonthlyExpenseModel();
//   monthlyExpenseModel.monthExpenseModel=expenseModel;
//   monthlyExpenseModel.monthCreationDate=today;
//   monthlyExpenseModel.monthIsLastConfirmed=false;
//   monthlyExpenseModel.monthLastShownDate=today;
//   // monthlyExpenseModel.monthLastConfirmationDate=expenseModel.expensePaymentDate;
//   monthlyExpenseModel.monthLastConfirmationDate=today;
//   monthlyExpenseModel.nextShownDate=putNextShownDate(
//       expensePaymentDate:  expenseModel.expensePaymentDate
//       , repeatType: 'Monthly');
//   await monthlyBox.add(monthlyExpenseModel);
//
// }
// Future addNoRepeatExpenseToRepeatedBox(ExpenseModel expenseModel)async{
//   //TODO add copyWith so we can put paramaters
//   DateTime today =DateTime.now();
//   final noRepeatBox=Boxes.getNoRepeatExpensesBox();
//   final NoRepeatExpenseModel noRepeatExpenseModel=NoRepeatExpenseModel();
//   noRepeatExpenseModel.noRepExpenseModel=expenseModel;
//   noRepeatExpenseModel.noRepCreationDate=today;
//   noRepeatExpenseModel.noRepIsLastConfirmed=false;
//   noRepeatExpenseModel.noRepLastShownDate=putNextShownDate(expensePaymentDate:expenseModel.expensePaymentDate,
//       repeatType: 'No Repeat'
//   );
//   noRepeatExpenseModel.noRepLastConfirmationDate=today;
//   noRepeatExpenseModel.nextShownDate=expenseModel.expensePaymentDate;
//   await noRepeatBox.add(noRepeatExpenseModel);
//
//  }