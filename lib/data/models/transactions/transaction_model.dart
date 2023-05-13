import 'package:hive/hive.dart';

part 'transaction_model.g.dart';

@HiveType(typeId: 0)
class TransactionModel extends HiveObject{
  TransactionModel();

  TransactionModel.expense({
    required this.id,
    required this.name,
    required this.amount,
    required this.comment,
    required this.repeatType,
    required this.mainCategory,
    required this.isAddAuto,
    required this.isPriority,
    required this.subCategory,
    required this.isExpense,
    required this.isProcessing,
    required this.createdDate,
    required this.paymentDate,
  });

  TransactionModel.income({
    required this.id,
    required this.name,
    required this.amount,
    required this.comment,
    required this.repeatType,
    required this.mainCategory,
    required this.isAddAuto,
    required this.subCategory,
    required this.isExpense,
    required this.isProcessing,
    required this.createdDate,
    required this.paymentDate,
  });

  @HiveField(0)
  late String id;
  @HiveField(1)
  String name ='daily';
  @HiveField(2)
  num amount = 0.0;
  @HiveField(3)
  late String mainCategory;
  @HiveField(4)
  late String subCategory;
  @HiveField(5)
  bool isPriority = false;
  @HiveField(6)
  String repeatType = 'day';
  @HiveField(7)
  String? comment;
  @HiveField(8)
   bool isExpense=false;
  @HiveField(9)
   bool isAddAuto = false;
  @HiveField(10)
  bool? isProcessing;
  @HiveField(11)
  DateTime paymentDate =DateTime.now();
  @HiveField(12)
  DateTime createdDate = DateTime.now();
}
