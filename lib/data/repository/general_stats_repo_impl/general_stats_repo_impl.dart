import 'package:hive/hive.dart';
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
  late GeneralStatsModel _generalStatsModel;
  final DateTime todayDate = DateTime.now();
   bool isGotNotifications = false;

  final HiveHelper hiveHelper = HiveHelper();

  // var hiveBox=Hive.box<GeneralStatsModel>(AppBoxes.generalStatisticsModel);

  @override
  Future<void> minusBalance({required num amount}) async {
    final GeneralStatsModel generalStatsModel =
    Hive.box<GeneralStatsModel>(AppStrings.generalStatisticsBox)
        .get(AppStrings.theOnlyGeneralStatsModelID)!;
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
    Hive.box<GeneralStatsModel>(AppStrings.generalStatisticsBox)
        .get(AppStrings.theOnlyGeneralStatsModelID)!;

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
    Hive.box<GeneralStatsModel>(AppStrings.generalStatisticsBox);
    try {
      await box
          .put(
          AppStrings.theOnlyGeneralStatsModelID,
          GeneralStatsModel(
              id: AppStrings.theOnlyGeneralStatsModelID,
              balance: 0,
              topIncome: 'No Income Added',
              topIncomeAmount: 0,
              topExpense: 'No Expense Added',
              topExpenseAmount: 0,
              latestCheck: DateTime.now(),
              notificationList: []))
          .then((value) =>
          print(
              'The model is  ${HiveHelper().getBoxName<GeneralStatsModel>(
                  boxName: AppStrings.generalStatisticsBox).get(
                  AppStrings.theOnlyGeneralStatsModelID)!.key}'));
    } catch (error) {
      print(
          'Error adding general stats model for the first time is ${error
              .toString()}');
    }
  }


  @override
  Future<GeneralStatsModel> getTheGeneralStatsModel() async {
    if (isGeneralModelBoxOpen()) {
      if (isGeneralModelExists()) {
        Box<GeneralStatsModel> generalBox =
        HiveHelper().getBoxName(boxName: AppStrings.generalStatisticsBox);
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
            'is Hive box exists ${await Hive.boxExists(
                AppStrings.generalStatisticsBox)}');
        print(
            'Model before asigning  is ${generalBox.get(
                AppStrings.theOnlyGeneralStatsModelID)}');

        _generalStatsModel =
            generalBox.get(AppStrings.theOnlyGeneralStatsModelID) ??
                GeneralStatsModel(
                    id: AppStrings.theOnlyGeneralStatsModelID,
                    balance: 3,
                    topIncome: 'No Income Added',
                    topIncomeAmount: 0,
                    topExpense: 'No Expense Added',
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
      await openGeneralModelBox().then((value) async {
        await getTheGeneralStatsModel();
      });
    }
    print('General Model in repo impl is ${_generalStatsModel.balance}');
    return await _generalStatsModel;
  }

  @override
  Future<void> addNotification(NotificationModel notificationModel) async {
    _generalStatsModel.notificationList.add(notificationModel);
    await _generalStatsModel.save();
  }

  @override
  Future<void> deleteNotification(NotificationModel notificationModel) async {
    _generalStatsModel.notificationList.remove(notificationModel);
    await _generalStatsModel.save();
  }

  @override
  bool isGeneralModelExists() {
    if (Hive
        .box<GeneralStatsModel>(AppStrings.generalStatisticsBox)
        .values
        .isNotEmpty) {
      print('model exists');
      // print('${.get(AppStrings.theOnlyGeneralStatsModelID)}');
      // print('${gene.values.toList()
      //     }');
      return true;
    } else {
      print('Box is open , but no values');

      // addTheGeneralStateModel();
      return false;
    }
  }

  @override
  bool isGeneralModelBoxOpen() {
    if (Hive.isBoxOpen(AppStrings.generalStatisticsBox)) {
      print('Box is open');
      return true;
    } else {
      print('Box is not open');
      //await Hive.openBox(AppBoxes.generalStatisticsModel);
      return false;
    }
  }

  @override
  Future<void> openGeneralModelBox() async {
    try {
      await Hive.openBox(AppStrings.generalStatisticsBox);
    } catch (error) {
      print('error in opening general model box is ${error.toString()}');
    }
  }

  @override
  bool areRepeatedBoxesOpen() {
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

  @override
  bool didGetNotificationsToday(bool didOpenAppToday) {
    if (isGotNotifications) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<List<NotificationModel>> getNotifications(
      {required bool didOpenAppToday}) async {

    if (areRepeatedBoxesOpen()) {
      if (didGetNotificationsToday(didOpenAppToday)) {
        return _generalStatsModel.notificationList;
      } else {
        return await fetchedNotifications();
      }
    } else {
      // await openRepeatedBoxes().then((value) async {
      //   await getNotifications(didOpenAppToday: didOpenAppToday);
      // });
      return _generalStatsModel.notificationList;
    }
  }

  @override
  Future<List<NotificationModel>> fetchedNotifications() async {
   // final notificationBox =hiveHelper.getBoxName<NotificationModel>(
       // boxName: AppBoxes.notificationBox);
    final todayNotificationList =CacheHelper.getDataFromSharedPreference(key: "lastNotificationSavedDay")??["0"];
    final List<String> savedNotificationDate=List.from(todayNotificationList);
    final dailyBox = hiveHelper.getBoxName<TransactionRepeatDetailsModel>(
        boxName: AppBoxes.dailyTransactionsBoxName);
    final weeklyBox = hiveHelper.getBoxName<TransactionRepeatDetailsModel>(
        boxName: AppBoxes.weeklyTransactionsBoxName);
    final monthlyBox = hiveHelper.getBoxName<TransactionRepeatDetailsModel>(
        boxName: AppBoxes.monthlyTransactionsBoxName);
    final noRepBox =hiveHelper.getBoxName<TransactionRepeatDetailsModel>(
        boxName: AppBoxes.noRepeaTransactionsBoxName);
    final goalRepBox = hiveHelper.getBoxName<GoalRepeatedDetailsModel>(
        boxName: AppBoxes.goalRepeatedBox);
    if(savedNotificationDate[0]!=todayDate.day.toString()||savedNotificationDate[1]!=todayDate.month.toString()||savedNotificationDate[2]!=todayDate.year.toString()){
      _generalStatsModel.notificationList.clear();

      dailyBox.values.forEach((element)async {
        if (element.nextShownDate.isBefore(DateTime(DateTime
            .now()
            .year, DateTime
            .now()
            .month, DateTime
            .now()
            .day)) && DateTime
            .now()
            .difference(element.nextShownDate)
            .inDays < 7) {
          //TODO check which icon to add
          _generalStatsModel.notificationList.add(NotificationModel(
            id: element.transactionModel.id,
            amount: element.transactionModel.amount!,
            checkedDate: element.nextShownDate,
            actionDate: DateTime.now(),
            didTakeAction: false,
            icon: AppIcons.dollarCircle,
            modelName: element.transactionModel.name,
            payLoad: 'ss',
            typeName: 'Transaction',

          ));
          // await notificationBox.put(element.key,NotificationModel(
          //    id: element.transactionModel.id,
          //    amount: element.transactionModel.amount!,
          //    checkedDate: element.nextShownDate,
          //    actionDate: DateTime.now(),
          //    didTakeAction: false,
          //    icon: AppIcons.dollarCircle,
          //    modelName: element.transactionModel.name,
          //    payLoad: 'ss',
          //    typeName: 'Transaction',
          //
          //  ));
        }
      });
      weeklyBox.values.forEach((element) async{
        if (element.nextShownDate.isBefore(DateTime(DateTime
            .now()
            .year, DateTime
            .now()
            .month, DateTime
            .now()
            .day)) && DateTime
            .now()
            .difference(element.nextShownDate)
            .inDays < 7) {
          //TODO check which icon to add
          _generalStatsModel.notificationList.add(NotificationModel(
            id: element.transactionModel.id,
            amount: element.transactionModel.amount!,
            checkedDate: element.nextShownDate,
            actionDate: DateTime.now(),
            didTakeAction: false,
            icon:AppIcons.dollarCircle,
            modelName: element.transactionModel.name,
            payLoad: 'ss',
            typeName: 'Transaction',

          ));
          // await notificationBox.put(element.key,NotificationModel(
          //   id: element.transactionModel.id,
          //   amount: element.transactionModel.amount!,
          //   checkedDate: element.nextShownDate,
          //   actionDate: DateTime.now(),
          //   didTakeAction: false,
          //   icon:AppIcons.dollarCircle,
          //   modelName: element.transactionModel.name,
          //   payLoad: 'ss',
          //   typeName: 'Transaction',
          //
          // ));
        }
      });
      monthlyBox.values.forEach((element) async{
        if (element.nextShownDate.isBefore(DateTime(DateTime
            .now()
            .year, DateTime
            .now()
            .month, DateTime
            .now()
            .day)) && DateTime
            .now()
            .difference(element.nextShownDate)
            .inDays < 7) {
          //TODO check which icon to add
          _generalStatsModel.notificationList.add(NotificationModel(
            id: element.transactionModel.id,
            amount: element.transactionModel.amount!,
            checkedDate: element.nextShownDate,
            actionDate: DateTime.now(),
            didTakeAction: false,
            icon: AppIcons.dollarCircle,
            modelName: element.transactionModel.name,
            payLoad: 'ss',
            typeName: 'Transaction',

          ));
          // await notificationBox.put(element.key,NotificationModel(
          //   id: element.transactionModel.id,
          //   amount: element.transactionModel.amount!,
          //   checkedDate: element.nextShownDate,
          //   actionDate: DateTime.now(),
          //   didTakeAction: false,
          //   icon: AppIcons.dollarCircle,
          //   modelName: element.transactionModel.name,
          //   payLoad: 'ss',
          //   typeName: 'Transaction',
          //
          // ));
        }
      });
      noRepBox.values.forEach((element) async{
        if (element.nextShownDate.isBefore(DateTime(DateTime
            .now()
            .year, DateTime
            .now()
            .month, DateTime
            .now()
            .day)) && DateTime
            .now()
            .difference(element.nextShownDate)
            .inDays < 7) {
          //TODO check which icon to add
          _generalStatsModel.notificationList.add(NotificationModel(
            id: element.transactionModel.id,
            amount: element.transactionModel.amount!,
            checkedDate: element.nextShownDate,
            actionDate: DateTime.now(),
            didTakeAction: false,
            icon:  AppIcons.dollarCircle,
            modelName: element.transactionModel.name,
            payLoad: 'ss',
            typeName: 'Transaction',

          ));
          // await  notificationBox.put(element.key,NotificationModel(
          //   id: element.transactionModel.id,
          //   amount: element.transactionModel.amount!,
          //   checkedDate: element.nextShownDate,
          //   actionDate: DateTime.now(),
          //   didTakeAction: false,
          //   icon:  AppIcons.dollarCircle,
          //   modelName: element.transactionModel.name,
          //   payLoad: 'ss',
          //   typeName: 'Transaction',
          //
          // ));
        }
      });
      goalRepBox.values.forEach((element)async {
        if (element.nextShownDate.isBefore(DateTime(DateTime
            .now()
            .year, DateTime
            .now()
            .month, DateTime
            .now()
            .day)) && DateTime
            .now()
            .difference(element.nextShownDate)
            .inDays < 7) {
          //TODO check which icon to add
          _generalStatsModel.notificationList.add(NotificationModel(
            id: element.goal.id,
            amount: element.goal.goalSaveAmount,
            checkedDate: element.nextShownDate,
            actionDate: DateTime.now(),
            didTakeAction: false,
            icon: AppIcons.goals,
            modelName: element.goal.goalName,
            payLoad: 'ss',
            typeName: 'Goals',

          ));
          // await notificationBox.put(element.key,NotificationModel(
          //   id: element.goal.id,
          //   amount: element.goal.goalSaveAmount,
          //   checkedDate: element.nextShownDate,
          //   actionDate: DateTime.now(),
          //   didTakeAction: false,
          //   icon: AppIcons.goals,
          //   modelName: element.goal.goalName,
          //   payLoad: 'ss',
          //   typeName: 'Goals',
          //
          // ));
        }
      });
     await CacheHelper.saveDataSharedPreference(key: "lastNotificationSavedDay", value: [todayDate.day.toString(),todayDate.month.toString(),todayDate.year.toString()]);
     print('Fetching for the first time today');
    }else{
      print('Already Fetched before');
    }
   // print('Notification list in box ${notificationBox.values.toList()}');
   // _generalStatsModel.notificationList.addAll(notificationBox.values.toList());
    print('Notification list in general stats model is ${_generalStatsModel.notificationList}');

   await _generalStatsModel.save();
    isGotNotifications=true;
    return  _generalStatsModel.notificationList;
  }

}
