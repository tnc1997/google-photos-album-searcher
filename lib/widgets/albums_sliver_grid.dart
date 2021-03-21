import 'package:album_searcher_for_google_photos/models/album.dart';
import 'package:album_searcher_for_google_photos/widgets/album_card.dart';
import 'package:flutter/material.dart';

class AlbumsSliverGrid extends StatelessWidget {
  final List<Album> albums;

  const AlbumsSliverGrid({
    Key? key,
    required this.albums,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) => Padding(
          padding: const EdgeInsets.all(8),
          child: AlbumCard(
            key: ValueKey(albums[index]),
            album: albums[index],
          ),
        ),
        childCount: albums.length,
      ),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 500,
      ),
    );
  }
}
