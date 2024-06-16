import 'package:flutter/material.dart';
import 'package:googleapis/photoslibrary/v1.dart';

import 'album_list_tile.dart';

class AlbumSliverList extends StatelessWidget {
  const AlbumSliverList({
    super.key,
    required this.albums,
  });

  final List<Album> albums;

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemBuilder: (context, index) {
        return AlbumListTile(
          key: ValueKey(albums[index]),
          album: albums[index],
        );
      },
      itemCount: albums.length,
    );
  }
}
