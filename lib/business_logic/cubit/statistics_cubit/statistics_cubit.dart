import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:temp/business_logic/repository/transactions_repo/transaction_repo.dart';
import 'package:temp/data/models/statistics/expenses_lists.dart';
import 'package:temp/data/models/transactions/transaction_model.dart';

part 'statistics_state.dart';

class StatisticsCubit extends Cubit<StatisticsState> {
  StatisticsCubit(this._expensesRepository) : super(StatisticsInitial());
  List<TransactionModel> byDayList=[];



  final TransactionRepo _expensesRepository;

  List<String> noRepeats = ExpensesLists().noRepeats;
  DateTime choosenDay=DateTime.now();


  int currentIndex = 0;



  List<TransactionModel> getExpenses() {
    return _expensesRepository.getTransactionFromTransactionBox(true);
  }
   getExpensesByDay(DateTime date){
    choosenDay=date;
    List<TransactionModel> dayList=[];
    dayList.addAll(getExpenses().where((element) =>checkSameDay(element)).toList());
    byDayList.clear();
    byDayList=List.from(dayList);
    emit(StatisticsByDayList());

  }
  bool checkSameDay(TransactionModel model){
    if(model.paymentDate.day==choosenDay.day&&model.paymentDate.month==choosenDay.month&&model.paymentDate.year==choosenDay.year){
      return true;
    }else{
      return false;
    }
  }
}
