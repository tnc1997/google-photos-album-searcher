import 'package:json_annotation/json_annotation.dart';

part 'shared_album_options.g.dart';

@JsonSerializable()
class SharedAlbumOptions {
  bool? isCollaborative;
  bool? isCommentable;

  SharedAlbumOptions({
    this.isCollaborative,
    this.isCommentable,
  });

  factory SharedAlbumOptions.fromJson(Map<String, dynamic> json) =>
      _$SharedAlbumOptionsFromJson(json);

  Map<String, dynamic> toJson() => _$SharedAlbumOptionsToJson(this);
}
