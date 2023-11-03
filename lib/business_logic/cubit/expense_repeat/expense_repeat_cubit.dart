import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:temp/business_logic/repository/transactions_repo/transaction_repo.dart';
import 'package:temp/data/models/transactions/transaction_model.dart';

part 'expense_repeat_state.dart';

class ExpenseRepeatCubit extends Cubit<ExpenseRepeatState> {
  ExpenseRepeatCubit(this._expensesRepository) : super(ExpenseRepeatInitial());

  final TransactionRepo _expensesRepository;

  int currentIndex = 0;

  List<TransactionModel> getRepeatTransactions(int currentIndex) {
    List<TransactionModel> sortedList =
        _expensesRepository.getTransactionTypeList(currentIndex);
    sortedList.sort((a, b) => a.createdDate.compareTo(b.createdDate));
    print(
        "Sorted list is ${_expensesRepository.getTransactionTypeList(currentIndex)}");

    return sortedList;
  }

  refreshData() => emit(FetchedRepeatedExpenseTransactions());

  void changePage({required int index}) {
    currentIndex = index;
    emit(ExpenseRepeatScreenState());
  }
}
