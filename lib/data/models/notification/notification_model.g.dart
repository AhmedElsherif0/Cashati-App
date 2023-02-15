// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotificationModelAdapter extends TypeAdapter<NotificationModel> {
  @override
  final int typeId = 5;

  @override
  NotificationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotificationModel(
      id: fields[0] as String,
      modelName: fields[1] as String,
      typeName: fields[2] as String,
      amount: fields[3] as num,
      didTakeAction: fields[4] as bool,
      actionDate: fields[5] as DateTime,
      icon: fields[7] as String?,
      payLoad: fields[8] as String?,
      checkedDate: fields[6] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, NotificationModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.modelName)
      ..writeByte(2)
      ..write(obj.typeName)
      ..writeByte(3)
      ..write(obj.amount)
      ..writeByte(4)
      ..write(obj.didTakeAction)
      ..writeByte(5)
      ..write(obj.actionDate)
      ..writeByte(6)
      ..write(obj.checkedDate)
      ..writeByte(7)
      ..write(obj.icon)
      ..writeByte(8)
      ..write(obj.payLoad);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
