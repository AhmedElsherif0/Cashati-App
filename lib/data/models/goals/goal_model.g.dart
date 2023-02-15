// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GoalModelAdapter extends TypeAdapter<GoalModel> {
  @override
  final int typeId = 3;

  @override
  GoalModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GoalModel()
      ..id = fields[0] as String
      ..goalName = fields[1] as String
      ..goalTotalAmount = fields[2] as num
      ..goalSaveAmount = fields[3] as num
      ..goalRemainingAmount = fields[4] as num
      ..goalSaveAmountRepeat = fields[5] as String
      ..goalComment = fields[6] as String
      ..goalRemainingPeriod = fields[7] as int
      ..goalCreatedDay = fields[8] as DateTime
      ..goalStartSavingDate = fields[9] as DateTime
      ..goalCompletionDate = fields[10] as DateTime;
  }

  @override
  void write(BinaryWriter writer, GoalModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.goalName)
      ..writeByte(2)
      ..write(obj.goalTotalAmount)
      ..writeByte(3)
      ..write(obj.goalSaveAmount)
      ..writeByte(4)
      ..write(obj.goalRemainingAmount)
      ..writeByte(5)
      ..write(obj.goalSaveAmountRepeat)
      ..writeByte(6)
      ..write(obj.goalComment)
      ..writeByte(7)
      ..write(obj.goalRemainingPeriod)
      ..writeByte(8)
      ..write(obj.goalCreatedDay)
      ..writeByte(9)
      ..write(obj.goalStartSavingDate)
      ..writeByte(10)
      ..write(obj.goalCompletionDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GoalModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
