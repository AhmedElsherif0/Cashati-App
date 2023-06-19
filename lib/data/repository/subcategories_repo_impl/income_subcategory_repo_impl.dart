import 'package:hive/hive.dart';
import 'package:temp/business_logic/repository/subcategories_repo/expense_subcategory_repo.dart';
import 'package:temp/data/models/subcategories_models/expense_subcaegory_model.dart';
import '../../local/hive/app_boxes.dart';
import '../../local/hive/hive_database.dart';
import '../../local/hive/id_generator.dart';

class IncomeSubcategoryImpl implements CategoryTransactionRepo {
  final HiveHelper _hiveHelper = HiveHelper();

  @override
  List<SubCategory> fetchSubCategories() {
    return _getSubCategoryBox().values.toList().cast<SubCategory>();
  }

  @override
  Future<void> addSubCategories({required SubCategory subCategory}) async {
    SubCategory subCategories = SubCategory.copyWith(
      id: GUIDGen.generate(),
      mainCategoryName: subCategory.mainCategoryName,
      subCategoryIconName: subCategory.subCategoryIconName,
      subCategoryName: subCategory.subCategoryName,
    );
    await _hiveHelper.addToBox2(
        dataModel: subCategories, boxName: _getSubCategoryBox());
  }

  @override
  Future<void> deleteSubCategories({required SubCategory subCategory}) async {
    await _hiveHelper.deleteBox(
        boxName: _getSubCategoryBox(), dataModel: subCategory);
  }

  Box<SubCategory> _getSubCategoryBox() =>
      _hiveHelper.getBoxName(boxName: AppBoxes.subCategoryExpense);
}
