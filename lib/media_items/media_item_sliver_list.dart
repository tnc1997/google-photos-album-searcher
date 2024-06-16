import 'package:flutter/material.dart';
import 'package:googleapis/photoslibrary/v1.dart';

import 'media_item_list_tile.dart';

class MediaItemSliverList extends StatelessWidget {
  const MediaItemSliverList({
    super.key,
    required this.mediaItems,
  });

  final List<MediaItem> mediaItems;

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemBuilder: (context, index) {
        return MediaItemListTile(
          key: ValueKey(mediaItems[index]),
          mediaItem: mediaItems[index],
        );
      },
      itemCount: mediaItems.length,
    );
  }
}
