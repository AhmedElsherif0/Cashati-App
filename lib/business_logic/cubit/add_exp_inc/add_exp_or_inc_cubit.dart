import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:temp/business_logic/repository/subcategories_repo/expense_subcategory_repo.dart';
import 'package:temp/constants/app_lists.dart';
import 'package:temp/data/models/transactions/transaction_model.dart';
import 'package:temp/data/repository/subcategories_repo_impl/expense_subcategory_repo_impl.dart';
import 'package:temp/data/repository/subcategories_repo_impl/income_subcategory_repo_impl.dart';

import '../../../data/models/subcategories_models/expense_subcaegory_model.dart';
import '../../repository/transactions_repo/transaction_repo.dart';

part 'add_exp_or_inc_state.dart';

class AddExpOrIncCubit extends Cubit<AddExpOrIncState> {
  AddExpOrIncCubit(this._expensesRepository, this._incomeRepository)
      : super(AddExpOrIncInitial());
  String currentID = '';
  String subCatName = '';
  bool isSubChoosed = false;
  DateTime? chosenDate;
  String currentMainCat = '';

  List<MaterialColor> lastColorList = [];
  bool isExpense = true;
  List<String> expMainCats = ['Personal', 'Home', 'Business'];
  List<String> incomeMainCats = ['Fixed', 'Variable'];
  List<SubCategory> personalSubCatsList = [];
  List<SubCategory> homeSubCatsList = [];
  List<SubCategory> businessSubCatsList = [];
  List<SubCategory> fixedSubCatsList = [];
  List<SubCategory> variableSubCatsList = [];

  final AppConstantList appList = AppConstantList();

//  List<SubCategoryExpense> dataList=[] ;
  String choseRepeat = 'No Repeat';
  bool isRepeat = false;
  bool isImportant = false;
  CategoryTransactionRepo subCategoryRepo = ExpenseSubCategoryImpl();
  CategoryTransactionRepo incomeSubCategoryRepo = IncomeSubcategoryImpl();

  List<DropdownMenuItem<String>> dropDownChannelItems = [
    DropdownMenuItem(child: Text('Daily'), value: 'Daily'),
    DropdownMenuItem(child: Text('Weekly'), value: 'Weekly'),
    DropdownMenuItem(child: Text('Monthly'), value: 'Monthly')
  ];

  final TransactionRepo _expensesRepository;
  final TransactionRepo _incomeRepository;

  chooseMainCategory(String mainCategory) {
    currentMainCat = mainCategory;
    print('current main cat is ${currentMainCat}');
    resetSubCategory();
    emit(ChoosedMainCategoryState());
  }

  resetSubCategory() {
    currentID = '';
    emit(ChoosedSubCategoryState());
  }

  chooseRepeat(String value) {
    choseRepeat = value;
    emit(ChoosedRepeatState());
  }

  void isRepeatOrNo(bool? value) {
    isRepeat = value ?? false;
    emit(ChoosedRepeatState());
  }

  void isImportantOrNo(bool? value) {
    isImportant = value ?? false;
    if (isImportant) emit(ChoosedPriorityYesState());
    if (!isImportant) emit(ChoosedPriorityNoState());
  }

  List<SubCategory> fetchExpensesSubCategories() {
    List<SubCategory> fetchedList = [];
    try {
      fetchedList = subCategoryRepo.fetchSubCategories();
    } catch (e) {
      print('error is $e');
    }
    print('Fetched list is ${fetchedList}');
    return fetchedList;
  }

  List<SubCategory> fetchIncomeSubCategories() {
    List<SubCategory> fetchedList = [];
    try {
      fetchedList = incomeSubCategoryRepo.fetchSubCategories();
    } catch (e) {
      print('error is $e');
    }
    print('Fetched list is ${fetchedList}');
    return fetchedList;
  }

  List<SubCategory> distributeExpenseSubcategories(String mainCategoryName) {
    switch (mainCategoryName) {
      case 'Personal':
        return personalSubCatsList;
      case 'Home':
        return homeSubCatsList;
      case 'Business':
        return businessSubCatsList;
      default:
        return personalSubCatsList;
    }
  }

  List<SubCategory> distributeIncomeSubcategories(String mainCategoryName) {
    switch (mainCategoryName) {
      case 'Fixed':
        return fixedSubCatsList;
      case 'Variable':
        return variableSubCatsList;

      default:
        return fixedSubCatsList;
    }
  }

