// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_list_item_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomListItemData _$RoomListItemDataFromJson(Map<String, dynamic> json) =>
    RoomListItemData(
      json['houseCode'] as String,
      json['title'] as String,
      json['desc'] as String,
      json['houseImg'] as String,
      (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      json['price'] as int,
    );

Map<String, dynamic> _$RoomListItemDataToJson(RoomListItemData instance) =>
    <String, dynamic>{
      'houseCode': instance.id,
      'title': instance.title,
      'desc': instance.subTitle,
      'houseImg': instance.imageUri,
      'tags': instance.tags,
      'price': instance.price,
    };
