import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:temp/business_logic/repository/subcategories_repo/expense_subcategory_repo.dart';
import 'package:temp/constants/app_lists.dart';
import 'package:temp/data/local/hive/id_generator.dart';
import 'package:temp/data/models/subcategories_models/expense_subcaegory_model.dart';
import 'package:temp/data/repository/subcategories_repo_impl/income_subcategory_repo_impl.dart';
import '../../../data/repository/subcategories_repo_impl/expense_subcategory_repo_impl.dart';
import '../add_exp_inc/add_exp_or_inc_cubit.dart';

part 'add_subcategory_state.dart';

class AddSubcategoryCubit extends Cubit<AddSubcategoryState> {
  AddSubcategoryCubit() : super(AddSubcategoryInitial());

  late String currentMainCategory;
  late String transactionType;
  CategoryTransactionRepo expenseSubCategoryRepo = ExpenseSubCategoryImpl();
  CategoryTransactionRepo incomeSubcategoryRepo = IncomeSubcategoryImpl();
  final AppConstantList appList = AppConstantList();

  IconData currentIconData = Icons.add;

  chooseSubCategory(IconData iconData) {
    currentIconData = iconData;
    emit(ChoseSubCategory());
  }

  goBackWithNewData(BuildContext context, {required bool isExpSub}) =>
    isExpSub
        ? BlocProvider.of<AddExpOrIncCubit>(context).addMoreToExpenseList()
        : BlocProvider.of<AddExpOrIncCubit>(context).addMoreToIncomeList();

  Future filterSubCategory(String subCategoryName) async {
    switch (currentMainCategory) {
      case "Fixed":
        await addSubCategories(subCategoryName, 'Income');
        return;
      case "Variable":
        await addSubCategories(subCategoryName, 'Income');
        return;
      default:
        await addSubCategories(subCategoryName, 'Expense');
        return;
    }
  }

  Future addSubCategories(String subCategoryName, String iconName) async {
    try {
      await expenseSubCategoryRepo.addSubCategories(
          subCategory: SubCategory.copyWith(
              mainCategoryName: currentMainCategory,
              id: GUIDGen.generate(),
              subCategoryName: subCategoryName,
              subCategoryIconName: iconName,
              subCategoryColor: 'none',
              subCategoryIconCodePoint: currentIconData.codePoint));
    } catch (e) {
      print('Error Adding Expense subcat is $e');
    }
  }
}
