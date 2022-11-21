//  class ExpenseSubCategoryRepo implements  ExpenseSubCategoryRepo {
// Box<SubCategoryExpense> subCatExpenseBox=Boxes.getSubcategoryExpensesBox();
// List<SubCategoryExpense> fetchAllExpenseSubCats(){
//   return subCatExpenseBox.values.toList().cast<SubCategoryExpense>();
// }
//
// Future <void> addExpenseSubCat({
//
//   required String mainCategoryExpenseName,
//   required String subCategoryExpenseName,
//   required String subCategoryExpenseIconName,
//   required String subCategoryExpenseColor,
//   required int subCategoryExpenseIconCodePoint,
// })async{
//   final SubCategoryExpense subCategoryExpense=SubCategoryExpense.copyWith(
//       mainCategoryExpenseName: mainCategoryExpenseName,
//       subCategoryExpenseId: GUIDGen.generate(),
//       subCategoryExpenseName: subCategoryExpenseName,
//       subCategoryExpenseIconName: subCategoryExpenseIconName,
//       subCategoryExpenseIconCodePoint: subCategoryExpenseIconCodePoint,
//       subCategoryExpenseColor: subCategoryExpenseColor);
//   await subCatExpenseBox.add(subCategoryExpense);
// }
//
// Future <void> deleteExpenseSubCat(SubCategoryExpense subCategoryExpense)async{
//   await subCategoryExpense.delete();
// }
//}