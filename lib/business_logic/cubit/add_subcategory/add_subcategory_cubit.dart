import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:temp/business_logic/repository/subcategories_repo/expense_subcategory_repo.dart';
import 'package:temp/business_logic/repository/subcategories_repo/income_subcategory_repo.dart';
import 'package:temp/data/repository/subcategories_repo_impl/income_subcategory_repo_impl.dart';
import 'package:temp/presentation/router/app_router_names.dart';

import '../../../data/repository/subcategories_repo_impl/expense_subcategory_repo_impl.dart';
import '../../repository/subcategories_repo/expense_subcategory_repo.dart';
import '../add_exp_inc/add_exp_or_inc_cubit.dart';

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
  goBackWithNewData(BuildContext context,{required bool isExpSub}){
    if(isExpSub){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Added Successfully')));
      BlocProvider.of<AddExpOrIncCubit>(context).addMoreToExpenseList();
      Navigator.pop(context);
      Navigator.pushReplacementNamed(context,AppRouterNames.rAddExpenseOrIncomeScreen);
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Added Successfully')));
      BlocProvider.of<AddExpOrIncCubit>(context).addMoreToIncomeList();
      Navigator.pop(context);
      Navigator.pushReplacementNamed(context,AppRouterNames.rAddExpenseOrIncomeScreen);
    }

  }

  addSubCategory(String subCategoryName,BuildContext context) async {
    if (formKey.currentState!.validate()) {
      print('validated');
     await filterSubCategory(subCategoryName).then((value)  {
       // if(state==AddedSubcategorySuccessfully()){
       //   print('state is $state');
       //
       //   Navigator.pushNamedAndRemoveUntil(context, AppRouterNames.rAddExpenseOrIncomeScreen, (route) => false);
       // }else{
       //   print('state is $state');
       // }
     });
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
    emit(AddSubCategoryLoading());

    try {
      await expenseSubCategoryRepo.addExpenseSubCat(
          mainCategoryExpenseName: currentMainCategory,
          subCategoryExpenseName: subCategoryName,
          subCategoryExpenseIconName: 'Expense',
          subCategoryExpenseColor: 'none',
          subCategoryExpenseIconCodePoint: currentIconData.codePoint);
      emit(AddedExpSubcategorySuccessfully());

    } catch (e) {
      print('Error Adding Expense subcat is $e');
      emit(AddSubCategoryError(e.toString()));
    }
  }

  Future addIncomeSubCategory(String subCategoryName) async {
    emit(AddSubCategoryLoading());

    try {
      await incomeSubcategoryRepo.addIncomeSubCat(
          mainCategoryIncomeName: currentMainCategory,
          subCategoryIncomeName: subCategoryName,
          subCategoryIncomeIconName: 'Income',
          subCategoryIncomeColor: 'none',
          subCategoryIncomeCodePoint: currentIconData.codePoint);
      emit(AddedIncSubcategorySuccessfully());

    } catch (e) {
      print('Error Adding subcat is $e');
      emit(AddSubCategoryError(e.toString()));

    }
  }
}
