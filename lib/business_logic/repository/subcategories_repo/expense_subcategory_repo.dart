import '../../../data/models/subcategories_models/expense_subcaegory_model.dart';

abstract class ExpenseSubCategoryRepo {
  List<SubCategoryExpense> fetchAllExpenseSubCats();

  Future<void> addExpenseSubCat({
    required String mainCategoryExpenseName,
    required String subCategoryExpenseName,
    required String subCategoryExpenseIconName,
    required String subCategoryExpenseColor,
    required int subCategoryExpenseIconCodePoint,
  });

  Future<void> deleteExpenseSubCat(SubCategoryExpense subCategoryExpense);
}
