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
      balance: fields[0] as num,
      topIncome: fields[1] as String,
      topIncomeAmount: fields[2] as num,
      topExpense: fields[3] as String,
      topExpenseAmount: fields[4] as num,
      latestCheck: fields[5] as DateTime,
      notificationList: (fields[6] as List).cast<NotificationModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, GeneralStatsModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.balance)
      ..writeByte(1)
      ..write(obj.topIncome)
      ..writeByte(2)
      ..write(obj.topIncomeAmount)
      ..writeByte(3)
      ..write(obj.topExpense)
      ..writeByte(4)
      ..write(obj.topExpenseAmount)
      ..writeByte(5)
      ..write(obj.latestCheck)
      ..writeByte(6)
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
