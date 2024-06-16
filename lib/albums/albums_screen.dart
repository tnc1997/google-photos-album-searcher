import 'package:flutter/material.dart';
import 'package:googleapis/photoslibrary/v1.dart';
import 'package:provider/provider.dart';

import '../common/search_text_field.dart';
import '../common/sliver_search_bar_delegate.dart';
import '../common/string_extensions.dart';
import '../settings/theme_notifier.dart';
import 'album_repository.dart';
import 'album_sliver_grid.dart';
import 'album_sliver_list.dart';

class AlbumsScreen extends StatefulWidget {
  const AlbumsScreen({
    super.key,
  });

  @override
  State<AlbumsScreen> createState() {
    return _AlbumsScreenState();
  }
}

class _AlbumsScreenState extends State<AlbumsScreen> {
  late final Future<List<Album>> _future;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.data case var albums?) {
              return _CustomScrollView(
                albums: albums,
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
                    child: Text('Caching albums from Google Photos.'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text('This might take a few minutes.'),
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
    _future = context.read<AlbumRepository>().list();
  }
}

class _CustomScrollView extends StatefulWidget {
  const _CustomScrollView({
    super.key,
    required this.albums,
  });

  final List<Album> albums;

  @override
  State<_CustomScrollView> createState() {
    return _CustomScrollViewState();
  }
}

class _CustomScrollViewState extends State<_CustomScrollView> {
  String? _query;

  @override
  Widget build(BuildContext context) {
    var albums = widget.albums;

    if (_query case final query? when query.isNotEmpty) {
      albums = albums.where(
        (album) {
          if (album.title case final title?) {
            return title.uglify().contains(query.uglify());
          } else {
            return false;
          }
        },
      ).toList();
    }

    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          delegate: SliverSearchBarDelegate(
            child: SearchTextField(
              onChanged: (value) {
                setState(() {
                  _query = value;
                });
              },
            ),
          ),
          floating: true,
        ),
        switch (context.select<ThemeNotifier, LayoutMode>(
          (notifier) {
            return notifier.layoutMode;
          },
        )) {
          LayoutMode.grid => SliverPadding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: 16,
              ),
              sliver: AlbumSliverGrid(
                albums: albums..sort(_comparator),
              ),
            ),
          LayoutMode.list => AlbumSliverList(
              albums: albums..sort(_comparator),
            ),
        },
      ],
    );
  }

  static int _comparator(Album a, Album b) {
    final x = a.title;
    final y = b.title;

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
