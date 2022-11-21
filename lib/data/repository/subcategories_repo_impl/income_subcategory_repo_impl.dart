//  class IncomeSubcategoryRepoImpl implements  IncomeSubcategoryRepo {
//
//
// List<SubCategoryIncome> fetchAllIncomeSubCats(){
//   return subCatIncomeBox.values.toList().cast<SubCategoryIncome>();
// }
//
// Future <void> addIncomeSubCat({
//   required String mainCategoryIncomeName,
//   required String subCategoryIncomeColor,
//   required String subCategoryIncomeIconName,
//   required String subCategoryIncomeName,
//   required int subCategoryIncomeCodePoint,
// })async{
//   SubCategoryIncome subCategoryIncome=SubCategoryIncome.copyWith(
//     mainCategoryIncomeName: mainCategoryIncomeName,
//     subCategoryIncomeColor: subCategoryIncomeColor,
//     subCategoryIncomeIconName: subCategoryIncomeIconName,
//     subCategoryIncomeId: GUIDGen.generate(),
//     subCategoryIncomeName: subCategoryIncomeName,
//     subCategoryIncomeCodePoint: subCategoryIncomeCodePoint,
//
//   );
//   await subCatIncomeBox.add(subCategoryIncome);
// }
//
// Future <void> deleteIncomeSubCat(SubCategoryIncome subCategoryIncome)async{
//   await subCategoryIncome.delete();
// }
// }