import 'package:hive/hive.dart';
import 'package:temp/data/local/hive/app_boxes.dart';
import 'package:temp/data/repository/transactions_impl/mixin_transaction.dart';

import '../../../business_logic/repository/expenses_repo/expenses_repo.dart';
import '../../local/hive/id_generator.dart';
import '../../models/transactions/transaction_details_model.dart';
import '../../models/transactions/transaction_model.dart';
import '../transactions_impl/transaction_impl.dart';

class ExpensesRepositoryImpl with MixinTransaction implements TransactionsRepository {

  ExpensesRepositoryImpl();

  @override
  Future<void> addExpenseToTransactionBox({
  required TransactionModel transactionModel
    // required String name,
    // required num amount,
    // required String mainCategory,
    // required String subCategory,
    // required String comment,
    // required String repeat,
    // required bool isPriority,
    // required bool isPaid,
    // required DateTime paymentDate,
    // required DateTime createdDate,
  }) async {
    final expenseModel = TransactionModel.expense(
        amount: transactionModel.amount,
        comment:  transactionModel.comment,
        id: GUIDGen.generate(),
        name:  transactionModel.name,
        repeatType:  transactionModel.repeatType,
        mainCategory:  transactionModel.mainCategory,
        isAddAuto: false,
        isPriority:  transactionModel.isPriority,
        subCategory:  transactionModel.subCategory,
        isExpense: true,
        isProcessing: isEqualToday(date:  transactionModel.paymentDate),
        createdDate: DateTime.now(),
        paymentDate:  transactionModel.paymentDate);

    final Box<TransactionModel> allExpensesModel =
        hiveDatabase.getBoxName<TransactionModel>(boxName: AppBoxes.transactionBox);
    if (isEqualToday(date: expenseModel.paymentDate)) {
      print('is equal today in if ?${isEqualToday(date: expenseModel.paymentDate)}');
     // await allExpensesModel.add(expenseModel);
      await allExpensesModel.put(expenseModel.id,expenseModel);
      print("name of the value added by  key is ${allExpensesModel.get(expenseModel.id)!.name} and key is ${allExpensesModel.get(expenseModel.id)!.id}");

      addTransactions(
          expenseModel: expenseModel, choseRepeat: expenseModel.repeatType);
    } else {
      print('is  equal today in else  ?${isEqualToday(date: expenseModel.paymentDate)}');

      addTransactions(
          expenseModel: expenseModel, choseRepeat: expenseModel.repeatType);
    }
    print('Expenses values are ${allExpensesModel.values}');
  }

  @override
  void addTransactions(
      {required TransactionModel expenseModel, required String choseRepeat}) {


    switch (choseRepeat) {
      case 'Daily':
        DailyTransaction().addTransactionToRepeatedBox(expenseModel);
        break;
      case 'Weekly':
        WeeklyTransaction().addTransactionToRepeatedBox(expenseModel);
        break;
      case 'Monthly':
        MonthlyTransaction().addTransactionToRepeatedBox(expenseModel);
        break;
      case 'No Repeat':
        NoRepeatTransaction().addTransactionToRepeatedBox(expenseModel);
        break;
    }
  }

  @override
  List<TransactionRepeatDetailsModel> getExpenseTypeList(int currentIndex) {
    List<List<TransactionRepeatDetailsModel>> expenseTypesList = [];
    expenseTypesList = [
      DailyTransaction().getRepeatedTransactions(),
      WeeklyTransaction().getRepeatedTransactions(),
      MonthlyTransaction().getRepeatedTransactions(),
      NoRepeatTransaction().getRepeatedTransactions(),
    ];

    return expenseTypesList[currentIndex];
  }

}
