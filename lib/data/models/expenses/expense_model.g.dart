// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpenseModelAdapter extends TypeAdapter<ExpenseModel> {
  @override
  final int typeId = 0;

  @override
  ExpenseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExpenseModel()
      ..id = fields[0] as String
      ..name = fields[1] as String
      ..amount = fields[2] as num
      ..mainCategory = fields[3] as String
      ..subCategory = fields[4] as String
      ..isPriority = fields[5] as bool
      ..repeatType = fields[6] as String
      ..comment = fields[7] as String
      ..isReceiveNotification = fields[8] as bool
      ..isAddAuto = fields[9] as bool
      ..isPaid = fields[10] as bool
      ..paymentDate = fields[11] as DateTime
      ..createdDate = fields[12] as DateTime;
  }

  @override
  void write(BinaryWriter writer, ExpenseModel obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.mainCategory)
      ..writeByte(4)
      ..write(obj.subCategory)
      ..writeByte(5)
      ..write(obj.isPriority)
      ..writeByte(6)
      ..write(obj.repeatType)
      ..writeByte(7)
      ..write(obj.comment)
      ..writeByte(8)
      ..write(obj.isReceiveNotification)
      ..writeByte(9)
      ..write(obj.isAddAuto)
      ..writeByte(10)
      ..write(obj.isPaid)
      ..writeByte(11)
      ..write(obj.paymentDate)
      ..writeByte(12)
      ..write(obj.createdDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
