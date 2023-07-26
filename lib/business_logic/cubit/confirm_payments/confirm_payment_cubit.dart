import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:temp/business_logic/repository/expenses_repo/confirm_expense_repo.dart';
import 'package:temp/business_logic/repository/general_stats_repo/general_stats_repo.dart';
import 'package:temp/business_logic/repository/goals_repo/goals_repo.dart';
import 'package:temp/data/models/goals/goal_model.dart';
import 'package:temp/data/models/transactions/transaction_model.dart';
import 'package:temp/data/repository/general_stats_repo_impl/general_stats_repo_impl.dart';
import 'package:temp/data/repository/goals_repo_impl/goals_repo_impl.dart';
import 'package:temp/data/repository/transactions_impl/confirm_transaction_repo_impl.dart';

import '../home_cubit/home_cubit.dart';

part 'confirm_payment_state.dart';

class ConfirmPaymentCubit extends Cubit<ConfirmPaymentState> {
  ConfirmPaymentCubit() : super(ConfirmPaymentInitial());

  final ConfirmTransactionRepo transactionRep=ConfirmTransactionImpl();
  final GoalsRepository goalsRepository=GoalsRepoImpl();
  final GeneralStatsRepo generalStatsRepo=GeneralStatsRepoImpl();

  List<TransactionModel> allTodayList=[];
  List<TransactionModel> allTodayListIncome=[];
  List<GoalModel> allTodayGoals=[];
  num? newAmount;
  num? newAmountIncome;
  int currentIndex=0;
  List<double> test = [1000,2000,3000];



  Future<void> onYesConfirmed({

    required TransactionModel theAddedExpense})async{
    print('Yes confirmed');

    try{
      await transactionRep.onYesConfirmed(addedExpense: theAddedExpense);
      theAddedExpense.isExpense?allTodayList.remove(theAddedExpense):allTodayListIncome.remove(theAddedExpense);
    }catch(e){
      print('error is $e');
    }
    emit(YesConfirmedState());
  }

  Future<void> onNoConfirmed({

    required TransactionModel theAddedExpense})async{
    print('No confirmed');
    await transactionRep.onNoConfirmed(addedExpense:  theAddedExpense);
    theAddedExpense.isExpense?allTodayList.remove(theAddedExpense):allTodayListIncome.remove(theAddedExpense);

    emit(NoConfirmedState());

  }





  Future<void> onYesConfirmedGoal({

    required GoalModel goalModel})async{
    print('Yes confirmed');

    try{
      await goalsRepository.yesConfirmGoal(goalModel: goalModel,newAmount: goalModel.goalSaveAmount);
      goalsRepository.getTodayGoals();
      allTodayGoals.remove(goalModel);

    }catch(e){
      print('error is $e');
    }

    emit(YesConfirmedState());

  }

  Future<void> onNoConfirmedGoal({

    required GoalModel goalModel})async{
    print('No confirmed');
    await goalsRepository.noConfirmGoal(goalModel: goalModel,newAmount: goalModel.goalSaveAmount);
    allTodayGoals.remove(goalModel);
    emit(NoConfirmedState());

  }

  onChangeIndex(int index){
    currentIndex =index;
    emit(ChangeTabIndexState());
  }

  onChangeAmount(double amount , double newAmount){
    newAmount = amount;
    emit(ChangedAmountState());
  }

  onDeleteTransaction(TransactionModel transactionModel,BuildContext context)async{
    try{
      await transactionRep.deleteTransactionPermanently(transactionModel);
      if(transactionModel.isExpense){
        allTodayList.remove(transactionModel);

      }else{

        allTodayListIncome.remove(transactionModel);
      }
      context.read<HomeCubit>().notificationList!.removeWhere((element) => element.modelName==transactionModel.name);

      emit(DeletedTransactionSucc());

    }catch(error){
      emit(DeletedTransactionFailure());

    }
  }

}
