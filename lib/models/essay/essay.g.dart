// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'essay.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EssayAdapter extends TypeAdapter<Essay> {
  @override
  final int typeId = 1;

  @override
  Essay read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Essay(
      id: fields[0] as String,
      date: fields[1] as DateTime,
      isPublic: fields[2] as int,
      wordCount: fields[3] as int,
      content: fields[4] as String,
      imgs: (fields[5] as List).cast<String>(),
      labels: (fields[6] as List).cast<String>(),
      messages: (fields[7] as List).cast<Message>(),
    );
  }

  @override
  void write(BinaryWriter writer, Essay obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.isPublic)
      ..writeByte(3)
      ..write(obj.wordCount)
      ..writeByte(4)
      ..write(obj.content)
      ..writeByte(5)
      ..write(obj.imgs)
      ..writeByte(6)
      ..write(obj.labels)
      ..writeByte(7)
      ..write(obj.messages);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EssayAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
