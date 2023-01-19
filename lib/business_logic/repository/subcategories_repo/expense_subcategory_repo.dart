import '../../../data/models/subcategories_models/expense_subcaegory_model.dart';

abstract class CategoryTransactionRepo {

  List<SubCategory> fetchSubCategories();

  Future<void> addSubCategories({required SubCategory subCategory});

  Future<void> deleteSubCategories({required SubCategory subCategory});
}
