import 'package:hive/hive.dart';

import '../../../business_logic/repository/subcategories_repo/income_subcategory_repo.dart';
import '../../local/hive/app_boxes.dart';
import '../../local/hive/hive_database.dart';
import '../../local/hive/id_generator.dart';
import '../../models/subcategories_models/income_subcaegory_model.dart';

class IncomeSubcategoryImpl implements IncomeSubcategoryRepo {
  final HiveHelper _hiveHelper = HiveHelper();

  @override
  List<SubCategoryIncome> fetchAllIncomeSubCats() {
    return _getSubCategoryBox().values.toList().cast<SubCategoryIncome>();
  }

  @override
  Future<void> addIncomeSubCat({
    required String mainCategoryIncomeName,
    required String subCategoryIncomeColor,
    required String subCategoryIncomeIconName,
    required String subCategoryIncomeName,
    required int subCategoryIncomeCodePoint,
  }) async {
    SubCategoryIncome subCategoryIncome = SubCategoryIncome.copyWith(
      id: GUIDGen.generate(),
      mainCategoryIncomeName: mainCategoryIncomeName,
      subCategoryIncomeColor: subCategoryIncomeColor,
      subCategoryIncomeIconName: subCategoryIncomeIconName,
      subCategoryIncomeName: subCategoryIncomeName,
      subCategoryIncomeCodePoint: subCategoryIncomeCodePoint,
    );
    await _hiveHelper.addToBox(
        dataModel: subCategoryIncome, boxName: _getSubCategoryBox());
  }

  @override
  Future<void> deleteIncomeSubCat(SubCategoryIncome subCategoryIncome) async {
    await _hiveHelper.deleteBox(
        boxName: _getSubCategoryBox(), dataModel: subCategoryIncome);
  }

  Box<SubCategoryIncome> _getSubCategoryBox() =>
      _hiveHelper.getBoxName(boxName: AppBoxes.subCategoryIncome);
}
