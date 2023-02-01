import 'package:hive/hive.dart';
import 'package:temp/data/local/hive/app_boxes.dart';
import 'package:temp/data/local/hive/hive_database.dart';
import 'package:temp/data/local/hive/id_generator.dart';
import 'package:temp/data/models/transactions/transaction_details_model.dart';
import 'package:temp/data/repository/transactions_impl/mixin_transaction.dart';
import '../../../business_logic/repository/income_repo/income_repo.dart';
import '../../models/transactions/transaction_model.dart';
import '../transactions_impl/transaction_impl.dart';

class IncomeRepositoryImpl with MixinTransaction implements IncomeRepository {

  IncomeRepositoryImpl();

  @override
  Future<void> addIncomeToTransactionBox(
      {required TransactionModel transactionModel}) async {
    final incomeModel = TransactionModel.income(
        amount: transactionModel.amount,
        comment: transactionModel.comment,
        id: GUIDGen.generate(),
        name: transactionModel.name,
        repeatType: transactionModel.repeatType,
        mainCategory: transactionModel.mainCategory,
        isAddAuto: false,
        subCategory: transactionModel.subCategory,
        isExpense: false,
        isProcessing:
            isEqualToday(date: transactionModel.paymentDate),
        createdDate: DateTime.now(),
        paymentDate: transactionModel.paymentDate);

    // final Box<TransactionModel> allExpensesModel = hiveDatabase.getBoxName<TransactionModel>(boxName: AppBoxes.transactionBox);
    final Box<TransactionModel> allIncomeBox = hiveDatabase
        .getBoxName<TransactionModel>(boxName: AppBoxes.transactionBox);
    if (isEqualToday(date: incomeModel.paymentDate)) {
      print(
          'is equal today in if ?${isEqualToday(date: incomeModel.paymentDate)}');
      // await allExpensesModel.add(expenseModel);
      await allIncomeBox.put(incomeModel.id, incomeModel);
      print(
          "name of the value added by  key is ${allIncomeBox.get(incomeModel.id)!.name} and key is ${allIncomeBox.get(incomeModel.id)!.id}");

      addTransactions(
          incomeModel: incomeModel, choseRepeat: incomeModel.repeatType);
    } else {
      print(
          'is  equal today in else  ?${isEqualToday(date: incomeModel.paymentDate)}');

      addTransactions(
          incomeModel: incomeModel, choseRepeat: incomeModel.repeatType);
    }
    print('Income values are ${allIncomeBox.values}');
  }

  @override
  void addTransactions(
      {required TransactionModel incomeModel, required String choseRepeat}) {
    switch (choseRepeat) {
      case 'Daily':
        DailyTransaction().addTransactionToRepeatedBox(incomeModel);
        break;
      case 'Weekly':
        WeeklyTransaction().addTransactionToRepeatedBox(incomeModel);
        break;
      case 'Monthly':
        MonthlyTransaction().addTransactionToRepeatedBox(incomeModel);
        break;
      case 'No Repeat':
        NoRepeatTransaction().addTransactionToRepeatedBox(incomeModel);
        break;
    }
  }

  @override
  List<TransactionRepeatDetailsModel> getIncomeTypeList(int currentIndex) {
    List<List<TransactionRepeatDetailsModel>> expenseTypesList = [];
    expenseTypesList = [
      DailyTransaction().getRepeatedTransactions(isExpense: false),
      WeeklyTransaction().getRepeatedTransactions(isExpense: false),
      MonthlyTransaction().getRepeatedTransactions(isExpense: false),
      NoRepeatTransaction().getRepeatedTransactions(isExpense: false),
    ];

    return expenseTypesList[currentIndex];
  }

  @override
  List<TransactionModel> getIncomeFromTransactionBox() {
    return HiveHelper().getBoxName<TransactionModel>(boxName: AppBoxes.transactionBox)
        .values
        .cast<TransactionModel>().where((element) => element.isExpense==false).toList();
  }
}

