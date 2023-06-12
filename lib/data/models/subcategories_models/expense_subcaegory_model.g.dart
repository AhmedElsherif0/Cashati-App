// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_subcaegory_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubCategoryAdapter extends TypeAdapter<SubCategory> {
  @override
  final int typeId = 6;

  @override
  SubCategory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubCategory()
      ..id = fields[0] as String
      ..mainCategoryName = fields[1] as String
      ..subCategoryName = fields[2] as String
      ..subCategoryIconName = fields[3] as String;
  }

  @override
  void write(BinaryWriter writer, SubCategory obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.mainCategoryName)
      ..writeByte(2)
      ..write(obj.subCategoryName)
      ..writeByte(3)
      ..write(obj.subCategoryIconName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
