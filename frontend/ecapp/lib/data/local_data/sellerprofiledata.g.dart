// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sellerprofiledata.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SellerProfileAdapter extends TypeAdapter<SellerProfile> {
  @override
  final int typeId = 0;

  @override
  SellerProfile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SellerProfile(
      shopName: fields[0] as String,
      ownerName: fields[1] as String,
      phone: fields[2] as String,
      email: fields[3] as String,
      address: fields[4] as String,
      city: fields[5] as String,
      pincode: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SellerProfile obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.shopName)
      ..writeByte(1)
      ..write(obj.ownerName)
      ..writeByte(2)
      ..write(obj.phone)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.address)
      ..writeByte(5)
      ..write(obj.city)
      ..writeByte(6)
      ..write(obj.pincode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SellerProfileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
