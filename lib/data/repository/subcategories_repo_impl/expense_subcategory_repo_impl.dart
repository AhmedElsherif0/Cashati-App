import 'package:hive/hive.dart';
import 'package:temp/data/local/hive/app_boxes.dart';
import 'package:temp/data/local/hive/hive_database.dart';
import '../../../business_logic/repository/subcategories_repo/expense_subcategory_repo.dart';
import '../../local/hive/id_generator.dart';
import '../../models/subcategories_models/expense_subcaegory_model.dart';

class ExpenseSubCategoryImpl implements CategoryTransactionRepo {
  final HiveHelper _hiveHelper = HiveHelper();

  @override
  List<SubCategory> fetchSubCategories() {
    return _getSubCatExpenseBox().values.toList().cast<SubCategory>();
  }

  @override
  Future<void> addSubCategories({required SubCategory subCategory}) async {
    final SubCategory subCategoryExpense = SubCategory.copyWith(
        mainCategoryName: subCategory.mainCategoryName,
        id: GUIDGen.generate(),
        subCategoryName: subCategory.subCategoryName,
        subCategoryIconName: subCategory.subCategoryIconName,
        );
    await _hiveHelper.addToBox2(
        dataModel: subCategoryExpense, boxName: _getSubCatExpenseBox());
  }

  @override
  Future<void> deleteSubCategories({ required SubCategory subCategory}) async {
    await _hiveHelper.deleteBox(
        boxName: _getSubCatExpenseBox(), dataModel: subCategory);
  }

  Box<SubCategory> _getSubCatExpenseBox() =>
      _hiveHelper.getBoxName(boxName: AppBoxes.subCategoryExpense);
}
