import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:temp/business_logic/repository/expenses_repo/confirm_expense_repo.dart';
import 'package:temp/business_logic/repository/general_stats_repo/general_stats_repo.dart';
import 'package:temp/business_logic/repository/goals_repo/goals_repo.dart';
import 'package:temp/business_logic/repository/transactions_repo/transaction_repo.dart';
import 'package:temp/data/local/hive/app_boxes.dart';
import 'package:temp/data/models/notification/notification_model.dart';
import 'package:temp/data/models/statistics/general_stats_model.dart';
import 'package:temp/data/repository/expenses_repo_impl/expenses_repo_impl.dart';
import 'package:temp/data/repository/goals_repo_impl/goals_repo_impl.dart';
import 'package:temp/data/repository/transactions_impl/confirm_transaction_repo_impl.dart';

import '../../../data/models/transactions/transaction_model.dart';
import '../../../data/repository/income_repo_impl/income_repo_impl.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.generalStatsRepo) : super(HomeInitial());
  final GeneralStatsRepo generalStatsRepo;
  GeneralStatsModel? generalStatsModel;
  ConfirmTransactionRepo confirmTransactionRepo = ConfirmTransactionImpl();
  TransactionRepo transactionRepo = ExpensesRepositoryImpl();

  GoalsRepository _goalsRepository = GoalsRepoImpl();

  //TODO confirm goal notification
  List<NotificationModel>? notificationList;
  bool isExpense = true;
  bool isGotNotifications = false;

  Future checkUpdate(BuildContext context) async {
    final newVersion = NewVersionPlus(androidId: "com.cashati.team");
    final status = await newVersion.getVersionStatus();
    if (status != null) {
      newVersion.showUpdateDialog(
        context: context,
        versionStatus: status,
        dialogText:
            "A new version has been released, update cashati to get the most recent features.",
      dialogTitle: "Update Required",updateButtonText: "Update",dismissButtonText: "Not Now",dismissAction: ()=>Navigator.pop(context));
    }
  }

  String notificationsNumber() => notificationList != null
      ? notificationList!
          .where((element) => element.didTakeAction == false)
          .toList()
          .length
          .toString()
      : "0";

  TransactionModel fetchHighestTransaction() {
    if (isExpense) {
      transactionRepo = ExpensesRepositoryImpl();
      return transactionRepo.getTransactionByNameFromRepeated(
          generalStatsModel!.topExpense,
          isExpense,
          generalStatsModel!.topExpenseAmount);
    } else {
      transactionRepo = IncomeRepositoryImpl();
      return transactionRepo.getTransactionByNameFromRepeated(
          generalStatsModel!.topIncome,
          !isExpense,
          generalStatsModel!.topIncomeAmount);
    }
  }

  // TODO: unused Function:
  checkItemInBox() {
    if (generalStatsRepo.isGeneralModelExists()) {
      emit(ModelExistsSuccState());
    } else {
      emit(ModelExistsFailState());
    }
  }

  Future fetchTopExpAndTopInc() async {
    await generalStatsRepo.fetchTopExpenseAndTopIncome();
  }

  Future addTheGeneralStatsModel() async {
    if (Hive.box<GeneralStatsModel>(AppBoxes.generalStatisticsModel)
        .isNotEmpty) {
      print(
          'General stats model is in box already ${generalStatsRepo.getTheGeneralStatsModel()}');
      emit(FetchedGeneralModelSuccState());
      return;
    } else {
      await generalStatsRepo.addTheGeneralStateModel().then((value) async {
        //  generalStatsModel=await getTheGeneralStatsModel();
        print('General stats model in cubit is ${generalStatsModel}');
      });
      emit(AddedGeneralModelSuccState());
    }
  }

  Future getTheGeneralStatsModel() async {
    generalStatsModel = await generalStatsRepo.getTheGeneralStatsModel();
    if (generalStatsModel == null) {
      emit(ModelExistsFailState());
    } else {
      emit(ModelExistsSuccState());
    }
  }

  Future getNotificationList() async {
    notificationList = await generalStatsRepo.getNotifications(
        didOpenAppToday: isGotNotifications);
    if (notificationList == null) {
      emit(FetchedNotificationListFailedState());
    } else {
      emit(FetchedNotificationListSuccState());
    }
  }

  void isItExpense() {
    isExpense = !isExpense;
    emit(SuccessState());
  }

  onYesTransactionNotification(NotificationModel notificationModel) async {
    if (notificationModel.typeName == "Goal") {
      await _goalsRepository
          .yesConfirmGoalFromNotification(notificationModel: notificationModel)
          .whenComplete(() async => await generalStatsRepo
              .changeStatusOfNotification(notificationModel));
    } else {
      await confirmTransactionRepo
          .onYesConfirmedFromNotifications(notificationModel: notificationModel)
          .whenComplete(() async => await generalStatsRepo
              .changeStatusOfNotification(notificationModel));
    }

    emit(NotificationYesActionTakenSucc());
  }

  onRemoveNotification(NotificationModel notificationModel) async {
    await generalStatsRepo.changeStatusOfNotification(notificationModel);
    emit(RemoveNotificationState());
  }

  onRemoveNotificationForDeletedTransaction(
      String notificationModelName) async {
    await generalStatsRepo.deleteNotificationByName(notificationModelName);
    emit(RemoveNotificationState());
  }

  void onShowExpense() {}

  void onShowIncome() {}
}
