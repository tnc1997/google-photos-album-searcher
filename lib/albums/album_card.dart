import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:googleapis/photoslibrary/v1.dart';
import 'package:provider/provider.dart';

import '../media_items/media_item_repository.dart';

class AlbumCard extends StatefulWidget {
  const AlbumCard({
    super.key,
    required this.album,
  });

  final Album album;

  @override
  State<AlbumCard> createState() {
    return _AlbumCardState();
  }
}

class _AlbumCardState extends State<AlbumCard> {
  late final Future<MediaItem?>? _future;

  @override
  Widget build(BuildContext context) {
    final child = InkWell(
      onTap: () {
        context.go('/albums/${widget.album.id}');
      },
      child: Container(
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.all(8),
        child: Text(
          widget.album.title ?? widget.album.id ?? '',
          style: const TextStyle(
            color: Colors.white,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ),
    );

    if (_future case final future?) {
      return Card(
        clipBehavior: Clip.antiAlias,
        child: FutureBuilder(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.data?.baseUrl case final baseUrl?) {
              return Stack(
                children: [
                  Positioned.fill(
                    child: FittedBox(
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                      clipBehavior: Clip.hardEdge,
                      child: Image.network('$baseUrl=w256-h256'),
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      color: const Color.fromRGBO(0, 0, 0, 0.5),
                    ),
                  ),
                  Positioned.fill(
                    child: Material(
                      color: Colors.transparent,
                      child: child,
                    ),
                  ),
                ],
              );
            }

            return child;
          },
        ),
      );
    }

    return Card(
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.album.coverPhotoMediaItemId case final mediaItemId?) {
      _future = context.read<MediaItemRepository>().get(mediaItemId);
    }
  }
}
