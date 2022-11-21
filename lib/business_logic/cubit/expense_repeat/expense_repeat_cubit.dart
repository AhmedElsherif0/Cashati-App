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
  ExpenseRepeatCubit() : super(ExpenseRepeatInitial());

  final ExpenseRepeatRepo _expenseRepeatRepo = ExpensesRepeatImpl();
  List<String> noRepeats = ExpensesLists().noRepeats;

  int currentIndex = 0;

  List<ExpenseRepeatDetailsModel> getExpenseTypeList() {
    List<List<ExpenseRepeatDetailsModel>> expenseTypesList = [];
    try {
      expenseTypesList = [
        _expenseRepeatRepo.getRepeatDaily(),
        _expenseRepeatRepo.getRepeatWeekly(),
        _expenseRepeatRepo.getRepeatMonthly(),
        _expenseRepeatRepo.getRepeatNoRepeat(),
      ];
    } catch (error) {
      print(' ${error.toString()}');
    }
    return expenseTypesList[currentIndex];
  }

  void changePage({required int index}) {
    currentIndex = index;
    emit(ExpenseRepeatScreenState());
  }

  String _convertedCurrentDay() {
    String currentTime =
        DateFormat('dd/MM/yyyy').format(DateTime.now().toUtc());
    final currentTimeAfter = currentTime.replaceFirst('0', '');
    return currentTimeAfter;
  }
}
