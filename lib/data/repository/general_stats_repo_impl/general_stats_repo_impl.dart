import 'package:hive/hive.dart';
import 'package:temp/business_logic/repository/general_stats_repo/general_stats_repo.dart';
import 'package:temp/constants/app_strings.dart';
import 'package:temp/data/local/hive/hive_database.dart';
import 'package:temp/data/models/notification/notification_model.dart';
import 'package:temp/data/models/statistics/general_stats_model.dart';

class GeneralStatsRepoImpl implements GeneralStatsRepo {

  late GeneralStatsModel _generalStatsModel ;


  final HiveHelper hiveHelper = HiveHelper();
 // var hiveBox=Hive.box<GeneralStatsModel>(AppBoxes.generalStatisticsModel);

  @override
  Future<void> minusBalance({ required num amount}) async {

    final GeneralStatsModel generalStatsModel=Hive.box<GeneralStatsModel>(AppStrings.generalStatisticsBox).get(AppStrings.theOnlyGeneralStatsModelID)!;
    if (generalStatsModel.isInBox) {
      generalStatsModel.balance = generalStatsModel.balance - amount;
      print('general stats model hashcode is ${generalStatsModel.hashCode}');
      await generalStatsModel.save();
    } else {
      print('general stats model is not in box');
    }
  }


  @override
  Future<void> plusBalance({ required num amount}) async {
    final GeneralStatsModel generalStatsModel=Hive.box<GeneralStatsModel>(AppStrings.generalStatisticsBox).get(AppStrings.theOnlyGeneralStatsModelID)!;

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
  List<NotificationModel> getNotifications() {
    return _generalStatsModel.notificationList;
  }

  @override
  Future<GeneralStatsModel> getTheGeneralStatsModel() async {

    if (isGeneralModelBoxOpen()) {
      if (isGeneralModelExists()) {
        Box<GeneralStatsModel> generalBox=HiveHelper().getBoxName(boxName: AppStrings.generalStatisticsBox);
        // print('box items are ${hiveHelper
        //     .getBoxName<GeneralStatsModel>(
        //     boxName: AppBoxes.generalStatisticsModel)
        //     .values
        //     .cast<GeneralStatsModel>()
        //     .toList()}');
        // print('Box LENGTH is ${Hive.box(AppStrings.generalStatisticsBox)
        //     .values.cast<GeneralStatsModel>().toList()
        //     .length}');
        print('is Hive box exists ${await Hive.boxExists(AppStrings.generalStatisticsBox)}');
        print('Model before asigning  is ${generalBox.get(AppStrings.theOnlyGeneralStatsModelID)}');

        _generalStatsModel =
            generalBox.get(
                AppStrings.theOnlyGeneralStatsModelID)
                ?? GeneralStatsModel(
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
        await addTheGeneralStateModel().whenComplete(()async {
          await getTheGeneralStatsModel();
        });
      }
    } else {
      await openGeneralModelBox().then((value)async  {
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
  Future<void> addTheGeneralStateModel() async {
    Box<GeneralStatsModel>box=Hive.box<GeneralStatsModel>(
        AppStrings.generalStatisticsBox);
    try {
      await box.put(
        AppStrings.theOnlyGeneralStatsModelID,
          GeneralStatsModel(
              id: AppStrings.theOnlyGeneralStatsModelID,
              balance: 0,
              topIncome: 'No Income Added',
              topIncomeAmount: 0,
              topExpense: 'No Expense Added',
              topExpenseAmount: 0,
              latestCheck: DateTime.now(),
              notificationList: [])).then((value) =>
          print('The model is  ${HiveHelper().getBoxName<GeneralStatsModel>(
              boxName: AppStrings.generalStatisticsBox).get(AppStrings.theOnlyGeneralStatsModelID)!.key}'));
    } catch (error) {
      print('Error adding general stats model for the first time is ${error
          .toString()}');
    }
  }

  @override
  bool isGeneralModelExists() {
    if (Hive.box<GeneralStatsModel>(AppStrings.generalStatisticsBox).values.isNotEmpty) {
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
    if (Hive.isBoxOpen( AppStrings.generalStatisticsBox)) {
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

}