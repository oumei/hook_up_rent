
import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

part 'info_item.g.dart';

@JsonSerializable()
class InfoItem {
  final int id;
  final String title;
  @JsonKey(name: 'imgSrc')
  final String imageUri;
  @JsonKey(name: 'from')
  final String source;
  @JsonKey(name: 'date')
  final String time;
  final String navigateUri;

  const InfoItem(this.id,this.title,this.imageUri,this.source,this.time,this.navigateUri);

  factory InfoItem.fromJson(Map<String,dynamic> json) => _$InfoItemFromJson(json);
  Map<String,dynamic> toJson() => _$InfoItemToJson(this);
}