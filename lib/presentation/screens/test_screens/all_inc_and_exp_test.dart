import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/data/local/hive/app_boxes.dart';
import 'package:temp/data/local/hive/hive_database.dart';
import 'package:temp/data/models/transactions/transaction_model.dart';

import '../../../data/models/transactions/transaction_details_model.dart';


class AllExpIncTest extends StatefulWidget {
  const AllExpIncTest({super.key});

  @override
  State<AllExpIncTest> createState() => _AllExpIncTestState();
}

class _AllExpIncTestState extends State<AllExpIncTest> {
  List<TransactionModel> incomeData = [];
  List<TransactionRepeatDetailsModel> expenseDataDaily = [];
  List<TransactionModel> transactionsExpense = [];
  bool isExpense = true;

  @override
  void initState() {
  /*  // TODO: implement initState
    print(
        'Values at key between 0 and 0 Are : ${HiveHelper().getBox(boxName: AppBoxes.expenseRepeatTypes).valuesBetween(startKey: 0, endKey: 0)}');
    incomeData = HiveHelper()
        .getBox(boxName: AppBoxes.incomeModel)
        .values
        .toList()
        .cast<IncomeModel>();
    expenseDataDaily = HiveHelper()
        .getBox(boxName: AppBoxes.expenseRepeatTypes)
        .values
        .toList()
        .cast<ExpenseRepeatDetailsModel>();*/
    transactionsExpense =
        HiveHelper().getBoxName<TransactionModel>(boxName: AppBoxes.transactionBox)
        .values
        .cast<TransactionModel>().where((element) => element.isExpense==true).toList();
    incomeData=
        HiveHelper().getBoxName<TransactionModel>(boxName: AppBoxes.transactionBox)
            .values
            .cast<TransactionModel>().where((element) => element.isExpense==false).toList();
  }

  @override
  Widget build(BuildContext context) {
    print('data is ${transactionsExpense.length}');
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 15.h),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  isExpense = !isExpense;
                });
              },
              child: Text('${isExpense ? 'Expenses' : 'Income'}')),
          isExpense
              ? Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Visibility(
                      visible: transactionsExpense.isNotEmpty,
                      replacement: const Center(
                        child: Text('data is empty'),
                      ),
                      child: ListView.builder(
                          itemCount: transactionsExpense.length,
                          itemBuilder: (context, index) {
                            return ExpansionTile(
                              title: Text(
                                  '${transactionsExpense[index].name}'),
                              trailing: IconButton(
                                  onPressed: () {
                                    HiveHelper()
                                        .getBoxName(
                                            boxName:
                                                AppBoxes.dailyTransactionsBoxName)
                                        .delete(transactionsExpense[index]);
                                   // expenseDataDaily[index].delete();
                                  },
                                  icon: const Icon(Icons.delete)),
                              children: [
                                Text(
                                    'Expense Amount ${transactionsExpense[index].amount}'),
                                Text(
                                    'Expense payment Date  ${transactionsExpense[index].paymentDate}'),
                                Text(
                                    'Expense id  ${transactionsExpense[index].id}'),
                              ],
                            );
                          }),
                    ),
                  ),
                )
              : Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Visibility(
                      visible: incomeData.isNotEmpty,
                      child: ListView.builder(
                          itemCount: incomeData.length,
                          itemBuilder: (context, index) {
                            return ExpansionTile(
                              title: Text('${incomeData[index].name}'),
                              trailing: IconButton(
                                  onPressed: () {
                                    HiveHelper()
                                        .getBoxName(boxName: AppBoxes.incomeModel)
                                        .delete(incomeData[index]);
                                    //data[index].delete();
                                  },
                                  icon: Icon(Icons.delete)),
                              children: [
                                Text(
                                    'incomeData Amount ${incomeData[index].amount}'),
                                Text(
                                    'incomeData payment Date  ${incomeData[index].paymentDate}'),
                                Text('incomeData id  ${incomeData[index].id}'),
                              ],
                            );
                          }),
                      replacement: Center(
                        child: Text('data is empty'),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
