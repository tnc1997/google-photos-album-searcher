import 'package:json_annotation/json_annotation.dart';

part 'contributor_info.g.dart';

@JsonSerializable()
class ContributorInfo {
  String? profilePictureBaseUrl;
  String? displayName;

  ContributorInfo({
    this.profilePictureBaseUrl,
    this.displayName,
  });

  factory ContributorInfo.fromJson(Map<String, dynamic> json) =>
      _$ContributorInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ContributorInfoToJson(this);
}
