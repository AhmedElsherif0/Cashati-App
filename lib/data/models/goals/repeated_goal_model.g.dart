// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repeated_goal_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GoalRepeatedDetailsModelAdapter extends TypeAdapter<GoalRepeatedDetailsModel> {
  @override
  final int typeId = 10;

  @override
  GoalRepeatedDetailsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GoalRepeatedDetailsModel()
      ..goal = fields[0] as GoalModel
      ..goalIsLastConfirmed = fields[1] as bool
      ..goalLastShownDate = fields[2] as DateTime
      ..nextShownDate = fields[3] as DateTime
      ..goalLastConfirmationDate = fields[4] as DateTime;
  }

  @override
  void write(BinaryWriter writer, GoalRepeatedDetailsModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.goal)
      ..writeByte(1)
      ..write(obj.goalIsLastConfirmed)
      ..writeByte(2)
      ..write(obj.goalLastShownDate)
      ..writeByte(3)
      ..write(obj.nextShownDate)
      ..writeByte(4)
      ..write(obj.goalLastConfirmationDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GoalRepeatedDetailsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
