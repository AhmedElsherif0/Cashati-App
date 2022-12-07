import 'package:hive/hive.dart';
import 'transaction_model.dart';

part 'transaction_details_model.g.dart';

@HiveType(typeId: 1)
class TransactionRepeatDetailsModel extends HiveObject{
  TransactionRepeatDetailsModel();
  TransactionRepeatDetailsModel.copyWith({
    required this.lastConfirmationDate,
    required this.isLastConfirmed,
    required this.creationDate,
    required this.transactionModel,
    required this.lastShownDate,
    required this.nextShownDate,
});
  @HiveField(0)
  late TransactionModel transactionModel;
  @HiveField(1)
  late bool isLastConfirmed;
  @HiveField(2)
  late DateTime lastShownDate;
  @HiveField(3)
  late DateTime nextShownDate;
  @HiveField(4)
  late DateTime lastConfirmationDate;
  @HiveField(5)
  late DateTime creationDate;
}
