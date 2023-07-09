import 'package:bloc/bloc.dart';
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
  num totalImport = 0, totalNotImport = 0, chosenDayTotal = 0;
  List<List<TransactionModel>> monthList = [];
  List<List<TransactionModel>> weeks = List.generate(5, (_) => []);
  num importantWeeks = 0;
  List<num> totalsWeeks = List.from([0, 0, 0, 0, 0]);
  DateTime chosenDay = DateTime.now();
  int currentIndex = 0;

  /// 1- count the total.\

  num getTotalExpense({bool isExpense = true}) {
    return (isExpense ? getExpenses() : getIncome())
        .where(checkSameDay)
        .fold(0, (total, transaction) => total + transaction.amount);
  }

  /// 2- filter the amount based on the important.

  double totalImportantExpenses({bool isExpense = true}) {
    /// we need an condition for Important Income.
    final List<TransactionModel> importantExpense =
        (isExpense ? getExpenses() : getIncome())
            .where((transaction) =>
                (checkSameDay(transaction) && transaction.isPriority == true))
            .toList();
    return importantExpense.fold(0, (value, element) => value += element.amount);
  }

  List<TransactionModel> getExpenses() {
    return _expensesRepository.getTransactionFromTransactionBox();
  }

  List<TransactionModel> getIncome() {
    return _expensesRepository.getTransactionFromTransactionBox(isExpense: false);
  }

  void getExpensesByDay(DateTime date, bool isExpense) {
    chosenDay = date;
    byDayList = getTodayExpenses(isExpense);
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

  List<TransactionModel> getTodayExpenses(bool isExpense) => byDayList = isExpense
      ? getExpenses().where((element) => checkSameDay(element)).toList()
      : getIncome().where((element) => checkSameDay(element)).toList();

  getTransactionsByMonth(bool isExpense) {
    _resetData();
    monthTransactions = isExpense ? getExpenses() : getIncome();
    print('get Income length ${getIncome()}');

    /// Categorize the transactions by week and calculate the totals
    for (TransactionModel transaction in monthTransactions) {
      if (transaction.paymentDate.month == chosenDay.month) {
        importantWeeks += transaction.amount;
        int weekNumber = (transaction.paymentDate.day - 1) ~/ 7;
        weeks[weekNumber].add(transaction);
        totalsWeeks[weekNumber] += transaction.amount;
      }
    }
    print('importantWeeks  $importantWeeks');
    emit(FetchedMonthData());
  }

  void _resetData() {
    monthTransactions = [];
    weeks = List.generate(5, (_) => []);
    importantWeeks = 0;
    totalsWeeks = List.from([0, 0, 0, 0, 0]);
  }

  List<Map<String, num>> get transactionsValues => List.generate(totalsWeeks.length,
      (index) => {'totalWeeks': totalsWeeks[index], 'expense': importantWeeks});

  bool checkSameDay(TransactionModel model) {
    if (model.paymentDate.day == chosenDay.day &&
        model.paymentDate.month == chosenDay.month &&
        model.paymentDate.year == chosenDay.year) {
      return true;
    } else {
      return false;
    }
  }

  changeDatePicker(dateTime) {
    chosenDay = dateTime;
    emit(ChoseDateSucc());
  }

  List<String> weekRangeText() => getWeekRange(chosenDay: chosenDay);
}
