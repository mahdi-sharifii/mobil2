// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'name_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NameModelAdapter extends TypeAdapter<NameModel> {
  @override
  final int typeId = 2;

  @override
  NameModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NameModel(
      id: fields[0] as int?,
      name: fields[1] as String?,
      color: fields[3] as num?,
      dateTime: fields[2] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, NameModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.dateTime)
      ..writeByte(3)
      ..write(obj.color);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NameModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
