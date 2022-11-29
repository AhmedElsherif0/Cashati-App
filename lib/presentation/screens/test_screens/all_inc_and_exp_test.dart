import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:temp/data/local/hive/app_boxes.dart';
import 'package:temp/data/local/hive/hive_database.dart';
import 'package:temp/data/models/expenses/expense_details_model.dart';

import '../../../data/models/expenses/expense_model.dart';
import '../../../data/models/income/income_model.dart';

class AllExpIncTest extends StatefulWidget {
  const AllExpIncTest({super.key});

  @override
  State<AllExpIncTest> createState() => _AllExpIncTestState();
}

class _AllExpIncTestState extends State<AllExpIncTest> {
  List<IncomeModel> incomeData = [];
  List<ExpenseRepeatDetailsModel> expenseDataDaily = [];
  List<ExpenseRepeatDetailsModel> expenseDataWeekly = [];
  List<ExpenseRepeatDetailsModel> expenseDataMonthly = [];
  List<ExpenseRepeatDetailsModel> noRepexpenseDataMonthly = [];

  bool isExpense = true;

  @override
  void initState() {
    // TODO: implement initState
    print('Keys Are : ${ HiveHelper().getBox(boxName: AppBoxes.expenseRepeatTypes).keys}');
    print('Values at key between 0 and 0 Are : ${ HiveHelper().getBox(boxName: AppBoxes.expenseRepeatTypes).valuesBetween(startKey: 0,endKey: 0)}');
    incomeData = HiveHelper()
        .getBox(boxName: AppBoxes.incomeModel)
        .values
        .toList()
        .cast<IncomeModel>();
    expenseDataDaily = HiveHelper().getBox(boxName: AppBoxes.expenseRepeatTypes).values.toList().cast<ExpenseRepeatDetailsModel>();
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text('${isExpense ? 'Expenses' : 'Income'}'),
          ),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  isExpense = !isExpense;
                });
              },
              child: Text('${isExpense ? 'Expenses' : 'Income'}')),
          isExpense
              ?
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Visibility(
                          visible: expenseDataDaily.isNotEmpty,
                          child: ListView.builder(
                              itemCount: expenseDataDaily.length,
                              itemBuilder: (context, index) {
                                return ExpansionTile(
                                  title: Text('${expenseDataDaily[index].expenseModel.name}'),
                                  trailing: IconButton(
                                      onPressed: () {
                                       // HiveHelper().getBox(boxName: AppBoxes.expenseModel).delete(expenseData[index]);
                                        //data[index].delete();
                                      },
                                      icon: Icon(Icons.delete)),
                                  children: [
                                    Text('Expense Amount ${expenseDataDaily[index].expenseModel.amount}'),
                                    Text(
                                        'Expense payment Date  ${expenseDataDaily[index].expenseModel.paymentDate}'),
                                    Text('Expense id  ${expenseDataDaily[index].expenseModel.id}'),
                                  ],
                                );
                              }),
                          replacement:   Center(child: Text('data is empty'),),
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
                                    HiveHelper().getBox(boxName: AppBoxes.incomeModel).delete(incomeData[index]);
                                    //data[index].delete();
                                  },
                                  icon: Icon(Icons.delete)),
                              children: [
                                Text('incomeData Amount ${incomeData[index].amount}'),
                                Text(
                                    'incomeData payment Date  ${incomeData[index].paymentDate}'),
                                Text('incomeData id  ${incomeData[index].id}'),
                              ],
                            );
                          }),
                      replacement:   Center(child: Text('data is empty'),),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
