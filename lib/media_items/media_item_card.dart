import 'package:flutter/material.dart';
import 'package:googleapis/photoslibrary/v1.dart';

class MediaItemCard extends StatelessWidget {
  const MediaItemCard({
    super.key,
    required this.mediaItem,
  });

  final MediaItem mediaItem;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (mediaItem.baseUrl case final baseUrl?)
            FittedBox(
              fit: BoxFit.cover,
              alignment: Alignment.center,
              clipBehavior: Clip.hardEdge,
              child: Image.network('$baseUrl=w512-h512'),
            ),
        ],
      ),
    );
  }
}
