import 'package:temp/data/local/hive/app_boxes.dart';
import 'package:temp/data/local/hive/hive_database.dart';
import 'package:temp/data/local/hive/id_generator.dart';
import 'package:temp/data/models/transactions/transaction_details_model.dart';
import 'package:temp/data/repository/transactions_impl/mixin_transaction.dart';
import '../../../business_logic/repository/income_repo/income_repo.dart';
import '../../../constants/app_strings.dart';
import '../../models/transactions/transaction_model.dart';

class IncomeRepositoryImpl with MixinTransaction implements IncomeRepository {

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
    //TODO add copyWith so we can put paramaters
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
    //TODO add copyWith so we can put paramaters
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
    //TODO add copyWith so we can put paramaters
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
    //TODO add copyWith so we can put paramaters
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
}
