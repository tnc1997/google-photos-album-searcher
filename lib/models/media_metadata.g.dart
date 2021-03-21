// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MediaMetadata _$MediaMetadataFromJson(Map<String, dynamic> json) {
  return MediaMetadata(
    creationTime: json['creationTime'] as String?,
    width: json['width'] as String?,
    height: json['height'] as String?,
  );
}

Map<String, dynamic> _$MediaMetadataToJson(MediaMetadata instance) =>
    <String, dynamic>{
      'creationTime': instance.creationTime,
      'width': instance.width,
      'height': instance.height,
    };
