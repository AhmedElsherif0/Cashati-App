import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:temp/business_logic/repository/expenses_repo/confirm_expense_repo.dart';
import 'package:temp/data/models/transactions/transaction_model.dart';
import 'package:temp/data/repository/expenses_repo_impl/confirm_expense_repo_impl.dart';


class ConfirmPaymentsScreen extends StatefulWidget {
  const ConfirmPaymentsScreen({Key? key}) : super(key: key);

  @override
  _ConfirmPaymentsScreenState createState() => _ConfirmPaymentsScreenState();
}

class _ConfirmPaymentsScreenState extends State<ConfirmPaymentsScreen> {
  ConfirmExpenseRepo _transactionRep=ConfirmExpenseImpl();

    List<TransactionModel> allTodayList=[];
    List<TransactionModel> allTodayListIncome=[];
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
  }

  Future<void> onNoConfirmed({

    required TransactionModel theAddedExpense})async{
    print('No confirmed');
    await _transactionRep.onNoConfirmed(addedExpense:  theAddedExpense);
  }


  Future<void> onYesConfirmedIncome({

    required TransactionModel theAddedIncome})async{
    print('Yes confirmed');

    try{
      await _transactionRep.onYesConfirmed(addedExpense: theAddedIncome);
    }catch(e){
      print('error is $e');
    }
  }

  Future<void> onNoConfirmedIncome({

    required TransactionModel theAddedIncome})async{
    print('No confirmed');
    await _transactionRep.onNoConfirmed(addedExpense: theAddedIncome,);
  }



  @override
  void initState() {
    allTodayList=List.from(_transactionRep.getTodayPayments(isExpense: true));
    allTodayListIncome=List.from(_transactionRep.getTodayPayments(isExpense: false));
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
          expenseConfirmBody(context)
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
          allTodayList.isEmpty? Center(child: Text('No Data To confirm'),):allTodayList.isNotEmpty?
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

  /// Goals confirm Body
// Padding goalsConfirmBody(BuildContext context) {
//   return Padding(
//           padding: const EdgeInsets.all(25.0),
//           child: Column(
//
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               TextButton(
//                 child:Text('Show SnackBars'),
//                 onPressed: (){
//                   DateTime todayPlusDay=DateTime.now().add(Duration(days: 1));
//                   DateTime nextWeek=DateTime.now().add(Duration(days: 7));
//                   DateTime after28Days=DateTime.now().add(Duration(days: 28));
//                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Tomorrow is ${todayPlusDay}')));
//                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('nextWeek is ${nextWeek}')));
//                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('after28Days ${after28Days}')));
//                 },
//               ),
//               allTodayList.isEmpty? Center(child: Text('No Data To confirm'),):allTodayList.isNotEmpty?
//               Expanded(
//                   child:ListView.builder(
//                       itemCount:  allTodayList.length,
//                       itemBuilder: (context,index) {
//                         // showDiff(context,allTodayList[index]);
//                         return ExpansionTile(title: Text('${allTodayList[index].expenseName}'),
//                           trailing: IconButton(onPressed: (){
//
//                           }, icon: Icon(Icons.delete,color: Colors.red,)),
//                           children: [
//                             Text('Expense Amount ${allTodayList[index].expenseAmount}'),
//                             Text('Expense id ${allTodayList[index].expenseId}'),
//                             Text('Expense payment date ${allTodayList[index].expensePaymentDate}'),
//                             Text('Expense Repeat ${allTodayList[index].expenseRepeat}'),
//                             Padding(
//                               padding: const EdgeInsets.all(15.0),
//                               child: Row(children: [
//                                 Spacer(),
//                                 ElevatedButton(onPressed: (){
//                                   onYesConfirmed(theAddedExpense: allTodayList[index],currentRepeatType:  allTodayList[index].expenseRepeat);
//                                 }, child: Text('Yes')),
//
//                                 ElevatedButton(onPressed: (){
//                                   onNoConfirmed(theAddedExpense: allTodayList[index],currentRepeatType:  allTodayList[index].expenseRepeat);
//                                 }, child: Text('No')),
//                               ],),
//                             )
//                           ],
//                         );
//                       }
//                   ) ):Center(child: CircularProgressIndicator(),)
//
//             ],
//           ),
//         );
// }
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
