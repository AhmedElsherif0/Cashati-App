import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:temp/business_logic/repository/expenses_repo/expenses_repo.dart';
import 'package:temp/business_logic/repository/income_repo/income_repo.dart';
import 'package:temp/data/models/transactions/transaction_details_model.dart';
import '../../../data/models/transactions/expenses_lists.dart';

part 'income_repeat_state.dart';

class IncomeRepeatCubit extends Cubit<IncomeRepeatCubitStates> {
  IncomeRepeatCubit(this._incomeRepository) : super(IncomeRepeatCubitInitial());

  final IncomeRepository _incomeRepository;

  List<String> noRepeats = ExpensesLists().noRepeats;

  int currentIndex = 0;

  List<TransactionRepeatDetailsModel> getIncomeTypeList() {
    return _incomeRepository.getIncomeTypeList(currentIndex);
  }

  void changePage({required int index}) {
    currentIndex = index;
    emit(IncomeRepeatScreenState());
  }

  String _convertedCurrentDay(DateTime inputDate) {
    String currentTime = DateFormat('dd/MM/yyyy').format(inputDate.toUtc());
    final currentTimeAfter = currentTime.replaceFirst('0', '');
    return currentTimeAfter;
  }
}
