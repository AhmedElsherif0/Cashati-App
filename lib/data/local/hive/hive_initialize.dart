import 'package:hive/hive.dart';

import '../../models/goals/goal_model.dart';
import '../../models/goals/repeated_goal_model.dart';
import '../../models/notification/notification_model.dart';
import '../../models/statistics/general_stats_model.dart';
import '../../models/subcategories_models/expense_subcaegory_model.dart';
import '../../models/transactions/transaction_details_model.dart';
import '../../models/transactions/transaction_model.dart';
import '../../models/transactions/transaction_types_model.dart';
import 'app_boxes.dart';
import 'hive_database.dart';

class HiveInitialize {
  static Future<void> init() async {
    Hive.registerAdapter(GeneralStatsModelAdapter());
    Hive.registerAdapter(TransactionModelAdapter());
    Hive.registerAdapter(TransactionRepeatTypesAdapter());
    Hive.registerAdapter(TransactionRepeatDetailsModelAdapter());
    Hive.registerAdapter(SubCategoryAdapter());
    Hive.registerAdapter(GoalModelAdapter());
    Hive.registerAdapter(GoalRepeatedDetailsModelAdapter());
    Hive.registerAdapter(NotificationModelAdapter());

    await Hive.openBox<GeneralStatsModel>(AppBoxes.generalStatisticsBox);

    await HiveHelper().openBox<TransactionRepeatDetailsModel>(
        boxName: AppBoxes.dailyTransactionsBoxName);
    await HiveHelper().openBox<TransactionRepeatDetailsModel>(
        boxName: AppBoxes.weeklyTransactionsBoxName);
    await HiveHelper().openBox<TransactionRepeatDetailsModel>(
        boxName: AppBoxes.monthlyTransactionsBoxName);
    await HiveHelper().openBox<TransactionRepeatDetailsModel>(
        boxName: AppBoxes.noRepeaTransactionsBoxName);
    await HiveHelper().openBox<SubCategory>(boxName: AppBoxes.subCategoryExpense);
    await HiveHelper().openBox<TransactionModel>(boxName: AppBoxes.transactionBox);
    await HiveHelper().openBox<GoalModel>(boxName: AppBoxes.goalModel);
    await HiveHelper()
        .openBox<GoalRepeatedDetailsModel>(boxName: AppBoxes.goalRepeatedBox);
  }
}
