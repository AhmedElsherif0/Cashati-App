import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:temp/business_logic/repository/general_stats_repo/general_stats_repo.dart';
import 'package:temp/business_logic/repository/subcategories_repo/expense_subcategory_repo.dart';
import 'package:temp/constants/app_lists.dart';
import 'package:temp/constants/app_strings.dart';
import 'package:temp/data/local/hive/app_boxes.dart';
import 'package:temp/data/local/hive/hive_database.dart';
import 'package:temp/data/models/statistics/general_stats_model.dart';
import 'package:temp/data/models/transactions/transaction_model.dart';
import 'package:temp/data/repository/subcategories_repo_impl/expense_subcategory_repo_impl.dart';
import 'package:temp/data/repository/subcategories_repo_impl/income_subcategory_repo_impl.dart';

import '../../../constants/app_icons.dart';
import '../../../data/models/subcategories_models/expense_subcaegory_model.dart';
import '../../repository/transactions_repo/transaction_repo.dart';

part 'add_exp_or_inc_state.dart';

class AddExpOrIncCubit extends Cubit<AddExpOrIncState> {
  AddExpOrIncCubit(
      this._expensesRepository, this._incomeRepository, this._generalStatsRepo)
      : super(AddExpOrIncInitial());
  String currentID = '';
  String subCatName = '';
  DateTime chosenDate = DateTime.now();
  String currentMainCat = '';
  num currentAmount = 0;
  int currentIndex = 0;

  List<Color> lastColorList = [];
  bool isExpense = true;
  List<String> expMainCats = const [
    AppStrings.home,
    AppStrings.personal,
    AppStrings.business
  ];
  List<String> expMainIcons = const [
    AppIcons.home,
    AppIcons.person,
    AppIcons.business
  ];
  List<String> incomeMainCats = const [AppStrings.fixed, AppStrings.variable];
  List<String> incomeMainIcons = const [AppIcons.fixed, AppIcons.variable];
  List<SubCategory> personalSubCatsList = [];
  List<SubCategory> homeSubCatsList = [];
  List<SubCategory> businessSubCatsList = [];
  List<SubCategory> fixedSubCatsList = [];
  List<SubCategory> variableSubCatsList = [];

  final AppConstantList appList = AppConstantList();

  String choseRepeat = AppStrings.noRepeat;
  bool isRepeat = false;
  bool isImportant = false;

  List<DropdownMenuItem<String>> dropDownChannelItems = [
    DropdownMenuItem(value: AppStrings.daily, child: Text(AppStrings.daily.tr())),
    DropdownMenuItem(value: AppStrings.weekly, child: Text(AppStrings.weekly.tr())),
    DropdownMenuItem(value: AppStrings.monthly, child: Text(AppStrings.monthly.tr()))
  ];

  final TransactionRepo _expensesRepository;
  final TransactionRepo _incomeRepository;
  final GeneralStatsRepo _generalStatsRepo;

  chooseMainCategory(String mainCategory) {
    currentMainCat = mainCategory;
    print('current main cat is ${currentMainCat}');
    _resetSubCategory();
  }

  _resetSubCategory() {
    currentID = '';
    emit(ChoosedSubCategoryState());
  }

  chooseRepeat(String value) {
    choseRepeat = (isRepeat ? value : AppStrings.noRepeat);
    emit(ChoosedRepeatState());
  }

  changeCurrentIndex(int index) {
    currentIndex = index;
    // emit(ChangeCurrentIndex());
  }

  void isRepeatOrNo(bool? value) {
    isRepeat = value ?? false;
    emit(ChoosedRepeatState());
  }

  void isImportantOrNo(bool? value) {
    isImportant = value ?? false;
    emit(ChoosedPriorityState());
  }

  List<SubCategory> distributeExpenseSubcategories(String mainCategoryName) {
    switch (mainCategoryName) {
      case AppStrings.personal:
        return personalSubCatsList;
      case AppStrings.home:
        return homeSubCatsList;
      case AppStrings.business:
        return businessSubCatsList;
      default:
        return personalSubCatsList;
    }
  }

  List<SubCategory> distributeIncomeSubcategories(String mainCategoryName) {
    switch (mainCategoryName) {
      case AppStrings.fixed:
        return fixedSubCatsList;
      case AppStrings.variable:
        return variableSubCatsList;

      default:
        return fixedSubCatsList;
    }
  }

  List<SubCategory> _fetchExpensesSubCategories() {
    CategoryTransactionRepo subCategoryRepo = ExpenseSubCategoryImpl();
    List<SubCategory> fetchedList = [];
    try {
      fetchedList = subCategoryRepo.fetchSubCategories();
    } catch (e) {
      print('error is $e');
    }
    print('Fetched list is $fetchedList');
    return fetchedList;
  }

  List<SubCategory> _fetchIncomeSubCategories() {
    CategoryTransactionRepo incomeSubCategoryRepo = IncomeSubcategoryImpl();
    List<SubCategory> fetchedList = [];
    try {
      fetchedList = incomeSubCategoryRepo.fetchSubCategories();
    } catch (e) {
      print('error is $e');
    }
    print('Fetched list is $fetchedList');
    return fetchedList;
  }

