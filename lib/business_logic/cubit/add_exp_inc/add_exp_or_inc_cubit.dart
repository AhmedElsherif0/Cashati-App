import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:temp/business_logic/repository/income_repo/income_repo.dart';
import 'package:temp/business_logic/repository/subcategories_repo/expense_subcategory_repo.dart';
import 'package:temp/business_logic/repository/subcategories_repo/income_subcategory_repo.dart';
import 'package:temp/constants/app_lists.dart';
import 'package:temp/data/models/subcategories_models/income_subcaegory_model.dart';
import 'package:temp/data/models/transactions/transaction_model.dart';
import 'package:temp/data/repository/subcategories_repo_impl/expense_subcategory_repo_impl.dart';
import 'package:temp/data/repository/subcategories_repo_impl/income_subcategory_repo_impl.dart';
import '../../../data/models/subcategories_models/expense_subcaegory_model.dart';
import '../../repository/expenses_repo/expenses_repo.dart';

part 'add_exp_or_inc_state.dart';

class AddExpOrIncCubit extends Cubit<AddExpOrIncState> {
  AddExpOrIncCubit(this._expensesRepository,this._incomeRepository) : super(AddExpOrIncInitial());
  String currentID = '';
  String subCatName='';
  bool isSubChoosed = false;
  DateTime? chosenDate;
  List<MaterialColor>lastColorList=[];
  bool isExpense=true;
  List<String> expMainCats=['Personal','Home','Business'];
  List<String> incomeMainCats=['Fixed','Variable'];
  List<SubCategoryExpense> personalSubCatsList=[];
  List<SubCategoryExpense> homeSubCatsList=[];
  List<SubCategoryExpense> businessSubCatsList=[];
  List<SubCategoryIncome> fixedSubCatsList=[];
  List<SubCategoryIncome> variableSubCatsList=[];
   String currentMainCat='';


//  List<SubCategoryExpense> dataList=[] ;
  String choseRepeat = 'Choose Repeat';
  bool isRepeat = false;
  bool isImportant = false;
  ExpenseSubCategoryRepo expenseSubCategoryRepo=ExpenseSubCategoryImpl();
  IncomeSubcategoryRepo incomeSubCategoryRepo=IncomeSubcategoryImpl();

  List<DropdownMenuItem<String>> dropDownChannelItems = [
    DropdownMenuItem(child: Text('Daily'), value: 'Daily'),
    DropdownMenuItem(child: Text('Weekly'), value: 'Weekly'),
    DropdownMenuItem(child: Text('Monthly'), value: 'Monthly',),
    DropdownMenuItem(child: Text('No Repeat'), value: 'No Repeat'),
  ];

  final TransactionsRepository _expensesRepository;
  final IncomeRepository _incomeRepository;

  chooseMainCategory(String mainCategory){
    currentMainCat=mainCategory;
    print('current main cat is ${currentMainCat}');
    resetSubCategory();
    emit(ChoosedMainCategoryState());
  }
  resetSubCategory(){
    currentID='';
    emit(ChoosedSubCategoryState());
  }
  chooseRepeat(String value){
    choseRepeat = value;
    emit(ChoosedRepeatState());
  }
  void isRepeatOrNo(bool? value){
    isRepeat = value??false;
    emit(ChoosedRepeatState());
  }
  void isImportantOrNo(bool? value){
    isImportant = value??false;
    if(isImportant)    emit(ChoosedPriorityYesState());
    if(!isImportant)    emit(ChoosedPriorityNoState());

  }
  List<SubCategoryExpense>fetchExpensesSubCategories(){
    List<SubCategoryExpense> fetchedList=[];
    try{
      fetchedList= expenseSubCategoryRepo.fetchAllExpenseSubCats();
    }catch(e){
      print('error is $e');
    }
    print('Fetched list is ${fetchedList}');
    return fetchedList;
  }
  List<SubCategoryIncome>fetchIncomeSubCategories(){
    List<SubCategoryIncome> fetchedList=[];
    try{
      fetchedList= incomeSubCategoryRepo.fetchAllIncomeSubCats();
    }catch(e){
      print('error is $e');
    }
    print('Fetched list is ${fetchedList}');
    return fetchedList;
  }

