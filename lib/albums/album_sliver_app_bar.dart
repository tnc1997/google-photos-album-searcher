import 'package:flutter/material.dart';
import 'package:googleapis/photoslibrary/v1.dart';
import 'package:provider/provider.dart';

import '../common/open_in_google_photos_icon_button.dart';
import '../media_items/media_item_repository.dart';

class AlbumSliverAppBar extends StatefulWidget {
  const AlbumSliverAppBar({
    super.key,
    required this.album,
  });

  final Album album;

  @override
  State<AlbumSliverAppBar> createState() {
    return _AlbumSliverAppBarState();
  }
}

class _AlbumSliverAppBarState extends State<AlbumSliverAppBar> {
  late final Future<MediaItem?>? _future;

  @override
  Widget build(BuildContext context) {
    final actions = [
      if (widget.album.productUrl case final productUrl?)
        OpenInGooglePhotosIconButton(
          productUrl: productUrl,
        ),
    ];

    if (_future case final future?) {
      return SliverAppBar(
        actions: actions,
        flexibleSpace: FlexibleSpaceBar(
          title: Text(
            widget.album.title ?? widget.album.id ?? '',
            style: const TextStyle(
              color: Colors.white,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          background: FutureBuilder(
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
                        child: Image.network('$baseUrl=w1024-h512'),
                      ),
                    ),
                    Positioned.fill(
                      child: Container(
                        color: const Color.fromRGBO(0, 0, 0, 0.5),
                      ),
                    ),
                  ],
                );
              } else {
                return Container();
              }
            },
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        expandedHeight: MediaQuery.sizeOf(context).height * 0.5,
        pinned: true,
      );
    }

    return SliverAppBar(
      title: Text(
        widget.album.title ?? widget.album.id ?? '',
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
      actions: actions,
      pinned: true,
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
