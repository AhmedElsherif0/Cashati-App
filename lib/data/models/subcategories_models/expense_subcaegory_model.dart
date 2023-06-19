import 'package:hive/hive.dart';

part 'expense_subcaegory_model.g.dart';

@HiveType(typeId: 6)
class SubCategory {
  SubCategory();

  SubCategory.copyWith({
    required this.mainCategoryName,
    required this.id,
    required this.subCategoryName,
    required this.subCategoryIconName,

  });

  @HiveField(0)
  late String id;
  @HiveField(1)
  late String mainCategoryName;

  @HiveField(2)
  late String subCategoryName;

  @HiveField(3)
  late String subCategoryIconName;



}