  filterExpenseSubCategoriesList() {
    List<SubCategory> list = fetchExpensesSubCategories();
    personalSubCatsList.addAll(appList.expensePersonalFixedList);
    homeSubCatsList.addAll(appList.expenseHomeFixedList);
    businessSubCatsList.addAll(appList.expenseBusinessFixedList);
    if (list.isNotEmpty) {
      for (var item in list) {
        if (item.mainCategoryName == 'Personal') {
          personalSubCatsList.add(item);
        } else if (item.mainCategoryName == 'Home') {
          homeSubCatsList.add(item);
        } else if (item.mainCategoryName == 'Business') {
          businessSubCatsList.add(item);
        } else {}
      }
    }
  }

  filterIncomeSubCategoriesList() {
    List<SubCategory> list = fetchIncomeSubCategories();
    fixedSubCatsList.addAll(appList.incomeFixedSubFixedList);
    variableSubCatsList.addAll(appList.incomeVariableSubFixedList);
    if (list.isNotEmpty) {
      for (var item in list) {
        if (item.mainCategoryName == 'Fixed') {
          fixedSubCatsList.add(item);
        } else if (item.mainCategoryName == 'Variable') {
          variableSubCatsList.add(item);
        } else {}
      }
    }
  }

  addMoreToIncomeList() {
    variableSubCatsList.clear();
    fixedSubCatsList.clear();
    filterIncomeSubCategoriesList();
    fixedSubCatsList.insert(fixedSubCatsList.length, appList.addMoreOption);
    variableSubCatsList.insert(
        variableSubCatsList.length, appList.addMoreOption);
    emit(ChoosedMainCategoryState());
  }

  addMoreToExpenseList() {
    personalSubCatsList.clear();
    homeSubCatsList.clear();
    businessSubCatsList.clear();
    filterExpenseSubCategoriesList();
    personalSubCatsList.insert(
        personalSubCatsList.length, appList.addMoreOption);
    homeSubCatsList.insert(homeSubCatsList.length, appList.addMoreOption);
    businessSubCatsList.insert(
        businessSubCatsList.length, appList.addMoreOption);
    // emit(ChoosedMainCategoryState());
  }

  List<MaterialColor> fitRandomColors(List<SubCategory> subcategoryList) {
    //TODO recode this method as there are 3 lists for expenses and 2 for income
    if (subcategoryList.length > appList.colorsList.length) {
      for (int i = appList.colorsList.length; i < subcategoryList.length; i++) {
        appList.colorsList.add(appList.colorsList[Random().nextInt(6)]);
      }
      lastColorList = appList.colorsList;
      return lastColorList;
    } else {
      lastColorList = appList.colorsList;
      return lastColorList;
    }
  }

  void chooseCategory(SubCategory currentSubcategory) {
    currentID = currentSubcategory.id;
    subCatName = currentSubcategory.subCategoryName;
    emit(ChoosedSubCategoryState());
  }

  void chooseIncomeCategory(SubCategory currentSubcategory) {
    currentID = currentSubcategory.id;
    subCatName = currentSubcategory.subCategoryName;
    emit(ChoosedSubCategoryState());
  }

  validateExpenseFields(
      BuildContext context, String amount, TransactionModel transactionModel) {
    if (amount.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Kindly put the amount ! ')));
    } else if (subCatName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Kindly choose a subCategory ')));
    } else {
      if (transactionModel.repeatType.contains('No Repeat')) {
        addExpense(repeat: 'No Repeat', expenseModel: transactionModel);
      } else {
        addExpense(repeat: choseRepeat, expenseModel: transactionModel);
      }
    }
  }

  validateIncomeFields(
      BuildContext context, String amount, TransactionModel transactionModel) {
    if (amount.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Kindly put the amount ! ')));
    } else if (subCatName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Kindly choose a subCategory ')));
    } else {
      addIncome(expenseModel: transactionModel);
    }
  }

  void addExpense(
      {required TransactionModel expenseModel, required String repeat}) {
    try {
      _expensesRepository.
      addTransactionToTransactionBox( transactionModel: expenseModel);
      emit(AddExpOrIncSuccess());
    } catch (error) {
      print('${error.toString()}');
      emit(AddExpOrIncError());
    }
  }

  void addIncome({required TransactionModel expenseModel}) {
    try {
      _incomeRepository.addTransactionToTransactionBox(
          transactionModel: expenseModel);
      emit(AddExpOrIncSuccess());
    } catch (error) {
      print('${error.toString()}');
      emit(AddExpOrIncError());
    }
  }

  Future<void> changeDate(BuildContext context) async {
    chosenDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    emit(ChoosedDateState());
  }
}
