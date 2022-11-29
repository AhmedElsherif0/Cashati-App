import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:temp/data/local/hive/app_boxes.dart';
import 'package:temp/data/local/hive/hive_database.dart';

import '../../../data/models/expenses/expense_model.dart';
import '../../../data/models/income/income_model.dart';

class AllExpIncTest extends StatefulWidget {
  const AllExpIncTest({super.key});

  @override
  State<AllExpIncTest> createState() => _AllExpIncTestState();
}

class _AllExpIncTestState extends State<AllExpIncTest> {
  List<IncomeModel> incomeData = [];
  List<ExpenseModel> expenseData = [];

  bool isExpense = true;

  @override
  void initState() {
    // TODO: implement initState
    incomeData = HiveHelper()
        .getBox(boxName: AppBoxes.incomeModel)
        .values
        .toList()
        .cast<IncomeModel>();
    expenseData = HiveHelper()
        .getBox(boxName: AppBoxes.expenseModel)
        .values
        .toList()
        .cast<ExpenseModel>();
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
              ? Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Visibility(
                      visible: expenseData.isNotEmpty,
                      child: ListView.builder(
                          itemCount: expenseData.length,
                          itemBuilder: (context, index) {
                            return ExpansionTile(
                              title: Text('${expenseData[index].name}'),
                              trailing: IconButton(
                                  onPressed: () {
                                    HiveHelper().getBox(boxName: AppBoxes.expenseModel).delete(expenseData[index]);
                                    //data[index].delete();
                                  },
                                  icon: Icon(Icons.delete)),
                              children: [
                                Text('Expense Amount ${expenseData[index].amount}'),
                                Text(
                                    'Expense payment Date  ${expenseData[index].paymentDate}'),
                                Text('Expense id  ${expenseData[index].id}'),
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
