import 'package:flutter/material.dart';
import 'package:album_searcher_for_google_photos/models/album.dart';
import 'package:url_launcher/url_launcher.dart';

class AlbumOpenInGooglePhotosIconButton extends StatelessWidget {
  const AlbumOpenInGooglePhotosIconButton({
    Key? key,
    required this.album,
  }) : super(key: key);

  final Album album;

  @override
  Widget build(BuildContext context) {
    final productUrl = album.productUrl;

    return IconButton(
      icon: Icon(Icons.open_in_new),
      onPressed: productUrl != null
          ? () async {
              await launch(productUrl);
            }
          : null,
      tooltip: 'Open in Google Photos',
    );
  }
}
