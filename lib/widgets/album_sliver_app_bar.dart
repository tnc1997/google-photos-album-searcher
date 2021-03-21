import 'package:album_searcher_for_google_photos/models/album.dart';
import 'package:album_searcher_for_google_photos/models/media_item.dart';
import 'package:album_searcher_for_google_photos/services/media_item_service.dart';
import 'package:album_searcher_for_google_photos/widgets/album_open_in_google_photos_icon_button.dart';
import 'package:flutter/material.dart';

class AlbumSliverAppBar extends StatefulWidget {
  final Album album;

  const AlbumSliverAppBar({
    Key? key,
    required this.album,
  }) : super(key: key);

  @override
  _AlbumSliverAppBarState createState() => _AlbumSliverAppBarState();
}

class _AlbumSliverAppBarState extends State<AlbumSliverAppBar> {
  Future<MediaItem>? _future;

  @override
  Widget build(BuildContext context) {
    final coverPhotoBaseUrl = widget.album.coverPhotoBaseUrl;

    if (coverPhotoBaseUrl != null) {
      return SliverAppBar(
        actions: [
          if (widget.album.productUrl != null)
            AlbumOpenInGooglePhotosIconButton(
              album: widget.album,
            ),
        ],
        flexibleSpace: FlexibleSpaceBar(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.album.title ?? widget.album.id,
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.white),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Text(
                '${widget.album.mediaItemsCount ?? '-'} items',
                style: Theme.of(context)
                    .textTheme
                    .caption!
                    .copyWith(color: Colors.white.withAlpha(150)),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
          background: Stack(
            fit: StackFit.expand,
            children: [
              FutureBuilder<MediaItem>(
                future: _future,
                builder: (context, snapshot) => snapshot.hasData
                    ? Image.network(
                        '${snapshot.data!.baseUrl}=w2048-h1024',
                        color: Color.fromRGBO(0, 0, 0, 0.5),
                        colorBlendMode: BlendMode.darken,
                        fit: BoxFit.cover,
                      )
                    : Container(),
              ),
            ],
          ),
          titlePadding: const EdgeInsets.only(left: 72, bottom: 8),
        ),
        expandedHeight: MediaQuery.of(context).size.height * 0.5,
        pinned: true,
      );
    } else {
      return SliverAppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.album.title ?? widget.album.id,
              style: Theme.of(context).textTheme.headline6,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            Text(
              '${widget.album.mediaItemsCount ?? '-'} items',
              style: Theme.of(context).textTheme.caption,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
        actions: [
          if (widget.album.productUrl != null)
            AlbumOpenInGooglePhotosIconButton(
              album: widget.album,
            ),
        ],
        pinned: true,
      );
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final coverPhotoMediaItemId = widget.album.coverPhotoMediaItemId;
    if (coverPhotoMediaItemId != null) {
      _future = MediaItemServiceScope.of(context).get(coverPhotoMediaItemId);
    }
  }
}
