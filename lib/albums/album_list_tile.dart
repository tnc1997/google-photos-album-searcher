import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:googleapis/photoslibrary/v1.dart';

class AlbumListTile extends StatelessWidget {
  const AlbumListTile({
    super.key,
    required this.album,
  });

  final Album album;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        album.title ?? album.id ?? '',
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
      onTap: () {
        context.go('/albums/${album.id}');
      },
    );
  }
}
