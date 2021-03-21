import 'package:album_searcher_for_google_photos/extensions/string_extensions.dart';
import 'package:album_searcher_for_google_photos/models/album.dart';
import 'package:album_searcher_for_google_photos/specifications/specification.dart';

class AlbumTitleSpecification extends Specification<Album> {
  final String title;

  const AlbumTitleSpecification({
    required this.title,
  });

  @override
  bool isSatisfiedBy(Album value) {
    final title = value.title;

    return title != null && title.uglify().contains(this.title.uglify());
  }
}
