// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'income_types_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MonthlyIncomeModelAdapter extends TypeAdapter<MonthlyIncomeModel> {
  @override
  final int typeId = 5;

  @override
  MonthlyIncomeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MonthlyIncomeModel()
      ..dailyExpense = (fields[0] as List).cast<IncomeRepeatDetailsModel>()
      ..weeklyExpense = (fields[1] as List).cast<IncomeRepeatDetailsModel>()
      ..monthlyExpense = (fields[2] as List).cast<IncomeRepeatDetailsModel>()
      ..noRepeatExpense = (fields[3] as List).cast<IncomeRepeatDetailsModel>();
  }

  @override
  void write(BinaryWriter writer, MonthlyIncomeModel obj) {
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
      other is MonthlyIncomeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
