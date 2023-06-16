import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:temp/business_logic/repository/expenses_repo/confirm_expense_repo.dart';
import 'package:temp/business_logic/repository/general_stats_repo/general_stats_repo.dart';
import 'package:temp/data/local/hive/app_boxes.dart';
import 'package:temp/data/models/notification/notification_model.dart';
import 'package:temp/data/models/statistics/general_stats_model.dart';
import 'package:temp/data/repository/transactions_impl/confirm_transaction_repo_impl.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.generalStatsRepo) : super(HomeInitial());
  final GeneralStatsRepo generalStatsRepo;
   GeneralStatsModel? generalStatsModel;
   ConfirmTransactionRepo confirmTransactionRepo =ConfirmTransactionImpl();
   List<NotificationModel>? notificationList;
  bool isExpense = true;
  bool isGotNotifications=false;

  checkItemInBox()async{
    if(await generalStatsRepo.isGeneralModelExists()){
      emit(ModelExistsSuccState());
    }else{
      emit(ModelExistsFailState());
    }
  }

  Future fetchTopExpAndTopInc()async{
    await generalStatsRepo.fetchTopExpenseAndTopIncome();
  }


  Future addTheGeneralStatsModel()async{
   // await HiveHelper().openBox<GeneralStatsModel>(boxName: AppBoxes.generalStatisticsModel);

    if(Hive.box<GeneralStatsModel>(AppBoxes.generalStatisticsModel).isNotEmpty){
      print('General stats model is in box already ${generalStatsRepo.getTheGeneralStatsModel()}');
      emit(FetchedGeneralModelSuccState());
      return;
    }else{
      await generalStatsRepo.addTheGeneralStateModel().then((value)async {
      //  generalStatsModel=await getTheGeneralStatsModel();
        print('General stats model in cubit is ${generalStatsModel}');
      });
      emit(AddedGeneralModelSuccState());

    }

  }
 Future getTheGeneralStatsModel()async{
    generalStatsModel = await generalStatsRepo.getTheGeneralStatsModel();
    if(generalStatsModel==null){
      emit(ModelExistsFailState());

    }else{
      emit(ModelExistsSuccState());
    }


  }
  Future getNotificationList()async{
    notificationList= await generalStatsRepo.getNotifications(didOpenAppToday: isGotNotifications);
    if(notificationList==null){
      emit(FetchedNotificationListFailedState());
    }else{
      emit(FetchedNotificationListSuccState());

    }
  }

  void isItExpense() {
    isExpense = !isExpense;
    emit(SuccessState());
  }

  onYesTransactionNotification(NotificationModel notificationModel)async{
    await confirmTransactionRepo.onYesConfirmedFromNotifications(notificationModel: notificationModel).whenComplete(()async => await generalStatsRepo.ChangeStatusOfNotification(notificationModel));
    emit(NotificationYesActionTakenSucc());
  }

  void onShowExpense() {}

  void onShowIncome() {}
}
