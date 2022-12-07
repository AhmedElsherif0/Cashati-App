// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_types_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionRepeatTypesAdapter
    extends TypeAdapter<TransactionRepeatTypes> {
  @override
  final int typeId = 2;

  @override
  TransactionRepeatTypes read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TransactionRepeatTypes()
      ..dailyExpense = (fields[0] as List).cast<TransactionRepeatDetailsModel>()
      ..weeklyExpense =
          (fields[1] as List).cast<TransactionRepeatDetailsModel>()
      ..monthlyExpense =
          (fields[2] as List).cast<TransactionRepeatDetailsModel>()
      ..noRepeatExpense =
          (fields[3] as List).cast<TransactionRepeatDetailsModel>();
  }

  @override
  void write(BinaryWriter writer, TransactionRepeatTypes obj) {
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
      other is TransactionRepeatTypesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
