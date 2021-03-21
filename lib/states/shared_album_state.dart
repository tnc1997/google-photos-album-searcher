import 'package:album_searcher_for_google_photos/models/album.dart';
import 'package:flutter/material.dart';

class SharedAlbumState extends InheritedNotifier<SharedAlbumStateData> {
  const SharedAlbumState({
    Key? key,
    required SharedAlbumStateData notifier,
    required Widget child,
  }) : super(
          key: key,
          notifier: notifier,
          child: child,
        );

  static SharedAlbumStateData of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<SharedAlbumState>()!
        .notifier!;
  }
}

class SharedAlbumStateData extends ChangeNotifier {
  List<Album>? _sharedAlbums;

  SharedAlbumStateData({
    List<Album>? sharedAlbums,
  }) : _sharedAlbums = sharedAlbums;

  List<Album>? get sharedAlbums => _sharedAlbums;

  set sharedAlbums(List<Album>? sharedAlbums) {
    if (sharedAlbums != _sharedAlbums) {
      _sharedAlbums = sharedAlbums;
      notifyListeners();
    }
  }
}
