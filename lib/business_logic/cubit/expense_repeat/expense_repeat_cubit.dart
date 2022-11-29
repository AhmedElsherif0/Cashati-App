import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import '../../../data/models/expenses/expense_details_model.dart';
import '../../../data/models/expenses/expenses_lists.dart';
import '../../../data/repository/expenses_repeat/expenses_repeat_impl.dart';
import '../../repository/expense_repeat/expense_repeat_repo.dart';

part 'expense_repeat_state.dart';

class ExpenseRepeatCubit extends Cubit<ExpenseRepeatState> {
  ExpenseRepeatCubit(this._expenseRepeatRepo) : super(ExpenseRepeatInitial());

  final ExpenseRepeatRepo _expenseRepeatRepo ;
  List<String> noRepeats = ExpensesLists().noRepeats;

  int currentIndex = 0;

  List<ExpenseRepeatDetailsModel> getExpenseTypeList() {
    return _expenseRepeatRepo.getExpenseTypeList(currentIndex);
  }

  void changePage({required int index}) {
    currentIndex = index;
    emit(ExpenseRepeatScreenState());
  }

  String _convertedCurrentDay(DateTime inputDate) {
    String currentTime = DateFormat('dd/MM/yyyy').format(inputDate.toUtc());
    final currentTimeAfter = currentTime.replaceFirst('0', '');
    return currentTimeAfter;
  }
}
