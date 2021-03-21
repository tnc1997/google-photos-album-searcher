import 'package:album_searcher_for_google_photos/models/album.dart';
import 'package:album_searcher_for_google_photos/states/router_state.dart';
import 'package:flutter/material.dart';

class AlbumListTile extends StatelessWidget {
  final Album album;

  const AlbumListTile({
    Key? key,
    required this.album,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        album.title ?? album.id,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
      onTap: () {
        RouterState.of(context).selectedAlbum = album.id;
      },
    );
  }
}