  List<SubCategoryExpense> distributeExpenseSubcategories(String mainCategoryName){

    switch(mainCategoryName){
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
  List<SubCategoryIncome> distributeIncomeSubcategories(String mainCategoryName){

    switch(mainCategoryName){
      case 'Fixed':
        return fixedSubCatsList;
      case 'Variable':
        return variableSubCatsList;

      default:
        return fixedSubCatsList;
    }
  }


  filterExpenseSubCategoriesList(){
    List<SubCategoryExpense>list=fetchExpensesSubCategories();
    personalSubCatsList.addAll(expensePersonalFixedList);
    homeSubCatsList.addAll(expenseHomeFixedList);
    businessSubCatsList.addAll(expenseBusinessFixedList);
    if(list.isNotEmpty){
      for(var item in list){
        if(item.mainCategoryExpenseName=='Personal'){
          personalSubCatsList.add(item);
        }else if(item.mainCategoryExpenseName=='Home'){
          homeSubCatsList.add(item);
        }else if(item.mainCategoryExpenseName=='Business'){
          businessSubCatsList.add(item);
        }else{

        }
      }
    }
  }
  filterIncomeSubCategoriesList(){
    List<SubCategoryIncome>list=fetchIncomeSubCategories();
    fixedSubCatsList.addAll(incomeFixedSubFixedList);
    variableSubCatsList.addAll(incomeVariableSubFixedList);
    if(list.isNotEmpty){
      for(var item in list){
        if(item.mainCategoryIncomeName=='Fixed'){
          fixedSubCatsList.add(item);
        }else if(item.mainCategoryIncomeName=='Variable'){
          variableSubCatsList.add(item);
        }else{

        }
      }
    }
  }
  addMoreToIncomeList(){
   variableSubCatsList.clear();
   fixedSubCatsList.clear();
    filterIncomeSubCategoriesList();
    fixedSubCatsList.insert(fixedSubCatsList.length, addMoreOptionIncome);
    variableSubCatsList.insert(variableSubCatsList.length, addMoreOptionIncome);


   // emit(ChoosedMainCategoryState());
  }
  addMoreToExpenseList(){
   // dataList.clear();
    personalSubCatsList.clear();
    homeSubCatsList.clear();
    businessSubCatsList.clear();
    filterExpenseSubCategoriesList();
    personalSubCatsList.insert(personalSubCatsList.length, addMoreOption);
    homeSubCatsList.insert(homeSubCatsList.length, addMoreOption);
    businessSubCatsList.insert(businessSubCatsList.length, addMoreOption);


   // emit(ChoosedMainCategoryState());
  }

  List<MaterialColor> fitRandomColors(){
    //TODO recode this method as there are 3 lists for expenses and 2 for income
   if(homeSubCatsList.length>colorsList.length){
     for(int i=colorsList.length; i<homeSubCatsList.length; i++ ){
       colorsList.add(colorsList[Random().nextInt(6)]);
     }
     lastColorList=colorsList;
     return lastColorList;
   }else{
     lastColorList=colorsList;
     return lastColorList;
   }
  }

  void chooseCategory(SubCategoryExpense currentSubcategory){
    currentID = currentSubcategory.id;
   subCatName = currentSubcategory.subCategoryExpenseName;
   emit(ChoosedSubCategoryState());
  }
  void chooseIncomeCategory(SubCategoryIncome currentSubcategory){
    currentID = currentSubcategory.id;
    subCatName = currentSubcategory.subCategoryIncomeName;
    emit(ChoosedSubCategoryState());
  }

  validateExpenseFields(BuildContext context,String amount, TransactionModel transactionModel){

    if(amount.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text( 'Kindly put the amount ! ')));

    }else if(subCatName.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text( 'Kindly choose a subCategory ')));


    }else{
      addExpense(repeat: choseRepeat,expenseModel: transactionModel);
    }
  }
  validateIncomeFields(BuildContext context,String amount, TransactionModel transactionModel){

    if(amount.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text( 'Kindly put the amount ! ')));

    }else if(subCatName.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text( 'Kindly choose a subCategory ')));


    }else{
      addIncome(expenseModel: transactionModel);
    }
  }
  void addExpense({
    required TransactionModel expenseModel,
    required String repeat,
  }) {
    try {
      _expensesRepository.addExpenseToTransactionBox(
         transactionModel:expenseModel );
      emit(AddExpOrIncSuccess());
    } catch (error) {
      print('${error.toString()}');
      emit(AddExpOrIncError());
    }
  }

  void addIncome({
    required TransactionModel expenseModel,

  }) {
    try {
      _incomeRepository.addIncomeToTransactionBox(
          transactionModel:expenseModel );
      emit(AddExpOrIncSuccess());
    } catch (error) {
      print('${error.toString()}');
      emit(AddExpOrIncError());
    }
  }

  Future<void> changeDate(BuildContext context)async{

    chosenDate=await showDatePicker(context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    emit(ChoosedDateState());
  }

}
