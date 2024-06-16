import 'package:flutter/material.dart';
import 'package:googleapis/photoslibrary/v1.dart';

import 'media_item_card.dart';

class MediaItemSliverGrid extends StatelessWidget {
  const MediaItemSliverGrid({
    super.key,
    required this.mediaItems,
  });

  final List<MediaItem> mediaItems;

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 500,
      ),
      itemBuilder: (context, index) {
        return MediaItemCard(
          key: ValueKey(mediaItems[index]),
          mediaItem: mediaItems[index],
        );
      },
      itemCount: mediaItems.length,
    );
  }
}
