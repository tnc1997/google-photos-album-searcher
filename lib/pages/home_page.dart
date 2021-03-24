import 'package:album_searcher_for_google_photos/enums/layout_mode.dart';
import 'package:album_searcher_for_google_photos/models/album.dart';
import 'package:album_searcher_for_google_photos/services/shared_album_service.dart';
import 'package:album_searcher_for_google_photos/sliver_persistent_header_delegates/sliver_search_bar_delegate.dart';
import 'package:album_searcher_for_google_photos/specifications/album_title_specification.dart';
import 'package:album_searcher_for_google_photos/states/layout_state.dart';
import 'package:album_searcher_for_google_photos/states/shared_album_state.dart';
import 'package:album_searcher_for_google_photos/widgets/albums_sliver_grid.dart';
import 'package:album_searcher_for_google_photos/widgets/albums_sliver_list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _query;

  @override
  Widget build(BuildContext context) {
    final sharedAlbums = SharedAlbumState.of(context).sharedAlbums?.toList();
    if (sharedAlbums != null) {
      final query = _query;
      if (query != null && query.isNotEmpty) {
        final specification = AlbumTitleSpecification(title: query);
        sharedAlbums.retainWhere(specification.isSatisfiedBy);
      }

      Widget albumsSliver;
      switch (LayoutState.of(context).layoutMode) {
        case LayoutMode.grid:
          albumsSliver = SliverPadding(
            padding: const EdgeInsets.all(8),
            sliver: AlbumsSliverGrid(
              albums: sharedAlbums..sort(),
            ),
          );
          break;
        case LayoutMode.list:
          albumsSliver = AlbumsSliverList(
            albums: sharedAlbums..sort(),
          );
          break;
      }

      return RefreshIndicator(
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              delegate: SliverSearchBarDelegate(
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search',
                          prefixIcon: Icon(Icons.search),
                        ),
                        autofocus: true,
                        onChanged: (value) {
                          setState(() {
                            _query = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              floating: true,
            ),
            albumsSliver,
          ],
        ),
        onRefresh: () async {
          try {
            await SharedAlbumServiceScope.of(context).list();
          } catch (e) {
            await showDialog<void>(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Error'),
                content: Text(e.toString()),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('OK'),
                  ),
                ],
              ),
            );
          }
        },
      );
    } else {
      return FutureBuilder<List<Album>>(
        future: SharedAlbumServiceScope.of(context).list(),
        builder: (context, snapshot) => Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
