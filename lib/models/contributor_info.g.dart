// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contributor_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContributorInfo _$ContributorInfoFromJson(Map<String, dynamic> json) {
  return ContributorInfo(
    profilePictureBaseUrl: json['profilePictureBaseUrl'] as String?,
    displayName: json['displayName'] as String?,
  );
}

Map<String, dynamic> _$ContributorInfoToJson(ContributorInfo instance) =>
    <String, dynamic>{
      'profilePictureBaseUrl': instance.profilePictureBaseUrl,
      'displayName': instance.displayName,
    };
