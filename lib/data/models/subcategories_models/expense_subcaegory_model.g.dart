// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_subcaegory_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubCategoryExpenseAdapter extends TypeAdapter<SubCategoryExpense> {
  @override
  final int typeId = 6;

  @override
  SubCategoryExpense read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubCategoryExpense()
      ..id = fields[0] as String
      ..mainCategoryExpenseName = fields[1] as String
      ..subCategoryExpenseName = fields[2] as String
      ..subCategoryExpenseIconName = fields[3] as String
      ..subCategoryExpenseColor = fields[4] as String
      ..subCategoryExpenseIconCodePoint = fields[5] as int;
  }

  @override
  void write(BinaryWriter writer, SubCategoryExpense obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.mainCategoryExpenseName)
      ..writeByte(2)
      ..write(obj.subCategoryExpenseName)
      ..writeByte(3)
      ..write(obj.subCategoryExpenseIconName)
      ..writeByte(4)
      ..write(obj.subCategoryExpenseColor)
      ..writeByte(5)
      ..write(obj.subCategoryExpenseIconCodePoint);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubCategoryExpenseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
