import 'package:hive/hive.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:temp/business_logic/repository/general_stats_repo/general_stats_repo.dart';
import 'package:temp/constants/app_icons.dart';
import 'package:temp/constants/app_strings.dart';
import 'package:temp/data/local/cache_helper.dart';
import 'package:temp/data/local/hive/app_boxes.dart';
import 'package:temp/data/local/hive/hive_database.dart';
import 'package:temp/data/models/goals/repeated_goal_model.dart';
import 'package:temp/data/models/notification/notification_model.dart';
import 'package:temp/data/models/statistics/general_stats_model.dart';
import 'package:temp/data/models/transactions/transaction_details_model.dart';

class GeneralStatsRepoImpl implements GeneralStatsRepo {
  late GeneralStatsModel generalStatsModel;
  final DateTime todayDate = DateTime.now();
  bool isGotNotifications = false;

  final HiveHelper hiveHelper = HiveHelper();

  // var hiveBox=Hive.box<GeneralStatsModel>(AppBoxes.generalStatisticsModel);

  @override
  Future<void> minusBalance({required num amount}) async {
    final GeneralStatsModel generalStatsModel =
        Hive.box<GeneralStatsModel>(AppBoxes.generalStatisticsBox)
            .get(AppStrings.onlyId)!;
    if (generalStatsModel.isInBox) {
      generalStatsModel.balance = generalStatsModel.balance - amount;
      print('general stats model hashcode is ${generalStatsModel.hashCode}');
      await generalStatsModel.save();
    } else {
      print('general stats model is not in box');
    }
  }

  @override
  Future<void> plusBalance({required num amount}) async {
    final GeneralStatsModel generalStatsModel =
        Hive.box<GeneralStatsModel>(AppBoxes.generalStatisticsBox)
            .get(AppStrings.onlyId)!;

    if (isGeneralModelExists()) {
      //generalStatsModel=Hive.box<GeneralStatsModel>(AppStrings.generalStatisticsBox).get(0)!;
      print('general stats model hashcode is ${generalStatsModel.hashCode}');
      generalStatsModel.balance = generalStatsModel.balance + amount;
      await generalStatsModel.save();
    } else {
      print('general stats model is not in box');
    }
  }

  @override
  Future<void> addTheGeneralStateModel() async {
    Box<GeneralStatsModel> box =
        Hive.box<GeneralStatsModel>(AppBoxes.generalStatisticsBox);
    try {
      await box
          .put(
              AppStrings.onlyId,
              GeneralStatsModel(
                  id: AppStrings.onlyId,
                  balance: 0,
                  topIncome: 'No Income Added',
                  topIncomeAmount: 0,
                  topExpense: 'No Expense Added',
                  topExpenseAmount: 0,
                  latestCheck: DateTime.now(),
                  notificationList: []))
          .then((value) => print(
              'The model is  ${HiveHelper().getBoxName<GeneralStatsModel>(boxName: AppBoxes.generalStatisticsBox).get(AppStrings.onlyId)!.key}'));
    } catch (error) {}
  }

  @override
  Future<GeneralStatsModel> getTheGeneralStatsModel() async {
    if (_isGeneralModelBoxOpen()) {
      if (isGeneralModelExists()) {
        Box<GeneralStatsModel> generalBox =
            HiveHelper().getBoxName(boxName: AppBoxes.generalStatisticsBox);
        // print('box items are ${hiveHelper
        //     .getBoxName<GeneralStatsModel>(
        //     boxName: AppBoxes.generalStatisticsModel)
        //     .values
        //     .cast<GeneralStatsModel>()
        //     .toList()}');
        // print('Box LENGTH is ${Hive.box(AppStrings.generalStatisticsBox)
        //     .values.cast<GeneralStatsModel>().toList()
        //     .length}');
        print(
            'is Hive box exists ${await Hive.boxExists(AppBoxes.generalStatisticsBox)}');
        print('Model before asigning  is ${generalBox.get(AppStrings.onlyId)}');

        generalStatsModel = generalBox.get(AppStrings.onlyId) ??
            GeneralStatsModel(
                id: AppStrings.onlyId,
                balance: 0,
                topIncome: AppStrings.noIncYet.tr(),
                topIncomeAmount: 0,
                topExpense: AppStrings.noExpYet.tr(),
                topExpenseAmount: 0,
                latestCheck: DateTime.now(),
                notificationList: []);
        ;
      } else {
        print(' going to add item now');
        await addTheGeneralStateModel().whenComplete(() async {
          await getTheGeneralStatsModel();
        });
      }
    } else {
      await _openGeneralModelBox().then((value) async {
        await getTheGeneralStatsModel();
      });
    }
    print('General Model in repo impl is ${generalStatsModel.balance}');
    return await generalStatsModel;
  }

