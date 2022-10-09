// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_detail_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomDetailData _$RoomDetailDataFromJson(Map<String, dynamic> json) =>
    RoomDetailData(
      json['houseCode'] as String,
      json['title'] as String,
      json['community'] as String,
      json['description'] as String,
      json['size'] as int,
      json['floor'] as String,
      json['price'] as int,
      json['roomType'] as String,
      (json['houseImg'] as List<dynamic>).map((e) => e as String).toList(),
      (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      (json['oriented'] as List<dynamic>).map((e) => e as String).toList(),
      (json['supporting'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$RoomDetailDataToJson(RoomDetailData instance) =>
    <String, dynamic>{
      'houseCode': instance.id,
      'title': instance.title,
      'community': instance.community,
      'description': instance.subTitle,
      'size': instance.size,
      'floor': instance.floor,
      'price': instance.price,
      'roomType': instance.roomType,
      'houseImg': instance.houseImgs,
      'tags': instance.tags,
      'oriented': instance.oriented,
      'supporting': instance.appliances,
    };
