// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'general_stats_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GeneralStatsModelAdapter extends TypeAdapter<GeneralStatsModel> {
  @override
  final int typeId = 7;

  @override
  GeneralStatsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GeneralStatsModel(
      id: fields[0] as String,
      balance: fields[1] as num,
      topIncome: fields[2] as String,
      topIncomeAmount: fields[3] as num,
      topExpense: fields[4] as String,
      topExpenseAmount: fields[5] as num,
      latestCheck: fields[6] as DateTime,
      notificationList: (fields[7] as List).cast<NotificationModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, GeneralStatsModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.balance)
      ..writeByte(2)
      ..write(obj.topIncome)
      ..writeByte(3)
      ..write(obj.topIncomeAmount)
      ..writeByte(4)
      ..write(obj.topExpense)
      ..writeByte(5)
      ..write(obj.topExpenseAmount)
      ..writeByte(6)
      ..write(obj.latestCheck)
      ..writeByte(7)
      ..write(obj.notificationList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GeneralStatsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
