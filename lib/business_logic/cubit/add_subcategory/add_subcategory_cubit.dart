import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:temp/business_logic/repository/subcategories_repo/expense_subcategory_repo.dart';
import 'package:temp/business_logic/repository/subcategories_repo/income_subcategory_repo.dart';
import 'package:temp/data/repository/subcategories_repo_impl/income_subcategory_repo_impl.dart';
import 'package:temp/presentation/router/app_router_names.dart';

import '../../../data/repository/subcategories_repo_impl/expense_subcategory_repo_impl.dart';
import '../../repository/subcategories_repo/expense_subcategory_repo.dart';

part 'add_subcategory_state.dart';

class AddSubcategoryCubit extends Cubit<AddSubcategoryState> {
  AddSubcategoryCubit() : super(AddSubcategoryInitial());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late String currentMainCategory;
  late String transactionType;
  ExpenseSubCategoryRepo expenseSubCategoryRepo = ExpenseSubCategoryImpl();
  IncomeSubcategoryRepo incomeSubcategoryRepo = IncomeSubcategoryImpl();
  List<IconData> iconsList = [
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
  IconData currentIconData = Icons.add;

  chooseSubCategory(IconData iconData) {
    currentIconData = iconData;
    emit(ChoseSubCategory());
  }

  addSubCategory(String subCategoryName) async {
    if (formKey.currentState!.validate()) {
      print('validated');
      filterSubCategory(subCategoryName);
    }
  }

  Future filterSubCategory(String subCategoryName)async {
    switch (currentMainCategory) {
      case "Fixed":
        await addIncomeSubCategory(subCategoryName);
       // print('Add with mainCat ${}')
        return;
      case "Variable":
        await addIncomeSubCategory(subCategoryName);
        return;
      case "Personal":
        await addExpenseSubCategory(subCategoryName);
        return;
      case "Home":
        await  addExpenseSubCategory(subCategoryName);
        return;
      case "Business":
        await addExpenseSubCategory(subCategoryName);
        return;

    }
  }

  Future addExpenseSubCategory(String subCategoryName) async {
    try {
      await expenseSubCategoryRepo.addExpenseSubCat(
          mainCategoryExpenseName: currentMainCategory,
          subCategoryExpenseName: subCategoryName,
          subCategoryExpenseIconName: 'Expense',
          subCategoryExpenseColor: 'none',
          subCategoryExpenseIconCodePoint: currentIconData.codePoint);
    } catch (e) {
      print('Error Adding Expense subcat is $e');
    }
  }

  Future addIncomeSubCategory(String subCategoryName) async {
    try {
      await incomeSubcategoryRepo.addIncomeSubCat(
          mainCategoryIncomeName: currentMainCategory,
          subCategoryIncomeName: subCategoryName,
          subCategoryIncomeIconName: 'Income',
          subCategoryIncomeColor: 'none',
          subCategoryIncomeCodePoint: currentIconData.codePoint);
    } catch (e) {
      print('Error Adding subcat is $e');
    }
  }
}
