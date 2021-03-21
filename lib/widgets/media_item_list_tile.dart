import 'package:album_searcher_for_google_photos/models/media_item.dart';
import 'package:flutter/material.dart';

class MediaItemListTile extends StatelessWidget {
  final MediaItem mediaItem;

  const MediaItemListTile({
    Key? key,
    required this.mediaItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        mediaItem.filename ?? mediaItem.id,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }
}
