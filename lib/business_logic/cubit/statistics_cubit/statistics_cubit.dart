import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:temp/business_logic/repository/transactions_repo/transaction_repo.dart';
import 'package:temp/data/models/statistics/expenses_lists.dart';
import 'package:temp/data/models/transactions/transaction_model.dart';

part 'statistics_state.dart';

class StatisticsCubit extends Cubit<StatisticsState> {
  StatisticsCubit(this._expensesRepository) : super(StatisticsInitial());
  List<TransactionModel> allExpensesList = [];
  List<TransactionModel> allIncomeList = [];
  List<TransactionModel> byDayList=[];
  List<TransactionModel> week1=[];
  List<TransactionModel> week2=[];
  List<TransactionModel> week3=[];
  List<TransactionModel> week4=[];
  num totalWeek1 = 0;
  num totalWeek2 = 0;
  List<List<TransactionModel>> monthList=[];



  final TransactionRepo _expensesRepository;

  List<String> noRepeats = ExpensesLists().noRepeats;
  DateTime choosenDay=DateTime.now();


  int currentIndex = 0;



  List<TransactionModel> getExpenses() {
    allExpensesList = _expensesRepository.getTransactionFromTransactionBox(true);
    return allExpensesList;
  }
  List<TransactionModel> getIncome() {
    allIncomeList = _expensesRepository.getTransactionFromTransactionBox(false);
    return allIncomeList;
  }
   getExpensesByDay(DateTime date){
    choosenDay=date;
    List<TransactionModel> dayList=[];
    dayList.addAll(getExpenses().where((element) =>checkSameDay(element)).toList());
    byDayList.clear();
    byDayList=List.from(dayList);
    emit(StatisticsByDayList());

  }

  //TODO Get Date Format logic to get Day's name

  getExpenseByMonth(DateTime chosenDate){
    /// to prevent duplicate data
    monthList.clear();
  final month=  chosenDate;
  allExpensesList.forEach((element) {
      if(element.paymentDate.month== month && element.paymentDate.day < 8){
        /// To add day in the first week to monthlist[0] index number 0
        monthList[0].add(element);
        /// To equalize monthList[0] with week1 variable above
        week1 = monthList[0];
        /// to add amount of the element to the week total amount
        totalWeek1 = element.amount! + totalWeek1 ;

      } else if (7> element.paymentDate.month== month && element.paymentDate.day  < 15){
        monthList[1].add(element);
        week2 = monthList[1];
        totalWeek2 = element.amount! + totalWeek2 ;
      }
    });


    monthList[0].addAll(allExpensesList.where((element) =>element.paymentDate.month== month && element.paymentDate.day < 8
    ) );
    monthList[1].addAll(allExpensesList.where((element) => 7> element.paymentDate.month== month && element.paymentDate.day  < 15
    ) );
    monthList[2].addAll(allExpensesList.where((element) => 15> element.paymentDate.month== month && element.paymentDate.day  < 22
    ) );
    monthList[3].addAll(allExpensesList.where((element) =>  element.paymentDate.month== month && element.paymentDate.day  > 21
    ) );

  }
  bool checkSameDay(TransactionModel model){
    if(model.paymentDate.day==choosenDay.day &&model.paymentDate.month==choosenDay.month&&model.paymentDate.year==choosenDay.year){
      return true;
    }else{
      return false;
    }
  }
}
