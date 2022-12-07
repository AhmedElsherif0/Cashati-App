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
  Future<void> addExpenseToExpensesBox({
    required String name,
    required num amount,
    required String mainCategory,
    required String subCategory,
    required String comment,
    required String repeat,
    required bool isPriority,
    required bool isPaid,
    required DateTime paymentDate,
    required DateTime createdDate,
  }) async {
    final expenseModel = TransactionModel.expense(
        amount: amount,
        comment: comment,
        id: GUIDGen.generate(),
        name: name,
        repeatType: repeat,
        mainCategory: mainCategory,
        isAddAuto: false,
        isPriority: isPriority,
        subCategory: subCategory,
        isReceiveNotification: false,
        isProcessing: isEqualToday(date: paymentDate),
        createdDate: DateTime.now(),
        paymentDate: paymentDate);

    final allExpensesModel =
        hiveDatabase.getBoxName(boxName: AppBoxes.expenseRepeatDaily);
    if (isEqualToday(date: expenseModel.paymentDate)) {
      await allExpensesModel.add(expenseModel);
      addTransactions(
          expenseModel: expenseModel, choseRepeat: expenseModel.repeatType);
    } else {
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
        DailyTransaction().addTransaction(expenseModel);
        break;
      case 'Weekly':
        WeeklyTransaction().addTransaction(expenseModel);
        break;
      case 'Monthly':
        MonthlyTransaction().addTransaction(expenseModel);
        break;
      case 'No Repeat':
        NoRepeatTransaction().addTransaction(expenseModel);
        break;
    }
  }

  @override
  List<TransactionRepeatDetailsModel> getExpenseTypeList(int currentIndex) {
    List<List<TransactionRepeatDetailsModel>> expenseTypesList = [];
    expenseTypesList = [
      DailyTransaction().getTransaction(),
      WeeklyTransaction().getTransaction(),
      MonthlyTransaction().getTransaction(),
      NoRepeatTransaction().getTransaction(),
    ];

    return expenseTypesList[currentIndex];
  }

}