  @override
  Future<void> addNotification(NotificationModel notificationModel) async {
    generalStatsModel.notificationList.add(notificationModel);
    await generalStatsModel.save();
  }

  @override
  Future<void> deleteNotification(NotificationModel notificationModel) async {
    generalStatsModel.notificationList.remove(notificationModel);
    await generalStatsModel.save();
  }

  @override
  bool isGeneralModelExists() {
    if (Hive.box<GeneralStatsModel>(AppBoxes.generalStatisticsBox).values.isNotEmpty) {
      print('model exists');
      return true;
    } else {
      print('Box is open , but no values');
      return false;
    }
  }

  bool _isGeneralModelBoxOpen() {
    if (Hive.isBoxOpen(AppBoxes.generalStatisticsBox)) {
      print('Box is open');
      return true;
    } else {
      print('Box is not open');
      //await Hive.openBox(AppBoxes.generalStatisticsModel);
      return false;
    }
  }

  Future<void> _openGeneralModelBox() async {
    try {
      await Hive.openBox(AppBoxes.generalStatisticsBox);
    } catch (error) {
      print('error in opening general model box is ${error.toString()}');
    }
  }

  bool _areRepeatedBoxesOpen() {
    if (Hive.isBoxOpen(AppBoxes.dailyTransactionsBoxName) &&
        Hive.isBoxOpen(AppBoxes.weeklyTransactionsBoxName) &&
        Hive.isBoxOpen(AppBoxes.monthlyTransactionsBoxName) &&
        Hive.isBoxOpen(AppBoxes.noRepeaTransactionsBoxName) &&
        Hive.isBoxOpen(AppBoxes.goalRepeatedBox)) {
      print('Boxes are open');
      return true;
    } else {
      print('Boxes are not open');
      //await Hive.openBox(AppBoxes.generalStatisticsModel);
      return false;
    }
  }

  bool _didGetNotificationsToday(bool didOpenAppToday) =>
      isGotNotifications = didOpenAppToday ? true : false;

  @override
  Future<List<NotificationModel>> getNotifications(
      {required bool didOpenAppToday}) async {
    if (_areRepeatedBoxesOpen()) {
      if (_didGetNotificationsToday(didOpenAppToday)) {
        return generalStatsModel.notificationList;
      } else {
        return await _fetchedNotifications();
      }
    } else {
      // await openRepeatedBoxes().then((value) async {
      //   await getNotifications(didOpenAppToday: didOpenAppToday);
      // });
      return generalStatsModel.notificationList;
    }
  }

  Future<List<NotificationModel>> _fetchedNotifications() async {
    // final notificationBox =hiveHelper.getBoxName<NotificationModel>(
    // boxName: AppBoxes.notificationBox);
    final todayNotificationList =
        CacheHelper.getDataFromSharedPreference(key: "lastNotificationSavedDay") ??
            ["0"];
    final List<String> savedNotificationDate = List.from(todayNotificationList);
    final dailyBox = hiveHelper.getBoxName<TransactionRepeatDetailsModel>(
        boxName: AppBoxes.dailyTransactionsBoxName);
    final weeklyBox = hiveHelper.getBoxName<TransactionRepeatDetailsModel>(
        boxName: AppBoxes.weeklyTransactionsBoxName);
    final monthlyBox = hiveHelper.getBoxName<TransactionRepeatDetailsModel>(
        boxName: AppBoxes.monthlyTransactionsBoxName);
    final noRepBox = hiveHelper.getBoxName<TransactionRepeatDetailsModel>(
        boxName: AppBoxes.noRepeaTransactionsBoxName);
    final goalRepBox = hiveHelper.getBoxName<GoalRepeatedDetailsModel>(
        boxName: AppBoxes.goalRepeatedBox);
    if (_isNotificationSaved(savedNotificationDate)) {
      generalStatsModel.notificationList.clear();

      dailyBox.values.forEach((element) async {
        if (_shouldAddNotification(element)) {
          //TODO check which icon to add
          generalStatsModel.notificationList.add(_notificationModel(element));
        }
      });
      weeklyBox.values.forEach((element) async {
        if (_shouldAddNotification(element)) {
          //TODO check which icon to add
          generalStatsModel.notificationList.add(_notificationModel(element));
        }
      });
      monthlyBox.values.forEach((element) async {
        if (_shouldAddNotification(element)) {
          //TODO check which icon to add
          generalStatsModel.notificationList.add(_notificationModel(element));
        }
      });
      noRepBox.values.forEach((element) async {
        if (_shouldAddNotification(element)) {
          //TODO check which icon to add
          generalStatsModel.notificationList.add(_notificationModel(element));
        }
      });
      goalRepBox.values.forEach((element) async {
        if (element.nextShownDate.isBefore(todayDate) &&
            todayDate.difference(element.nextShownDate).inDays > 0 &&
            element.goalLastConfirmationDate.isBefore(element.nextShownDate)) {
          //TODO check which icon to add
          generalStatsModel.notificationList.add(NotificationModel(
            id: element.goal.id,
            amount: element.goal.goalSaveAmount,
            checkedDate: element.nextShownDate,
            actionDate: DateTime.now(),
            didTakeAction: false,
            icon: AppIcons.goals,
            modelName: element.goal.goalName,
            payLoad: element.goal.goalSaveAmountRepeat,
            typeName: 'Goal',
          ));
        }
      });
      await CacheHelper.saveDataSharedPreference(
          key: "lastNotificationSavedDay",
          value: [
            todayDate.day.toString(),
            todayDate.month.toString(),
            todayDate.year.toString()
          ]);
      print('Fetching for the first time today');
    } else {
      print('Already Fetched before');
    }
    // print('Notification list in box ${notificationBox.values.toList()}');
    // _generalStatsModel.notificationList.addAll(notificationBox.values.toList());
    print(
        'Notification list in general stats model is ${generalStatsModel.notificationList}');

    await generalStatsModel.save();
    isGotNotifications = true;
    return generalStatsModel.notificationList;
  }

