import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:temp/business_logic/repository/transactions_repo/transaction_repo.dart';
import 'package:temp/data/models/transactions/transaction_model.dart';
import 'package:temp/data/repository/helper_class.dart';

part 'statistics_state.dart';

class StatisticsCubit extends Cubit<StatisticsState> with HelperClass {
  StatisticsCubit(this._expensesRepository) : super(StatisticsInitial());
  final TransactionRepo _expensesRepository;
  List<TransactionModel> monthTransactions = [];
  List<TransactionModel> byDayList = [];
  num totalImport = 0;
  num totalNotImport = 0;
  num chosenDayTotal = 0;
  List<List<TransactionModel>> monthList = [];
  List<List<TransactionModel>> weeks = List.generate(5, (_) => []);
  List<num> importantWeeks = List.from([0, 0, 0, 0, 0]);
  List<num> totals = List.from([0, 0, 0, 0, 0]);
  DateTime choosenDay = DateTime.now();
  int currentIndex = 0;

  /// 1- count the total.\

  num getTotalExpense() => getExpenses()
      .where(checkSameDay)
      .fold(0, (total, transaction) => total + transaction.amount);

  /// 2- filter the amount based on the important.

  double totalImportantExpenses({required bool isPriority}) {
    final List<TransactionModel> importantExpense = getExpenses()
        .where((element) => checkSameDay(element) && element.isPriority == isPriority)
        .toList();
    final double totalSalary =
        importantExpense.fold(0, (value, element) => value += element.amount);
    return totalSalary;
  }

  List<TransactionModel> getExpenses() {
    return _expensesRepository.getTransactionFromTransactionBox(true);
  }

  List<TransactionModel> getIncome() {
    return _expensesRepository.getTransactionFromTransactionBox(false);
  }

  getExpensesByDay(DateTime date, bool isExpense) {
    choosenDay = date;
    getTodayExpenses(isExpense);
    byDayList.map((e) => print(" priorityyyyy ${e.isPriority}"));
    byDayList.forEach((element) {
      if (element.isPriority) {
        /// Green space
        totalImport = totalImport + element.amount;
      } else {
        /// Grey space
        totalNotImport = totalNotImport + element.amount;
      }
      chosenDayTotal = chosenDayTotal + element.amount;
    });
    emit(StatisticsByDayList());
  }

  getTodayExpenses(bool isExpense) {
    byDayList.clear();
    byDayList = isExpense
        ? getExpenses().where((element) => checkSameDay(element)).toList()
        : getIncome().where((element) => checkSameDay(element)).toList();
    emit(StatisticsByDayList());
  }

  //TODO Get Date Format logic to get Day's name

  getTransactionsByMonth(bool isExpense) {
    /// to prevent duplicate data
    monthTransactions.clear();
    print("current month is ${choosenDay.month}");
    monthTransactions = isExpense ? getExpenses() : getIncome();

    /// Categorize the transactions by week and calculate the totals
    for (TransactionModel transaction in monthTransactions) {
      if (transaction.paymentDate.month == choosenDay.month) {
        int weekNumber = (transaction.paymentDate.day - 1) ~/ 7;
        weeks[weekNumber].add(transaction);
        totals[weekNumber] += transaction.amount;
        if (transaction.isPriority) {
          importantWeeks[weekNumber] += transaction.amount;
        }
      }
    }
    print("totalsssssssssss $totals");
    print("month $monthList");
    emit(FetchedMonthData());
  }

  List<Map<String, num>> transactionsValues() => List.generate(weeks.length,
      (index) => {'amount': totals[index], 'expense': importantWeeks[index]});

  bool checkSameDay(TransactionModel model) {
    if (model.paymentDate.day == choosenDay.day &&
        model.paymentDate.month == choosenDay.month &&
        model.paymentDate.year == choosenDay.year) {
      return true;
    } else {
      return false;
    }
  }

  chooseMonth(DateTime dateTime) {
    choosenDay = dateTime;
    emit(ChoseDateSucc());
  }

  List<String> weekRangeText() => getWeekRange(chosenDay: choosenDay);
}
