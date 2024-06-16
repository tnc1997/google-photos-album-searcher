import 'package:flutter/material.dart';
import 'package:googleapis/photoslibrary/v1.dart';
import 'package:provider/provider.dart';

import '../media_items/media_item_repository.dart';
import '../media_items/media_item_sliver_grid.dart';
import '../media_items/media_item_sliver_list.dart';
import '../settings/theme_notifier.dart';
import 'album_repository.dart';
import 'album_sliver_app_bar.dart';

class AlbumScreen extends StatefulWidget {
  const AlbumScreen({
    super.key,
    required this.albumId,
  });

  final String albumId;

  @override
  State<AlbumScreen> createState() {
    return _AlbumScreenState();
  }
}

class _AlbumScreenState extends State<AlbumScreen> {
  late final Future<(Album?, List<MediaItem>)> _future;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.data case final data?) {
              if (data.$1 case final album?) {
                return _CustomScrollView(
                  album: album,
                  mediaItems: data.$2,
                );
              }

              return Center(
                child: Text(
                  'Failed to find the album \'${widget.albumId}\'.',
                ),
              );
            }

            if (snapshot.error case final error?) {
              return Center(
                child: Text('$error'),
              );
            }

            return const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: CircularProgressIndicator(),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text('Getting photos from Google Photos.'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text('This might take a few seconds.'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _future = (
      context.read<AlbumRepository>().get(widget.albumId),
      context.read<MediaItemRepository>().search(widget.albumId),
    ).wait;
  }
}

class _CustomScrollView extends StatelessWidget {
  const _CustomScrollView({
    super.key,
    required this.album,
    required this.mediaItems,
  });

  final Album album;

  final List<MediaItem> mediaItems;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        AlbumSliverAppBar(
          album: album,
        ),
        switch (context.select<ThemeNotifier, LayoutMode>(
          (notifier) {
            return notifier.layoutMode;
          },
        )) {
          LayoutMode.grid => SliverPadding(
              padding: const EdgeInsets.all(2),
              sliver: MediaItemSliverGrid(
                mediaItems: mediaItems..sort(_comparator),
              ),
            ),
          LayoutMode.list => MediaItemSliverList(
              mediaItems: mediaItems..sort(_comparator),
            ),
        },
      ],
    );
  }

  static int _comparator(MediaItem a, MediaItem b) {
    final x = a.mediaMetadata?.creationTime;
    final y = b.mediaMetadata?.creationTime;

    if (x != null && y != null) {
      return x.compareTo(y);
    } else if (x != null) {
      return -1;
    } else if (y != null) {
      return 1;
    } else {
      return 0;
    }
  }
}
