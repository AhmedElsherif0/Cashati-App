import 'package:hive/hive.dart';
import 'package:temp/data/local/hive/app_boxes.dart';
import 'package:temp/data/local/hive/hive_database.dart';

import '../../../business_logic/repository/subcategories_repo/expense_subcategory_repo.dart';
import '../../local/hive/id_generator.dart';
import '../../models/subcategories_models/expense_subcaegory_model.dart';

class ExpenseSubCategoryImpl implements ExpenseSubCategoryRepo {
  final HiveHelper _hiveHelper = HiveHelper();

  @override
  List<SubCategoryExpense> fetchAllExpenseSubCats() {
    return _getSubCatExpenseBox().values.toList().cast<SubCategoryExpense>();
  }

  @override
  Future<void> addExpenseSubCat({
    required String mainCategoryExpenseName,
    required String subCategoryExpenseName,
    required String subCategoryExpenseIconName,
    required String subCategoryExpenseColor,
    required int subCategoryExpenseIconCodePoint,
  }) async {
    final SubCategoryExpense subCategoryExpense = SubCategoryExpense.copyWith(
        mainCategoryExpenseName: mainCategoryExpenseName,
        id: GUIDGen.generate(),
        subCategoryExpenseName: subCategoryExpenseName,
        subCategoryExpenseIconName: subCategoryExpenseIconName,
        subCategoryExpenseIconCodePoint: subCategoryExpenseIconCodePoint,
        subCategoryExpenseColor: subCategoryExpenseColor);
    await _hiveHelper.addToBox(
        dataModel: subCategoryExpense, boxName: _getSubCatExpenseBox());
  }

  @override
  Future<void> deleteExpenseSubCat(
      SubCategoryExpense subCategoryExpense) async {
    await _hiveHelper.deleteBox(
        boxName: _getSubCatExpenseBox(), dataModel: subCategoryExpense);
  }

  Box<SubCategoryExpense> _getSubCatExpenseBox()=>
  _hiveHelper.getBoxName(boxName: AppBoxes.subCategoryExpense);
}
