import 'package:album_searcher_for_google_photos/models/contributor_info.dart';
import 'package:album_searcher_for_google_photos/models/media_metadata.dart';
import 'package:json_annotation/json_annotation.dart';

part 'media_item.g.dart';

@JsonSerializable()
class MediaItem implements Comparable<MediaItem> {
  String id;
  String? description;
  String? productUrl;
  String? baseUrl;
  String? mimeType;
  MediaMetadata? mediaMetadata;
  ContributorInfo? contributorInfo;
  String? filename;

  MediaItem({
    required this.id,
    this.description,
    this.productUrl,
    this.baseUrl,
    this.mimeType,
    this.mediaMetadata,
    this.contributorInfo,
    this.filename,
  });

  factory MediaItem.fromJson(Map<String, dynamic> json) =>
      _$MediaItemFromJson(json);

  Map<String, dynamic> toJson() => _$MediaItemToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MediaItem && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  int compareTo(MediaItem other) =>
      (filename ?? '').compareTo(other.filename ?? '');

  @override
  String toString() => filename ?? super.toString();
}
