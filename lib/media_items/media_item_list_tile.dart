import 'package:flutter/material.dart';
import 'package:googleapis/photoslibrary/v1.dart';

class MediaItemListTile extends StatelessWidget {
  const MediaItemListTile({
    super.key,
    required this.mediaItem,
  });

  final MediaItem mediaItem;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        mediaItem.filename ?? mediaItem.id ?? '',
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }
}
