// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generate_invoice_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GenerateInvoiceModelAdapter extends TypeAdapter<GenerateInvoiceModel> {
  @override
  final int typeId = 2;

  @override
  GenerateInvoiceModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GenerateInvoiceModel(
      customerName: fields[1] as String,
      dateTime: fields[2] as DateTime,
      items: (fields[3] as List).cast<InvoiceItem>(),
      total: fields[4] as double,
    );
  }

  @override
  void write(BinaryWriter writer, GenerateInvoiceModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.customerName)
      ..writeByte(2)
      ..write(obj.dateTime)
      ..writeByte(3)
      ..write(obj.items)
      ..writeByte(4)
      ..write(obj.total);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GenerateInvoiceModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
