// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catagory_models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CatagoryModelAdapter extends TypeAdapter<CatagoryModel> {
  @override
  final int typeId = 1;

  @override
  CatagoryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CatagoryModel(
      id: fields[0] as String,
      name: fields[1] as String,
      type: fields[3] as catagoryType,
      isdeleted: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, CatagoryModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.isdeleted)
      ..writeByte(3)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CatagoryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// ignore: camel_case_types
class catagoryTypeAdapter extends TypeAdapter<catagoryType> {
  @override
  final int typeId = 2;

  @override
  catagoryType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return catagoryType.income;
      case 1:
        return catagoryType.expense;
      default:
        return catagoryType.income;
    }
  }

  @override
  void write(BinaryWriter writer, catagoryType obj) {
    switch (obj) {
      case catagoryType.income:
        writer.writeByte(0);
        break;
      case catagoryType.expense:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is catagoryTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
