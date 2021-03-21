// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MediaItem _$MediaItemFromJson(Map<String, dynamic> json) {
  return MediaItem(
    id: json['id'] as String,
    description: json['description'] as String?,
    productUrl: json['productUrl'] as String?,
    baseUrl: json['baseUrl'] as String?,
    mimeType: json['mimeType'] as String?,
    mediaMetadata: json['mediaMetadata'] == null
        ? null
        : MediaMetadata.fromJson(json['mediaMetadata'] as Map<String, dynamic>),
    contributorInfo: json['contributorInfo'] == null
        ? null
        : ContributorInfo.fromJson(
            json['contributorInfo'] as Map<String, dynamic>),
    filename: json['filename'] as String?,
  );
}

Map<String, dynamic> _$MediaItemToJson(MediaItem instance) => <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'productUrl': instance.productUrl,
      'baseUrl': instance.baseUrl,
      'mimeType': instance.mimeType,
      'mediaMetadata': instance.mediaMetadata,
      'contributorInfo': instance.contributorInfo,
      'filename': instance.filename,
    };