  @override
  Future<void> fetchTopExpenseAndTopIncome() async {
    num topExp = generalStatsModel.topExpenseAmount;
    num topIncome = generalStatsModel.topIncomeAmount;
    String topExpName = generalStatsModel.topExpense.isNotEmpty
        ? generalStatsModel.topExpense
        : 'No Expense Yet';
    String topIncomeName = generalStatsModel.topIncome.isNotEmpty
        ? generalStatsModel.topIncome
        : 'No Income Yet';

    final dailyBox = hiveHelper.getBoxName<TransactionRepeatDetailsModel>(
        boxName: AppBoxes.dailyTransactionsBoxName);
    final weeklyBox = hiveHelper.getBoxName<TransactionRepeatDetailsModel>(
        boxName: AppBoxes.weeklyTransactionsBoxName);
    final monthlyBox = hiveHelper.getBoxName<TransactionRepeatDetailsModel>(
        boxName: AppBoxes.monthlyTransactionsBoxName);
    final noRepBox = hiveHelper.getBoxName<TransactionRepeatDetailsModel>(
        boxName: AppBoxes.noRepeaTransactionsBoxName);

    dailyBox.values.forEach((element) async {
      if (element.isLastConfirmed &&
          element.transactionModel.paymentDate.month == todayDate.month &&
          element.transactionModel.isExpense &&
          element.transactionModel.amount > topExp) {
        topExp = element.transactionModel.amount;
        topExpName = element.transactionModel.name;
        element.isLastConfirmed = false;
        await element.save();
      } else if (element.isLastConfirmed &&
          element.transactionModel.paymentDate.month == todayDate.month &&
          !element.transactionModel.isExpense &&
          element.transactionModel.amount > topIncome) {
        topIncome = element.transactionModel.amount;
        topIncomeName = element.transactionModel.name;
        element.isLastConfirmed = false;
        await element.save();
      }
    });
    weeklyBox.values.forEach((element) async {
      if (element.isLastConfirmed &&
          element.transactionModel.paymentDate.month == todayDate.month &&
          element.transactionModel.isExpense &&
          element.transactionModel.amount > topExp) {
        topExp = element.transactionModel.amount;
        topExpName = element.transactionModel.name;
        print('Element before saving is ${element.isLastConfirmed}');
        element.isLastConfirmed = false;
        print('Element after saving is ${element.isLastConfirmed}');
        await element.save();
      } else if (element.isLastConfirmed &&
          element.transactionModel.paymentDate.month == todayDate.month &&
          !element.transactionModel.isExpense &&
          element.transactionModel.amount > topIncome) {
        topIncome = element.transactionModel.amount;
        topIncomeName = element.transactionModel.name;
        print(
            '${element.transactionModel.name} before saving is ${element.isLastConfirmed}');

        element.isLastConfirmed = false;
        element.save().whenComplete(() => null);
        print(
            '${element.transactionModel.name} after saving is ${element.isLastConfirmed}');
      }
    });
    monthlyBox.values.forEach((element) async {
      if (element.isLastConfirmed &&
          element.transactionModel.paymentDate.month == todayDate.month &&
          element.transactionModel.isExpense &&
          element.transactionModel.amount > topExp) {
        topExp = element.transactionModel.amount;
        topExpName = element.transactionModel.name;
        print(
            '${element.transactionModel.name} before saving is ${element.isLastConfirmed}');

        element.isLastConfirmed = false;
        await element.save().whenComplete(() => print(
            '${element.transactionModel.name} after saving is ${element.isLastConfirmed}'));
      } else if (element.isLastConfirmed &&
          element.transactionModel.paymentDate.month == todayDate.month &&
          !element.transactionModel.isExpense &&
          element.transactionModel.amount > topIncome) {
        topIncome = element.transactionModel.amount;
        topIncomeName = element.transactionModel.name;
        print(
            '${element.transactionModel.name} before saving is ${element.isLastConfirmed}');

        element.isLastConfirmed = false;
        await element.save().whenComplete(() => print(
            '${element.transactionModel.name} after saving is ${element.isLastConfirmed}'));
      }
    });
    noRepBox.values.forEach((element) async {
      if (element.isLastConfirmed &&
          element.transactionModel.paymentDate.month == todayDate.month &&
          element.transactionModel.isExpense &&
          element.transactionModel.amount > topExp) {
        topExp = element.transactionModel.amount;
        topExpName = element.transactionModel.name;
        print(
            '${element.transactionModel.name} before saving is ${element.isLastConfirmed}');

        element.isLastConfirmed = false;
        await element.save().whenComplete(() => print(
            '${element.transactionModel.name} after saving is ${element.isLastConfirmed}'));
      } else if (element.isLastConfirmed &&
          element.transactionModel.paymentDate.month == todayDate.month &&
          !element.transactionModel.isExpense &&
          element.transactionModel.amount > topIncome) {
        topIncome = element.transactionModel.amount;
        topIncomeName = element.transactionModel.name;
        print(
            '${element.transactionModel.name} before saving is ${element.isLastConfirmed}');
        element.isLastConfirmed = false;
        await element.save().whenComplete(() => print(
            '${element.transactionModel.name} after saving is ${element.isLastConfirmed}'));
      }
    });

    generalStatsModel.topIncome = topIncomeName;
    generalStatsModel.topIncomeAmount = topIncome;
    generalStatsModel.topExpense = topExpName;
    generalStatsModel.topExpenseAmount = topExp;
    print("New top topExpense Amount is ${generalStatsModel.topExpenseAmount}");
    print("New top topExpense Name is ${generalStatsModel.topExpense}");

    print("New top topIncome Amount is ${generalStatsModel.topIncome}");
    print("New top topIncome Name is ${generalStatsModel.topIncomeAmount}");
    await generalStatsModel.save();
  }

