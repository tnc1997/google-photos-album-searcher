import 'package:flutter/material.dart';
import 'package:googleapis/photoslibrary/v1.dart';

import 'album_card.dart';

class AlbumSliverGrid extends StatelessWidget {
  const AlbumSliverGrid({
    super.key,
    required this.albums,
  });

  final List<Album> albums;

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 250,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
      ),
      itemBuilder: (context, index) {
        return AlbumCard(
          key: ValueKey(albums[index]),
          album: albums[index],
        );
      },
      itemCount: albums.length,
    );
  }
}
