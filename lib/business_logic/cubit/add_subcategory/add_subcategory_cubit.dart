import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:temp/business_logic/repository/subcategories_repo/expense_subcategory_repo.dart';

import '../../../data/repository/subcategories_repo_impl/expense_subcategory_repo_impl.dart';
import '../../repository/subcategories_repo/expense_subcategory_repo.dart';

part 'add_subcategory_state.dart';

class AddSubcategoryCubit extends Cubit<AddSubcategoryState> {
  AddSubcategoryCubit() : super(AddSubcategoryInitial());
  final GlobalKey<FormState> formKey=GlobalKey<FormState>();

  late String currentMainCategory;
  late String transactionType;
  ExpenseSubCategoryRepo expenseSubCategoryRepo=ExpenseSubCategoryImpl();
   List<IconData> iconsList=[
    Icons.facebook,
    Icons.key,
    Icons.seven_k,
    Icons.title,
    Icons.build,
    Icons.vaccines_outlined,
    Icons.error,
    Icons.repeat,
    Icons.pause,
    Icons.dangerous,
  ];
    IconData currentIconData=Icons.add;

    chooseSubCategory(IconData iconData){
      currentIconData=iconData;
      emit(ChoseSubCategory());
    }
    addSubCategory(String subCategoryName)async{
      if(formKey.currentState!.validate()){
        print('validated');
        try{
        await  expenseSubCategoryRepo.addExpenseSubCat(
              mainCategoryExpenseName: currentMainCategory,
              subCategoryExpenseName: subCategoryName,
              subCategoryExpenseIconName: 'Expense',
              subCategoryExpenseColor: 'none',
              subCategoryExpenseIconCodePoint: currentIconData.codePoint);
        }catch(e){
          print('Error Adding subcat is $e');
        }
      }
    }
}