  @override
  Future<void> changeStatusOfNotification(NotificationModel notificationModel) async {
    NotificationModel notificationInBox = generalStatsModel.notificationList
        .where((element) => notificationModel.id == element.id)
        .single;
    notificationInBox.didTakeAction = true;
    notificationInBox.actionDate = DateTime.now();
    await generalStatsModel.save();
  }

  bool _shouldAddNotification(TransactionRepeatDetailsModel element) =>
      (element.nextShownDate.isBefore(todayDate) &&
              todayDate.difference(element.nextShownDate).inDays > 0 &&
              element.lastConfirmationDate.isBefore(element.nextShownDate))
          ? true
          : false;

  bool _isNotificationSaved(savedNotificationDate) =>
      (savedNotificationDate[0] != todayDate.day.toString() ||
          savedNotificationDate[1] != todayDate.month.toString() ||
          savedNotificationDate[2] != todayDate.year.toString());

  NotificationModel _notificationModel(TransactionRepeatDetailsModel element) =>
      NotificationModel(
        id: element.transactionModel.id,
        amount: element.transactionModel.amount,
        checkedDate: element.nextShownDate,
        actionDate: DateTime.now(),
        didTakeAction: false,
        icon: AppIcons.dollarCircle,
        modelName: element.transactionModel.name,
        payLoad: element.transactionModel.repeatType,
        typeName: element.transactionModel.isExpense ? "Expense" : "Income",
      );

  @override
  Future<void> deleteNotificationByName(String notificationTransactionName)async {
     generalStatsModel.notificationList.removeWhere((element) => element.modelName==notificationTransactionName);
    await generalStatsModel.save();
  }
}
