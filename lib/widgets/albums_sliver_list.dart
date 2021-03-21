import 'package:album_searcher_for_google_photos/models/album.dart';
import 'package:album_searcher_for_google_photos/widgets/album_list_tile.dart';
import 'package:flutter/material.dart';

class AlbumsSliverList extends StatelessWidget {
  final List<Album> albums;

  const AlbumsSliverList({
    Key? key,
    required this.albums,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => AlbumListTile(
          key: ValueKey(albums[index]),
          album: albums[index],
        ),
        childCount: albums.length,
      ),
    );
  }
}
