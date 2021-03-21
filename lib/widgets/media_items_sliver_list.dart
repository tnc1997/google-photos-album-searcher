import 'package:album_searcher_for_google_photos/models/media_item.dart';
import 'package:album_searcher_for_google_photos/widgets/media_item_list_tile.dart';
import 'package:flutter/material.dart';

class MediaItemsSliverList extends StatelessWidget {
  final List<MediaItem> mediaItems;

  const MediaItemsSliverList({
    Key? key,
    required this.mediaItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => MediaItemListTile(
          key: ValueKey(mediaItems[index]),
          mediaItem: mediaItems[index],
        ),
        childCount: mediaItems.length,
      ),
    );
  }
}
