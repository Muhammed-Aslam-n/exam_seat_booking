// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_helper.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserLoginDetailsAdapter extends TypeAdapter<UserLoginDetails> {
  @override
  final int typeId = 0;

  @override
  UserLoginDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserLoginDetails(
      userName: fields[0] as String?,
      password: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserLoginDetails obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.userName)
      ..writeByte(1)
      ..write(obj.password);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserLoginDetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class UserExamDetailsAdapter extends TypeAdapter<UserExamDetails> {
  @override
  final int typeId = 1;

  @override
  UserExamDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserExamDetails(
      userName: fields[0] as String?,
      registeringUserName: fields[1] as String?,
      age: fields[2] as String?,
      gender: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserExamDetails obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.userName)
      ..writeByte(1)
      ..write(obj.registeringUserName)
      ..writeByte(2)
      ..write(obj.age)
      ..writeByte(4)
      ..write(obj.gender);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserExamDetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
