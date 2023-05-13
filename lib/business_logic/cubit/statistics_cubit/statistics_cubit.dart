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
  List<TransactionModel> byDayList = [];
  List<TransactionModel> week1 = [];
  List<TransactionModel> week2 = [];
  List<TransactionModel> week3 = [];
  List<TransactionModel> week4 = [];
  List<num> totals = [];
  num totalWeek1 = 0;
  num totalWeek2 = 0;
  num totalWeek3 = 0;
  num totalWeek4 = 0;
  List<List<TransactionModel>> monthList = [];

  final TransactionRepo _expensesRepository;

  List<String> noRepeats = ExpensesLists().noRepeats;
  DateTime choosenDay = DateTime.now();

  int currentIndex = 0;

  /// filter the amount based on the important and notImportant...
  double totalExpenses({required bool isPriority}) {
    final List<TransactionModel> importantExpense = getExpenses()
        .where((element) => checkSameDay(element) &&
        element.isPriority == isPriority).toList();
    final double totalSalary =
        importantExpense.fold(0, (value, element) => value += element.amount);
    print('statistics total Expense is $totalSalary');
    return totalSalary;
  }

  List<TransactionModel> getExpenses() {
    allExpensesList = _expensesRepository.getTransactionFromTransactionBox(true);
    return allExpensesList;
  }

  List<TransactionModel> getIncome() {
    allIncomeList = _expensesRepository.getTransactionFromTransactionBox(false);
    return allIncomeList;
  }

  getExpensesByDay(DateTime date) {
    choosenDay = date;
    print(choosenDay);
    List<TransactionModel> dayList = [];
    dayList.addAll(getExpenses().where((element) =>
        checkSameDay(element)).toList());
    byDayList.clear();
    byDayList = List.from(dayList);
    emit(StatisticsByDayList());
  }

  //TODO Get Date Format logic to get Day's name

  getExpenseByMonth() {
    /// to prevent duplicate data
    monthList.clear();
    totalWeek1 = 0;
    totalWeek2 = 0;
    totalWeek3 = 0;
    totalWeek4 = 0;

    totals.clear();

    final month = 4;
    print("expensesssss ${allExpensesList}");
    allExpensesList.forEach((element) {
      if (element.paymentDate.month == month && element.paymentDate.day < 8) {
        /// To add day in the first week to monthlist[0] index number 0
        // monthList[0].add(element);
        // /// To equalize monthList[0] with week1 variable above
        // week1 = monthList[0];
        week1.add(element);

        /// to add amount of the element to the week total amount
        totalWeek1 = element.amount + totalWeek1;
      } else if (element.paymentDate.month == month &&
          7 < element.paymentDate.day &&
          element.paymentDate.day < 15) {
        // monthList[1].add(element);
        // week2 = monthList[1];
        week2.add(element);

        totalWeek2 = element.amount + totalWeek2;
      } else if (element.paymentDate.month == month &&
          14 < element.paymentDate.day &&
          element.paymentDate.day < 24) {
        // monthList[2].add(element);
        // week3 = monthList[2];
        week3.add(element);
        totalWeek3 = element.amount + totalWeek3;
      } else if (element.paymentDate.month == month && element.paymentDate.day > 23) {
        // monthList[3].add(element);
        // week4 = monthList[3];
        week4.add(element);

        totalWeek4 = element.amount + totalWeek4;
      }
    });
    print("totalsssssssssss $totals");
    print("month $monthList");
    print("totalsssssssssss $totals");
    monthList.insert(0, week1);
    monthList.insert(1, week2);
    monthList.insert(2, week3);
    monthList.insert(3, week4);
    totals.insert(0, totalWeek1);
    totals.insert(1, totalWeek2);
    totals.insert(2, totalWeek3);
    totals.insert(3, totalWeek4);

    print("totalsssssssssss2 $totals");

    // monthList[0].addAll(allExpensesList.where((element) =>element.paymentDate.month== month && element.paymentDate.day < 8
    // ) );
    // monthList[1].addAll(allExpensesList.where((element) => 7> element.paymentDate.month== month && element.paymentDate.day  < 15
    // ) );
    // monthList[2].addAll(allExpensesList.where((element) => 15> element.paymentDate.month== month && element.paymentDate.day  < 22
    // ) );
    // monthList[3].addAll(allExpensesList.where((element) =>  element.paymentDate.month== month && element.paymentDate.day  > 21
    // ) );
  }

  bool checkSameDay(TransactionModel model) {
    if (model.paymentDate.day == choosenDay.day &&
        model.paymentDate.month == choosenDay.month &&
        model.paymentDate.year == choosenDay.year) {
      return true;
    } else {
      return false;
    }
  }
}
