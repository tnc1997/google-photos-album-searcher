// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'share_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShareInfo _$ShareInfoFromJson(Map<String, dynamic> json) {
  return ShareInfo(
    sharedAlbumOptions: json['sharedAlbumOptions'] == null
        ? null
        : SharedAlbumOptions.fromJson(
            json['sharedAlbumOptions'] as Map<String, dynamic>),
    shareableUrl: json['shareableUrl'] as String?,
    shareToken: json['shareToken'] as String?,
    isJoined: json['isJoined'] as bool?,
    isOwned: json['isOwned'] as bool?,
    isJoinable: json['isJoinable'] as bool?,
  );
}

Map<String, dynamic> _$ShareInfoToJson(ShareInfo instance) => <String, dynamic>{
      'sharedAlbumOptions': instance.sharedAlbumOptions,
      'shareableUrl': instance.shareableUrl,
      'shareToken': instance.shareToken,
      'isJoined': instance.isJoined,
      'isOwned': instance.isOwned,
      'isJoinable': instance.isJoinable,
    };
