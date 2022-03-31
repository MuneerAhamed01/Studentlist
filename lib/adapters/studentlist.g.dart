// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'studentlist.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StudentlistAdapter extends TypeAdapter<Studentlist> {
  @override
  final int typeId = 0;

  @override
  Studentlist read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Studentlist(
      name: fields[0] as String?,
      phone: fields[1] as String?,
      subject: fields[2] as String?,
      address: fields[3] as String?,
      image: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Studentlist obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.phone)
      ..writeByte(2)
      ..write(obj.subject)
      ..writeByte(3)
      ..write(obj.address)
      ..writeByte(4)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentlistAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
