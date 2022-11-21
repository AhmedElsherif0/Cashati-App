// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'income_subcaegory_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubCategoryIncomeAdapter extends TypeAdapter<SubCategoryIncome> {
  @override
  final int typeId = 7;

  @override
  SubCategoryIncome read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubCategoryIncome()
      ..id = fields[0] as String
      ..mainCategoryIncomeName = fields[1] as String
      ..subCategoryIncomeName = fields[2] as String
      ..subCategoryIncomeIconName = fields[3] as String
      ..subCategoryIncomeColor = fields[4] as String
      ..subCategoryIncomeCodePoint = fields[5] as int;
  }

  @override
  void write(BinaryWriter writer, SubCategoryIncome obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.mainCategoryIncomeName)
      ..writeByte(2)
      ..write(obj.subCategoryIncomeName)
      ..writeByte(3)
      ..write(obj.subCategoryIncomeIconName)
      ..writeByte(4)
      ..write(obj.subCategoryIncomeColor)
      ..writeByte(5)
      ..write(obj.subCategoryIncomeCodePoint);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubCategoryIncomeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
