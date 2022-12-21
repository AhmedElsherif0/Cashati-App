import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:temp/business_logic/repository/subcategories_repo/expense_subcategory_repo.dart';
import 'package:temp/constants/app_lists.dart';
import 'package:temp/data/models/transactions/transaction_model.dart';
import 'package:temp/data/repository/subcategories_repo_impl/expense_subcategory_repo_impl.dart';
import '../../../data/models/subcategories_models/expense_subcaegory_model.dart';
import '../../repository/expenses_repo/expenses_repo.dart';

part 'add_exp_or_inc_state.dart';

class AddExpOrIncCubit extends Cubit<AddExpOrIncState> {
  AddExpOrIncCubit(this._expensesRepository) : super(AddExpOrIncInitial());
  String currentID = '';
  String? subCatName;
  bool isSubChoosed = false;

  List<MaterialColor>lastColorList=[];
  bool isExpense=true;
  List<String> expMainCats=['Personal','Home','Business'];
  List<SubCategoryExpense> personalSubCatsList=[];
  List<SubCategoryExpense> homeSubCatsList=[];
  List<SubCategoryExpense> businessSubCatsList=[];
   String currentMainCat='';


//  List<SubCategoryExpense> dataList=[] ;
  String choseRepeat = 'Choose Repeat';
  bool isRepeat = false;
  ExpenseSubCategoryRepo expenseSubCategoryRepo=ExpenseSubCategoryImpl();

  List<DropdownMenuItem<String>> dropDownChannelItems = [
    DropdownMenuItem(child: Text('Daily'), value: 'Daily'),
    DropdownMenuItem(child: Text('Weekly'), value: 'Weekly'),
    DropdownMenuItem(child: Text('Monthly'), value: 'Monthly',),
    DropdownMenuItem(child: Text('No Repeat'), value: 'No Repeat'),
  ];

  // List<SubCategoryExpense> list = [
  //   SubCategoryExpense.copyWith(
  //       id: 'ssfsf55',
  //       subCategoryExpenseName: 'Transportation',
  //       mainCategoryExpenseName: 'Home',
  //       subCategoryExpenseColor: 'red',
  //       subCategoryExpenseIconName: 'sss',
  //       subCategoryExpenseIconCodePoint: Icons.ten_k.codePoint),
  //   SubCategoryExpense.copyWith(
  //     id: 'odfiefi25',
  //     mainCategoryExpenseName: 'Home',
  //     subCategoryExpenseName: 'Food',
  //     subCategoryExpenseColor: 'red',
  //     subCategoryExpenseIconName: 'sss',
  //     subCategoryExpenseIconCodePoint: Icons.star.codePoint,
  //   ),
  //   SubCategoryExpense.copyWith(
  //       id: 'efefgg99',
  //       mainCategoryExpenseName: 'Home',
  //       subCategoryExpenseName: 'Random',
  //       subCategoryExpenseColor: 'red',
  //       subCategoryExpenseIconName: 'sss',
  //       subCategoryExpenseIconCodePoint: Icons.vaccines_outlined.codePoint),
  //   SubCategoryExpense.copyWith(
  //       id: 'efefggs99',
  //       mainCategoryExpenseName: 'Home',
  //       subCategoryExpenseName: 'Try1',
  //       subCategoryExpenseColor: 'red',
  //       subCategoryExpenseIconName: 'sss',
  //       subCategoryExpenseIconCodePoint: Icons.vaccines_outlined.codePoint),
  //   SubCategoryExpense.copyWith(
  //       id: 'efefefefggs99',
  //       mainCategoryExpenseName: 'Home',
  //       subCategoryExpenseName: 'Try2',
  //       subCategoryExpenseColor: 'red',
  //       subCategoryExpenseIconName: 'sss',
  //       subCategoryExpenseIconCodePoint: Icons.vaccines_outlined.codePoint),
  //   SubCategoryExpense.copyWith(
  //       id: 'efefef4rggs99',
  //       mainCategoryExpenseName: 'Home',
  //       subCategoryExpenseName: 'Try3',
  //       subCategoryExpenseColor: 'red',
  //       subCategoryExpenseIconName: 'sss',
  //       subCategoryExpenseIconCodePoint: Icons.vaccines_outlined.codePoint),
  //   SubCategoryExpense.copyWith(
  //       id: 'rf33f',
  //       mainCategoryExpenseName: 'Home',
  //       subCategoryExpenseName: 'Try4',
  //       subCategoryExpenseColor: 'red',
  //       subCategoryExpenseIconName: 'sss',
  //       subCategoryExpenseIconCodePoint: Icons.vaccines_outlined.codePoint),
  //   SubCategoryExpense.copyWith(
  //       id: 'rf33wwwwf',
  //       mainCategoryExpenseName: 'Home',
  //       subCategoryExpenseName: 'Try5',
  //       subCategoryExpenseColor: 'red',
  //       subCategoryExpenseIconName: 'sss',
  //       subCategoryExpenseIconCodePoint: Icons.vaccines_outlined.codePoint),
  // ];
  final TransactionsRepository _expensesRepository;

  chooseMainCategory(String mainCategory){
    currentMainCat=mainCategory;
    print('current main cat is ${currentMainCat}');
    resetSubCategory();
    emit(ChoosedMainCategoryState());
  }
  resetSubCategory(){
    currentID='';
  }
  chooseRepeat(String value){
    choseRepeat = value;
    emit(ChoosedRepeatState());
  }
  void isRepeatOrNo(bool? value){
    isRepeat = value??false;
    emit(ChoosedRepeatState());
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
  List<SubCategoryExpense> distributeSubcategories(String mainCategoryName){

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

  filterSubCategoriesList(){
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
  addMoreToList(){
   // dataList.clear();
    filterSubCategoriesList();
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

  void addExpense({
    required TransactionModel expenseModel,
    required String choseRepeat,
  }) {
    try {
      _expensesRepository.addTransactions(
          expenseModel: expenseModel, choseRepeat: choseRepeat);
      emit(AddExpOrIncSuccess());
    } catch (error) {
      print('${error.toString()}');
      emit(AddExpOrIncError());
    }
  }
}
