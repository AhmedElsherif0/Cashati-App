// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'income_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IncomeModelAdapter extends TypeAdapter<IncomeModel> {
  @override
  final int typeId = 3;

  @override
  IncomeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IncomeModel()
      ..id = fields[0] as String
      ..name = fields[1] as String
      ..amount = fields[2] as num
      ..mainCategory = fields[3] as String
      ..subCategory = fields[4] as String
      ..repeat = fields[5] as String
      ..comment = fields[6] as String
      ..isReceiveNotification = fields[7] as bool
      ..addAuto = fields[8] as bool
      ..received = fields[9] as bool
      ..paymentDate = fields[10] as DateTime
      ..createdDate = fields[11] as DateTime;
  }

  @override
  void write(BinaryWriter writer, IncomeModel obj) {
    writer
      ..writeByte(12)
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
      ..write(obj.repeat)
      ..writeByte(6)
      ..write(obj.comment)
      ..writeByte(7)
      ..write(obj.isReceiveNotification)
      ..writeByte(8)
      ..write(obj.addAuto)
      ..writeByte(9)
      ..write(obj.received)
      ..writeByte(10)
      ..write(obj.paymentDate)
      ..writeByte(11)
      ..write(obj.createdDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IncomeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
