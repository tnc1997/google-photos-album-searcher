import 'package:album_searcher_for_google_photos/models/share_info.dart';
import 'package:json_annotation/json_annotation.dart';

part 'album.g.dart';

@JsonSerializable()
class Album implements Comparable<Album> {
  String id;
  String? title;
  String? productUrl;
  bool? isWriteable;
  ShareInfo? shareInfo;
  String? mediaItemsCount;
  String? coverPhotoBaseUrl;
  String? coverPhotoMediaItemId;

  Album({
    required this.id,
    this.title,
    this.productUrl,
    this.isWriteable,
    this.shareInfo,
    this.mediaItemsCount,
    this.coverPhotoBaseUrl,
    this.coverPhotoMediaItemId,
  });

  factory Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);

  Map<String, dynamic> toJson() => _$AlbumToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Album && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  int compareTo(Album other) => (title ?? '').compareTo(other.title ?? '');

  @override
  String toString() => title ?? super.toString();
}
