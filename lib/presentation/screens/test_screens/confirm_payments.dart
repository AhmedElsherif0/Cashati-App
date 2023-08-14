import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:temp/business_logic/repository/expenses_repo/confirm_expense_repo.dart';
import 'package:temp/business_logic/repository/goals_repo/goals_repo.dart';
import 'package:temp/constants/app_strings.dart';
import 'package:temp/data/local/hive/app_boxes.dart';
import 'package:temp/data/models/goals/goal_model.dart';
import 'package:temp/data/models/transactions/transaction_details_model.dart';
import 'package:temp/data/models/transactions/transaction_model.dart';
import 'package:temp/data/repository/transactions_impl/confirm_transaction_repo_impl.dart';
import 'package:temp/data/repository/goals_repo_impl/goals_repo_impl.dart';

/*

class ConfirmPaymentsScreen extends StatefulWidget {
  const ConfirmPaymentsScreen({Key? key}) : super(key: key);

  @override
  _ConfirmPaymentsScreenState createState() => _ConfirmPaymentsScreenState();
}

class _ConfirmPaymentsScreenState extends State<ConfirmPaymentsScreen> {
  ConfirmTransactionRepo _transactionRep=ConfirmTransactionImpl();
  GoalsRepository _goalsRepository=GoalsRepoImpl();

    List<TransactionModel> allTodayList=[];
    List<TransactionModel> allTodayListIncome=[];
    List<GoalModel> allTodayGoals=[];
    num? newAmount;
    num? newAmountIncome;
    int currentIndex=0;



  Future<void> onYesConfirmed({

    required TransactionModel theAddedExpense})async{
    print('Yes confirmed');

    try{
      await _transactionRep.onYesConfirmed(addedExpense: theAddedExpense);
    }catch(e){
      print('error is $e');
    }
    setState(() {

    });
  }

  Future<void> onNoConfirmed({

    required TransactionModel theAddedExpense})async{
    print('No confirmed');
    await _transactionRep.onNoConfirmed(addedExpense:  theAddedExpense);
    setState(() {

    });
  }


  Future<void> onYesConfirmedIncome({

    required TransactionModel theAddedIncome})async{
    print('Yes confirmed');

    try{
      await _transactionRep.onYesConfirmed(addedExpense: theAddedIncome);
    }catch(e){
      print('error is $e');
    }
    setState(() {

    });
  }

  Future<void> onNoConfirmedIncome({

    required TransactionModel theAddedIncome})async{
    print('No confirmed');
    await _transactionRep.onNoConfirmed(addedExpense: theAddedIncome,);
    setState(() {

    });
  }


  Future<void> onYesConfirmedGoal({

    required GoalModel goalModel})async{
    print('Yes confirmed');

    try{
      await _goalsRepository.yesConfirmGoal(goalModel: goalModel,newAmount: newAmount);
    }catch(e){
      print('error is $e');
    }
    setState(() {

    });
  }

  Future<void> onNoConfirmedGoal({

    required GoalModel goalModel})async{
    print('No confirmed');
    await _goalsRepository.noConfirmGoal(goalModel: goalModel,newAmount: newAmount);
    setState(() {

    });
  }



  @override
  void initState() {
    allTodayList=List.from(_transactionRep.getTodayPayments(isExpense: true));
    print('all expenses are ${allTodayList}');
    allTodayListIncome=List.from(_transactionRep.getTodayPayments(isExpense: false));
    print('all income are ${allTodayListIncome}');
    allTodayGoals=List.from(_goalsRepository.getTodayGoals());
    print('all Today Goals are ${allTodayGoals}');

    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      initialIndex: currentIndex,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            labelStyle: TextStyle(color: Colors.black),
              unselectedLabelStyle: TextStyle(color: Colors.black) ,
              unselectedLabelColor: Colors.black,
              labelColor: Colors.green,
              onTap: (valu){
                currentIndex=valu;
              },
              tabs: [
                Text('Expense',),
                Text('Income'),
                Text('Goals'),
              ]),
        ),
        body:TabBarView(
        children: [
          expenseConfirmBody(context),
        incomeConfirmBody(context),
          goalsConfirmBody(context)
        ],
        ),
      ),
    );
  }


  Padding incomeConfirmBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(

        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextButton(
            child:Text('Show SnackBars'),
            onPressed: (){
              DateTime todayPlusDay=DateTime.now().add(Duration(days: 1));
              DateTime nextWeek=DateTime.now().add(Duration(days: 7));
              DateTime after28Days=DateTime.now().add(Duration(days: 28));
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Tomorrow is ${todayPlusDay}')));
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('nextWeek is ${nextWeek}')));
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('after28Days ${after28Days}')));
            },
          ),
          allTodayListIncome.isEmpty? Center(child: Text('No Data To confirm'),):allTodayListIncome.isNotEmpty?
          Expanded(
              child:ListView.builder(
                  itemCount:  allTodayListIncome.length,
                  itemBuilder: (context,index) {
                    // showDiff(context,allTodayList[index]);
                    return ExpansionTile(title: Text('${allTodayListIncome[index].name}'),
                      trailing: IconButton(onPressed: (){

                      }, icon: Icon(Icons.delete,color: Colors.red,)),
                      children: [
                        Text('Income Amount ${allTodayListIncome[index].amount}'),
                        Text('Income id ${allTodayListIncome[index].id}'),
                        Text('Income payment date ${allTodayListIncome[index].paymentDate}'),
                        Text('Income created date ${allTodayListIncome[index].createdDate}'),
                        Text('Income Repeat ${allTodayListIncome[index].repeatType}'),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(children: [
                            Spacer(),
                            ElevatedButton(onPressed: ()async{
                            await  onYesConfirmedIncome(theAddedIncome: allTodayListIncome[index]);
                            }, child: Text('Yes')),

                            ElevatedButton(onPressed: ()async{
                              await onNoConfirmedIncome(theAddedIncome: allTodayListIncome[index]);
                            }, child: Text('No')),
                          ],),
                        )
                      ],
                    );
                  }
              ) ):Center(child: CircularProgressIndicator(),)

        ],
      ),
    );
  }

  Padding expenseConfirmBody(BuildContext context) {
     return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(

        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextButton(
            child:Text('Show SnackBars'),
            onPressed: (){
              DateTime todayPlusDay=DateTime.now().add(Duration(days: 1));
              DateTime nextWeek=DateTime.now().add(Duration(days: 7));
              DateTime after28Days=DateTime.now().add(Duration(days: 28));
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Tomorrow is ${todayPlusDay}')));
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('nextWeek is ${nextWeek}')));
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('after28Days ${after28Days}')));
            },
          ),
          allTodayList.isEmpty? Center(child: Text('No Data To confirm'),):allTodayList.isNotEmpty?
          Expanded(
              child:ListView.builder(
                  itemCount:  allTodayList.length,
                  itemBuilder: (context,index) {
                    // showDiff(context,allTodayList[index]);
                    return ExpansionTile(title: Text('${allTodayList[index].name}'),
                      trailing: IconButton(onPressed: (){

                      }, icon: Icon(Icons.delete,color: Colors.red,)),
                      children: [
                        Text('Expense Amount ${allTodayList[index].amount}'),
                        Text('Expense id ${allTodayList[index].id}'),
                        Text('Expense payment date ${allTodayList[index].paymentDate}'),
                        Text('Expense Created date ${allTodayList[index].createdDate}'),
                       // Text('Expense last confirmed date ${getRepeatedModel(allTodayList[index]).lastConfirmationDate}'),
                        //Text('try difere Created date ${allTodayList[index].createdDate.difference(DateTime.now()).inDays % 7 }'),
                        Text('try  baqy qesma ${14 % 7 }'),
                        //Text('Next Shown date ${getRepeatedModel(allTodayList[index]).nextShownDate}'),
                        //Text('Next Shown date ${DateTime.now().difference(getRepeatedModel(allTodayList[index]).nextShownDate).inDays%7}'),
                        Text('Expense Repeat ${allTodayList[index].repeatType}'),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(children: [
                            Spacer(),
                            ElevatedButton(onPressed: (){
                              onYesConfirmed(theAddedExpense: allTodayList[index]);
                            }, child: Text('Yes')),

                            ElevatedButton(onPressed: (){
                              onNoConfirmed(theAddedExpense: allTodayList[index]);
                            }, child: Text('No')),
                          ],),
                        )
                      ],
                    );
                  }
              ) ):Center(child: CircularProgressIndicator(),)

        ],
      ),
    );
  }
  TransactionRepeatDetailsModel getRepeatedModel(TransactionModel model){
    if(model.repeatType==AppStrings.daily){
      var result=Hive.box<TransactionRepeatDetailsModel>(AppBoxes.dailyTransactionsBoxName).get(model.id);
    return  result!;
    }else if(model.repeatType==AppStrings.weekly){
      var result=Hive.box<TransactionRepeatDetailsModel>(AppBoxes.weeklyTransactionsBoxName).get(model.id);
      return  result!;
    }else if(model.repeatType==AppStrings.monthly){
      var result=Hive.box<TransactionRepeatDetailsModel>(AppBoxes.monthlyTransactionsBoxName).get(model.id);
      return  result!;
    }else{
      var result=Hive.box<TransactionRepeatDetailsModel>(AppBoxes.noRepeaTransactionsBoxName).get(model.id);
      return  result!;
    }
  }



Padding goalsConfirmBody(BuildContext context) {
  return Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              allTodayGoals.isEmpty? Center(child: Text('No Data To confirm'),):allTodayGoals.isNotEmpty?
              Expanded(
                  child:ListView.builder(
                      itemCount:  allTodayGoals.length,
                      itemBuilder: (context,index) {
                        // showDiff(context,allTodayList[index]);
                        return ExpansionTile(title: Text('${allTodayGoals[index].goalName}'),
                          trailing: IconButton(onPressed: (){

                          }, icon: Icon(Icons.delete,color: Colors.red,)),
                          children: [
                            Text('Goal Amount ${allTodayGoals[index].goalSaveAmount}'),
                            Text('Goal id ${allTodayGoals[index].id}'),
                            Text('Goal StartSavingDate  ${allTodayGoals[index].goalStartSavingDate}'),
                            Text('Goal Repeat ${allTodayGoals[index].goalSaveAmountRepeat}'),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(children: [
                                Spacer(),
                                ElevatedButton(onPressed: (){
                                  onYesConfirmedGoal(goalModel: allTodayGoals[index]);
                                }, child: Text('Yes')),

                                ElevatedButton(onPressed: (){
                                  onNoConfirmedGoal(goalModel: allTodayGoals[index]);
                                }, child: Text('No')),
                              ],),
                            )
                          ],
                        );
                      }
                  ) ):Center(child: CircularProgressIndicator(),)

            ],
          ),
        );
}

/// end of goals confirm body widget
// showDiff(BuildContext context,ExpenseModel expenseModel){
  //   DateTime today=DateTime(2022,12,5);
  //   if(expenseModel.expenseRepeat=='Monthly'){
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //         content: Text('Expense  Name is ${expenseModel.expenseName}\n Diffrenece in days ${today.difference(Hive.box<MonthlyExpenseModel>('MonthlyExpenseModel').values.
  //         where((element) => element.monthExpenseModel.expenseId==expenseModel.expenseId).single.nextShownDate).inDays } \n '
  //             'after 30  days ${today.add(Duration(days: 30)).day} ')));
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //         content: Text('Expense  Name is ${expenseModel.expenseName}\n '
  //             'after 30  days ${today.add(Duration(days: 30)).day} ')));
  //   }else{
  //
  //   }
  //
  // }
}
*/
