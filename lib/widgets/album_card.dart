import 'package:album_searcher_for_google_photos/models/album.dart';
import 'package:album_searcher_for_google_photos/models/media_item.dart';
import 'package:album_searcher_for_google_photos/services/media_item_service.dart';
import 'package:album_searcher_for_google_photos/states/router_state.dart';
import 'package:flutter/material.dart';

class AlbumCard extends StatefulWidget {
  final Album album;

  const AlbumCard({
    Key? key,
    required this.album,
  }) : super(key: key);

  @override
  _AlbumCardState createState() => _AlbumCardState();
}

class _AlbumCardState extends State<AlbumCard> {
  Future<MediaItem>? _future;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      margin: EdgeInsets.zero,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Stack(
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
            Positioned(
              left: 16,
              right: 16,
              bottom: 16,
              child: Text(
                widget.album.title ?? widget.album.id,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: Colors.white),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    RouterState.of(context).selectedAlbum = widget.album.id;
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
