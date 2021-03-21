// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shared_album_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SharedAlbumOptions _$SharedAlbumOptionsFromJson(Map<String, dynamic> json) {
  return SharedAlbumOptions(
    isCollaborative: json['isCollaborative'] as bool?,
    isCommentable: json['isCommentable'] as bool?,
  );
}

Map<String, dynamic> _$SharedAlbumOptionsToJson(SharedAlbumOptions instance) =>
    <String, dynamic>{
      'isCollaborative': instance.isCollaborative,
      'isCommentable': instance.isCommentable,
    };