/*
OLD Implementation for Income Repository
  @override
  Future<void> addIncomeToIncomeBox({
    required String name,
    required num amount,
    required String mainCategory,
    required String subCategory,
    required String comment,
    required String repeat,
    required DateTime paymentDate,
    required DateTime createdDate,
  }) async {
    final incomeModel = TransactionModel.income(
        id: GUIDGen.generate(),
        name: name,
        amount: amount,
        comment: comment,
        isExpense: false,
        isAddAuto: false,
        createdDate: createdDate,
        mainCategory: mainCategory,
        paymentDate: paymentDate,
        repeatType: repeat,
        subCategory: subCategory,
        isProcessing: false);

    final allIncomeBox = hiveDatabase.getBoxName(boxName: AppBoxes.incomeModel);
    if (isEqualToday(date: incomeModel.paymentDate)) {
      await allIncomeBox.add(incomeModel);
      await addToRepeatedBoxes(incomeModel.repeatType, incomeModel);
    } else {
      await addToRepeatedBoxes(incomeModel.repeatType, incomeModel);
    }

    print('Income values are ${allIncomeBox.values}');
  }

  @override
  Future<void> addToRepeatedBoxes(
      String repeat, TransactionModel incomeModel) async {
    if (repeat == AppStrings.daily) {
      addDailyIncomeToRepeatedBox(incomeModel);
    } else if (repeat == AppStrings.weekly) {
      addWeeklyIncomeToRepeatedBox(incomeModel);
    } else if (repeat == AppStrings.monthly) {
      addMonthlyIncomeToRepeatedBox(incomeModel);
    } else if (repeat == AppStrings.noRepeat) {
      addNoRepeatIncomeToRepeatedBox(incomeModel);
    }
  }

  @override
  Future addDailyIncomeToRepeatedBox(TransactionModel incomeModel) async {
    final box = hiveDatabase.getBoxName(boxName: AppBoxes.incomeModel);
    final TransactionRepeatDetailsModel dailyIncomeModel =
        TransactionRepeatDetailsModel.copyWith(
            transactionModel: incomeModel,
            lastConfirmationDate: today,
            nextShownDate: putNextShownDate(
                paymentDate: incomeModel.paymentDate,
                repeatType: AppStrings.daily),
            lastShownDate: today,
            isLastConfirmed: false,
            creationDate: today);

    await box.add(dailyIncomeModel);
  }

  @override
  Future addWeeklyIncomeToRepeatedBox(TransactionModel incomeModel) async {
    final box = hiveDatabase.getBoxName(boxName: AppBoxes.incomeModel);
    final TransactionRepeatDetailsModel weeklyIncomeModel =
        TransactionRepeatDetailsModel.copyWith(
            transactionModel: incomeModel,
            lastConfirmationDate: today,
            nextShownDate: putNextShownDate(
                paymentDate: incomeModel.paymentDate,
                repeatType: AppStrings.weekly),
            lastShownDate: today,
            isLastConfirmed: false,
            creationDate: today);

    await box.add(weeklyIncomeModel);
  }

  @override
  Future addMonthlyIncomeToRepeatedBox(TransactionModel incomeModel) async {
    final box = hiveDatabase.getBoxName(boxName: AppBoxes.incomeModel);
    final TransactionRepeatDetailsModel monthlyIncomeModel =
        TransactionRepeatDetailsModel.copyWith(
            transactionModel: incomeModel,
            lastConfirmationDate: today,
            nextShownDate: putNextShownDate(
                paymentDate: incomeModel.paymentDate,
                repeatType: AppStrings.monthly),
            lastShownDate: today,
            isLastConfirmed: false,
            creationDate: today);

    await box.add(monthlyIncomeModel);
  }

  @override
  Future addNoRepeatIncomeToRepeatedBox(TransactionModel incomeModel) async {
    final box = hiveDatabase.getBoxName(boxName: AppBoxes.incomeModel);
    final TransactionRepeatDetailsModel noRepeatIncomeModel =
        TransactionRepeatDetailsModel.copyWith(
            transactionModel: incomeModel,
            lastConfirmationDate: today,
            nextShownDate: putNextShownDate(
                paymentDate: incomeModel.paymentDate,
                repeatType: AppStrings.noRepeat),
            lastShownDate: today,
            isLastConfirmed: false,
            creationDate: today);

    await box.add(noRepeatIncomeModel);
  }
 */
