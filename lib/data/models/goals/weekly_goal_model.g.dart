// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weekly_goal_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WeeklyGoalModelAdapter extends TypeAdapter<WeeklyGoalModel> {
  @override
  final int typeId = 11;

  @override
  WeeklyGoalModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WeeklyGoalModel()
      ..weeklyGoalModel = fields[0] as GoalModel
      ..goalIsLastConfirmed = fields[1] as bool
      ..goalLastShownDate = fields[2] as DateTime
      ..nextShownDate = fields[3] as DateTime
      ..goalLastConfirmationDate = fields[4] as DateTime
      ..goalCreationDate = fields[5] as DateTime
      ..goalStartSavingDate = fields[6] as DateTime;
  }

  @override
  void write(BinaryWriter writer, WeeklyGoalModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.weeklyGoalModel)
      ..writeByte(1)
      ..write(obj.goalIsLastConfirmed)
      ..writeByte(2)
      ..write(obj.goalLastShownDate)
      ..writeByte(3)
      ..write(obj.nextShownDate)
      ..writeByte(4)
      ..write(obj.goalLastConfirmationDate)
      ..writeByte(5)
      ..write(obj.goalCreationDate)
      ..writeByte(6)
      ..write(obj.goalStartSavingDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeeklyGoalModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
