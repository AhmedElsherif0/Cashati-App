// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_types_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpenseRepeatTypesAdapter extends TypeAdapter<ExpenseRepeatTypes> {
  @override
  final int typeId = 2;

  @override
  ExpenseRepeatTypes read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExpenseRepeatTypes()
      ..dailyExpense = (fields[0] as List).cast<ExpenseRepeatDetailsModel>()
      ..weeklyExpense = (fields[1] as List).cast<ExpenseRepeatDetailsModel>()
      ..monthlyExpense = (fields[2] as List).cast<ExpenseRepeatDetailsModel>()
      ..noRepeatExpense = (fields[3] as List).cast<ExpenseRepeatDetailsModel>();
  }

  @override
  void write(BinaryWriter writer, ExpenseRepeatTypes obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.dailyExpense)
      ..writeByte(1)
      ..write(obj.weeklyExpense)
      ..writeByte(2)
      ..write(obj.monthlyExpense)
      ..writeByte(3)
      ..write(obj.noRepeatExpense);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseRepeatTypesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
