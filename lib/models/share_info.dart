import 'package:album_searcher_for_google_photos/models/shared_album_options.dart';
import 'package:json_annotation/json_annotation.dart';

part 'share_info.g.dart';

@JsonSerializable()
class ShareInfo {
  SharedAlbumOptions? sharedAlbumOptions;
  String? shareableUrl;
  String? shareToken;
  bool? isJoined;
  bool? isOwned;
  bool? isJoinable;

  ShareInfo({
    this.sharedAlbumOptions,
    this.shareableUrl,
    this.shareToken,
    this.isJoined,
    this.isOwned,
    this.isJoinable,
  });

  factory ShareInfo.fromJson(Map<String, dynamic> json) =>
      _$ShareInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ShareInfoToJson(this);
}
