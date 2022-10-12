// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InfoItem _$InfoItemFromJson(Map<String, dynamic> json) => InfoItem(
      json['id'] as int,
      json['title'] as String,
      json['imgSrc'] as String,
      json['from'] as String,
      json['date'] as String,
      json['navigateUri'] as String,
    );

Map<String, dynamic> _$InfoItemToJson(InfoItem instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'imgSrc': instance.imageUri,
      'from': instance.source,
      'date': instance.time,
      'navigateUri': instance.navigateUri,
    };
