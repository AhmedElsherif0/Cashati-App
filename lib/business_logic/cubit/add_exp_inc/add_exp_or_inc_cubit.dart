import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:temp/data/models/transactions/transaction_model.dart';
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
   String currentMainCat='';

  static const List<MaterialColor> colorsList=[
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.purple,
    Colors.indigo,
    Colors.pink,
    Colors.indigo,
    Colors.green,
    Colors.purple,
    Colors.blue,
    Colors.red,
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.purple,
    Colors.indigo,
    Colors.pink,
    Colors.indigo,
  ];
  List<SubCategoryExpense> dataList=[] ;
  String choseRepeat = 'Choose Repeat';
  bool isRepeat = false;

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
  addMoreToList(){
    List<SubCategoryExpense> list = [
      SubCategoryExpense.copyWith(
          id: 'ssfsf55',
          subCategoryExpenseName: 'Transportation',
          mainCategoryExpenseName: 'Home',
          subCategoryExpenseColor: 'red',
          subCategoryExpenseIconName: 'sss',
          subCategoryExpenseIconCodePoint: Icons.ten_k.codePoint),
      SubCategoryExpense.copyWith(
        id: 'odfiefi25',
        mainCategoryExpenseName: 'Home',
        subCategoryExpenseName: 'Food',
        subCategoryExpenseColor: 'red',
        subCategoryExpenseIconName: 'sss',
        subCategoryExpenseIconCodePoint: Icons.star.codePoint,
      ),
      SubCategoryExpense.copyWith(
          id: 'efefgg99',
          mainCategoryExpenseName: 'Home',
          subCategoryExpenseName: 'Random',
          subCategoryExpenseColor: 'red',
          subCategoryExpenseIconName: 'sss',
          subCategoryExpenseIconCodePoint: Icons.vaccines_outlined.codePoint),
      SubCategoryExpense.copyWith(
          id: 'efefggs99',
          mainCategoryExpenseName: 'Home',
          subCategoryExpenseName: 'Try1',
          subCategoryExpenseColor: 'red',
          subCategoryExpenseIconName: 'sss',
          subCategoryExpenseIconCodePoint: Icons.vaccines_outlined.codePoint),
      SubCategoryExpense.copyWith(
          id: 'efefefefggs99',
          mainCategoryExpenseName: 'Home',
          subCategoryExpenseName: 'Try2',
          subCategoryExpenseColor: 'red',
          subCategoryExpenseIconName: 'sss',
          subCategoryExpenseIconCodePoint: Icons.vaccines_outlined.codePoint),
      SubCategoryExpense.copyWith(
          id: 'efefef4rggs99',
          mainCategoryExpenseName: 'Home',
          subCategoryExpenseName: 'Try3',
          subCategoryExpenseColor: 'red',
          subCategoryExpenseIconName: 'sss',
          subCategoryExpenseIconCodePoint: Icons.vaccines_outlined.codePoint),
      SubCategoryExpense.copyWith(
          id: 'rf33f',
          mainCategoryExpenseName: 'Home',
          subCategoryExpenseName: 'Try4',
          subCategoryExpenseColor: 'red',
          subCategoryExpenseIconName: 'sss',
          subCategoryExpenseIconCodePoint: Icons.vaccines_outlined.codePoint),
      SubCategoryExpense.copyWith(
          id: 'rf33wwwwf',
          mainCategoryExpenseName: 'Home',
          subCategoryExpenseName: 'Try5',
          subCategoryExpenseColor: 'red',
          subCategoryExpenseIconName: 'sss',
          subCategoryExpenseIconCodePoint: Icons.vaccines_outlined.codePoint),
    ];
    list.insert(
      list.length,
      SubCategoryExpense.copyWith(
          id: 'feverrrr',
          mainCategoryExpenseName: 'Home',
          subCategoryExpenseName: 'Add More',
          subCategoryExpenseColor: 'red',
          subCategoryExpenseIconName: 'qdqdqd',
          subCategoryExpenseIconCodePoint: Icons.minimize.codePoint),
    );
    dataList=list;
  }

  List<MaterialColor> fitRandomColors(){
   if(dataList.length>colorsList.length){
     for(int i=colorsList.length; i<dataList.length; i++ ){
       colorsList.add(colorsList[Random().nextInt(6)]);
     }
     lastColorList=colorsList;
     return lastColorList;
   }else{
     lastColorList=colorsList;
     return lastColorList;
   }
  }

  void chooseCategory(int index){
    currentID = dataList[index].id;
   subCatName = dataList[index].subCategoryExpenseName;
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
