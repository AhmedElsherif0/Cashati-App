import 'package:hive/hive.dart';
part 'income_subcaegory_model.g.dart';


@HiveType(typeId: 7)
class SubCategoryIncome{
  SubCategoryIncome();

  SubCategoryIncome.copyWith({
    required this.mainCategoryIncomeName,
    required this.subCategoryIncomeColor,
    required this.subCategoryIncomeIconName,
    required this.id,
    required this.subCategoryIncomeName,
    required this.subCategoryIncomeCodePoint,
  });
  @HiveField(0)
  late String id;
  @HiveField(1)
  late String mainCategoryIncomeName ;
  @HiveField(2)
  late String subCategoryIncomeName ;
  @HiveField(3)
  late String subCategoryIncomeIconName;
  @HiveField(4)
  late String subCategoryIncomeColor;
  @HiveField(5)
  late int subCategoryIncomeCodePoint;
}