import 'package:album_searcher_for_google_photos/models/media_item.dart';
import 'package:flutter/material.dart';

class MediaItemCard extends StatelessWidget {
  final MediaItem mediaItem;

  const MediaItemCard({
    Key? key,
    required this.mediaItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      margin: EdgeInsets.zero,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (mediaItem.baseUrl != null)
              Image.network(
                '${mediaItem.baseUrl}=w2048-h1024',
                color: Color.fromRGBO(0, 0, 0, 0.5),
                colorBlendMode: BlendMode.darken,
                fit: BoxFit.cover,
              ),
            Positioned(
              left: 16,
              right: 16,
              bottom: 16,
              child: Text(
                mediaItem.filename ?? mediaItem.id,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: Colors.white),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