  _filterExpenseSubCategoriesList() {
    List<SubCategory> list = _fetchExpensesSubCategories();
    personalSubCatsList.addAll(appList.expensePersonalFixedList);
    homeSubCatsList.addAll(appList.expenseHomeFixedList);
    businessSubCatsList.addAll(appList.expenseBusinessFixedList);
    if (list.isNotEmpty) {
      for (var item in list) {
        switch (item.mainCategoryName) {
          case AppStrings.personal:
            personalSubCatsList.add(item);
            break;
          case AppStrings.home:
            homeSubCatsList.add(item);
            break;
          case AppStrings.business:
            businessSubCatsList.add(item);
        }
      }
    }
  }

  _filterIncomeSubCategoriesList() {
    List<SubCategory> list = _fetchIncomeSubCategories();
    fixedSubCatsList.addAll(appList.incomeFixedSubFixedList);
    variableSubCatsList.addAll(appList.incomeVariableSubFixedList);
    if (list.isNotEmpty) {
      for (var item in list) {
        switch (item.mainCategoryName) {
          case AppStrings.fixed:
            fixedSubCatsList.add(item);
            break;
          case AppStrings.variable:
            variableSubCatsList.add(item);
            break;
        }
      }
    }
  }

  // Todo: need more explanations many mark questions ????
  void addMoreToIncomeList() {
    variableSubCatsList.clear();
    fixedSubCatsList.clear();
    _filterIncomeSubCategoriesList();
    fixedSubCatsList.insert(fixedSubCatsList.length, appList.addMoreOption);
    variableSubCatsList.insert(variableSubCatsList.length, appList.addMoreOption);
    emit(ChoosedMainCategoryState());
  }

  // Todo: need more explanations many mark questions ????
  void addMoreToExpenseList() {
    personalSubCatsList.clear();
    homeSubCatsList.clear();
    businessSubCatsList.clear();
    _filterExpenseSubCategoriesList();
    personalSubCatsList.insert(personalSubCatsList.length, appList.addMoreOption);
    homeSubCatsList.insert(homeSubCatsList.length, appList.addMoreOption);
    businessSubCatsList.insert(businessSubCatsList.length, appList.addMoreOption);
  }

  List<Color> fitRandomColors(List<SubCategory> subcategoryList) {
    //TODO recode this method as there are 3 lists for expenses and 2 for income
    if (subcategoryList.length > appList.colorsList.length) {
      for (int i = appList.colorsList.length; i < subcategoryList.length; i++) {
        appList.colorsList.add(appList.colorsList[Random().nextInt(6)]);
      }
    }
    lastColorList = appList.colorsList;
    return lastColorList;
  }

  void chooseCategory(SubCategory currentSubcategory) {
    currentID = currentSubcategory.id;
    subCatName = currentSubcategory.subCategoryName;
    emit(ChoosedSubCategoryState());
  }

  Future<void> addExpense({required TransactionModel expenseModel}) async {
    try {
      await _expensesRepository.addTransactionToTransactionBox(
          transactionModel: expenseModel);
      emit(AddExpOrIncSuccess());
    } catch (error) {
      print('this is the error ${error.toString()}');
      emit(AddExpOrIncError());
    }
  }

  Future<void> addIncome({required TransactionModel incomeModel}) async {
    try {
      await _incomeRepository.addTransactionToTransactionBox(
          transactionModel: incomeModel);
      emit(AddExpOrIncSuccess());
    } catch (error) {
      print(error.toString());
      emit(AddExpOrIncError());
    }
  }

  Future<DateTime?> changeDate(DateTime datePicker) async {
    chosenDate = datePicker;
    print('Choosed Date in cubit is ${chosenDate}');
    emit(ChoosedDateState());
    return chosenDate;
  }

  bool _isToday(todayDate) =>
      chosenDate.day == todayDate.day &&
      chosenDate.month == todayDate.month &&
      chosenDate.year == todayDate.year;

  Future checkIfTopExpOrInc() async {
    final generalModel = HiveHelper()
        .getBoxName<GeneralStatsModel>(boxName: AppBoxes.generalStatisticsBox)
        .get(AppStrings.onlyId)!;
    final todayDate = DateTime.now();
    if (_isToday(todayDate)) {
      if ((isExpense && currentAmount > generalModel.topExpenseAmount) ||
          (!isExpense && currentAmount > generalModel.topIncomeAmount)) {
        await _generalStatsRepo.fetchTopExpenseAndTopIncome();
      } else {
        print('Is Expense ${isExpense} And current amount is '
            '$currentAmount and top amount in transaction exp is '
            '${generalModel.topExpenseAmount} and top amount in transaction Inc is'
            ' ${generalModel.topIncomeAmount}');
      }
    } else {
      print('Payment was not added today to check .');
    }
  }
}
