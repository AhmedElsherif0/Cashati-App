import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:temp/business_logic/repository/transactions_repo/transaction_repo.dart';
import 'package:temp/data/local/hive/app_boxes.dart';
import 'package:temp/data/local/hive/hive_database.dart';
import 'package:temp/data/models/transactions/transaction_model.dart';
import 'package:temp/data/repository/expenses_repo_impl/expenses_repo_impl.dart';
import 'package:temp/data/repository/income_repo_impl/income_repo_impl.dart';

import '../../../data/models/transactions/transaction_details_model.dart';
/*

class AllExpIncTest extends StatefulWidget {
  const AllExpIncTest({super.key});

  @override
  State<AllExpIncTest> createState() => _AllExpIncTestState();
}

class _AllExpIncTestState extends State<AllExpIncTest> {
  List<TransactionRepeatDetailsModel> expenseDataDaily = [];
  List<TransactionModel> incomeTransactions = [];
  List<TransactionModel> expenseTransactions = [];
  bool isExpense = true;
  TransactionRepo expenseRepository = ExpensesRepositoryImpl();
  TransactionRepo incomeRepository = IncomeRepositoryImpl();

  @override
  void initState() {
    expenseTransactions = expenseRepository.getTransactionFromTransactionBox();
    incomeTransactions = expenseRepository.getTransactionFromTransactionBox(isExpense: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('data is ${expenseTransactions.length}');
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 15.h),
          ElevatedButton(
              onPressed: () {
                setState(() => isExpense = !isExpense);
              },
              child: Text('${isExpense ? 'Show Income' : 'Show Expenses'}')),
          Text('${isExpense ? 'Expenses List ' : 'Income List '}'),
          isExpense
              ? Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Visibility(
                      visible: expenseTransactions.isNotEmpty,
                      replacement: const Center(
                        child: Text('data is empty'),
                      ),
                      child: ListView.builder(
                          itemCount: expenseTransactions.length,
                          itemBuilder: (context, index) {
                            return ExpansionTile(
                              title: Text('${expenseTransactions[index].name}'),
                              trailing: IconButton(
                                  onPressed: () async {
                                    await expenseTransactions[index].delete();
                                    // HiveHelper()
                                    //     .getBoxName(
                                    //         boxName:
                                    //             AppBoxes.dailyTransactionsBoxName)
                                    //     .delete(transactionsExpense[index]);
                                    // expenseDataDaily[index].delete();
                                  },
                                  icon: const Icon(Icons.delete)),
                              children: [
                                Text(
                                    'Expense Amount ${expenseTransactions[index].amount}'),
                                Text(
                                    'Expense payment Date  ${expenseTransactions[index].paymentDate}'),
                                Text('Expense id  ${expenseTransactions[index].id}'),
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
                      visible: incomeTransactions.isNotEmpty,
                      child: ListView.builder(
                          itemCount: incomeTransactions.length,
                          itemBuilder: (context, index) {
                            return ExpansionTile(
                              title: Text('${incomeTransactions[index].name}'),
                              trailing: IconButton(
                                  onPressed: () {
                                    HiveHelper()
                                        .getBoxName(boxName: AppBoxes.incomeModel)
                                        .delete(incomeTransactions[index]);
                                    //data[index].delete();
                                  },
                                  icon: Icon(Icons.delete)),
                              children: [
                                Text('incomeData Amount ${incomeTransactions[index].amount}'),
                                Text(
                                    'incomeData payment Date  ${incomeTransactions[index].paymentDate}'),
                                Text('incomeData id  ${incomeTransactions[index].id}'),
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
*/
