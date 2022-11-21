import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:temp/data/models/expenses/expense_model.dart';
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
    List<List<ExpenseRepeatDetailsModel>> expenseTypesList = [
      _getExpenseDailyList(),
      _getExpenseWeeklyList(),
      _getExpenseMonthlyList(),
      _getExpenseNoRepeatList(),
    ];

    return expenseTypesList[currentIndex];
  }

  void changePage({required int index}) {
    currentIndex = index;
    emit(ExpenseRepeatScreenState());
  }

  List<ExpenseRepeatDetailsModel> _getExpenseDailyList() {
    List<ExpenseRepeatDetailsModel> dailyList = [];
    try {
      dailyList = _expenseRepeatRepo.getRepeatDaily().toList();
    } catch (error) {
      print(error.toString());
    }
    return dailyList;
  }

  List<ExpenseRepeatDetailsModel> _getExpenseWeeklyList() {
    /// Dummy Data that used for Testing.
    List<ExpenseRepeatDetailsModel> weeklyList = [
      ExpenseRepeatDetailsModel.copyWith(
          lastConfirmationDate: DateTime.now(),
          isLastConfirmed: true,
          creationDate: DateTime.now(),
          expenseModel: ExpenseModel(),
          lastShownDate: DateTime.now(),
          nextShownDate: DateTime.now()),
      ExpenseRepeatDetailsModel.copyWith(
          lastConfirmationDate: DateTime.now(),
          isLastConfirmed: true,
          creationDate: DateTime.now(),
          expenseModel: ExpenseModel(),
          lastShownDate: DateTime.now(),
          nextShownDate: DateTime.now()),
    ];
    try {
      ///  _expenseRepeatRepo.openExpenseRepeatBox();
      weeklyList = _expenseRepeatRepo.getRepeatDaily().toList();
    } catch (error) {
      print(error.toString());
    }
    return weeklyList;
  }

  List<ExpenseRepeatDetailsModel> _getExpenseMonthlyList() {
    List<ExpenseRepeatDetailsModel> monthlyList = [];
    try {
      monthlyList = _expenseRepeatRepo.getRepeatDaily().toList();
    } catch (error) {
      print(error.toString());
    }
    return monthlyList;
  }

  List<ExpenseRepeatDetailsModel> _getExpenseNoRepeatList() {
    List<ExpenseRepeatDetailsModel> noRepeatList = [];
    try {
      noRepeatList = _expenseRepeatRepo.getRepeatDaily().toList();
    } catch (error) {
      print(error.toString());
    }
    return noRepeatList;
  }

  String _convertedCurrentDay() {
    String currentTime =
        DateFormat('dd/MM/yyyy').format(DateTime.now().toUtc());
    final currentTimeAfter = currentTime.replaceFirst('0', '');
    return currentTimeAfter;
  }
}
