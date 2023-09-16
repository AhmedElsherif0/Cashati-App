import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:temp/business_logic/repository/transactions_repo/transaction_repo.dart';

import '../../../data/models/transactions/transaction_model.dart';

part 'income_repeat_state.dart';

class IncomeRepeatCubit extends Cubit<IncomeRepeatCubitStates> {
  IncomeRepeatCubit(this._incomeRepository) : super(IncomeRepeatCubitInitial());

  final TransactionRepo _incomeRepository;

  int currentIndex = 0;

  List<TransactionModel> getRepeatTransactions(int currentIndex) {
    List<TransactionModel> sortedList =
        _incomeRepository.getTransactionTypeList(currentIndex);
    sortedList.sort((a, b) => a.createdDate.compareTo(b.createdDate));
    return sortedList;
  }

  num highestTransaction() => getRepeatTransactions(currentIndex)
      .reduce((current, next) => current.amount > next.amount ? current : next)
      .amount;

  void changePage({required int index}) {
    currentIndex = index;
    emit(IncomeRepeatScreenState());
  }
}
