import 'package:hive/hive.dart';
import 'package:temp/business_logic/repository/general_stats_repo/general_stats_repo.dart';
import 'package:temp/constants/app_strings.dart';
import 'package:temp/data/models/notification/notification_model.dart';
import 'package:temp/data/models/statistics/general_stats_model.dart';

class GeneralStatsRepoImpl implements GeneralStatsRepo {

  final GeneralStatsModel _generalStatsModel = Hive.box<GeneralStatsModel>(
      AppStrings.generalStatisticsBox).getAt(0)??GeneralStatsModel();

  @override
  Future<void> minusBalance({ required num amount}) async {
    //final generalStatsModel=Hive.box<GeneralStatsModel>(AppStrings.generalStatisticsBox).get(0)!;
    if (_generalStatsModel.isInBox) {

      _generalStatsModel.balance = _generalStatsModel.balance - amount;
      print('general stats model hashcode is ${_generalStatsModel.hashCode}');
      await _generalStatsModel.save();
    } else {
      print('general stats model is not in box');
    }
  }


  @override
  Future<void> plusBalance({ required num amount}) async {
   // final generalStatsModel=Hive.box<GeneralStatsModel>(AppStrings.generalStatisticsBox).get(0)??GeneralStatsModel();

    if (_generalStatsModel.isInBox) {
      //generalStatsModel=Hive.box<GeneralStatsModel>(AppStrings.generalStatisticsBox).get(0)!;
      print('general stats model hashcode is ${_generalStatsModel.hashCode}');
      _generalStatsModel.balance = _generalStatsModel.balance - amount;
      await _generalStatsModel.save();
    } else {
      print('general stats model is not in box');
    }
  }

  @override
  List<NotificationModel> getNotifications() {
    return _generalStatsModel.notificationList;
  }

  @override
  GeneralStatsModel getTheGeneralStatsModel() {
    return _generalStatsModel;
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
  Future<void> addTheGeneralStateModel()async {
    try{
      await Hive.box<GeneralStatsModel>(AppStrings.generalStatisticsBox).add(
          GeneralStatsModel.copyWith (balance: 0,
              topIncome: 'No Income Added',
              topIncomeAmount: 0,
              topExpense: 'No Expense Added',
              topExpenseAmount: 0,
              latestCheck: DateTime.now(),
              notificationList: []));
    }catch (error){
      print('Error adding general stats model for the first time is ${error.toString()}');
    }
  }

}