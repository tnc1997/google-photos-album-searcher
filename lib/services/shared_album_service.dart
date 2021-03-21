import 'dart:convert';

import 'package:album_searcher_for_google_photos/extensions/response_extensions.dart';
import 'package:album_searcher_for_google_photos/models/album.dart';
import 'package:album_searcher_for_google_photos/services/storage_service.dart';
import 'package:album_searcher_for_google_photos/states/authentication_state.dart';
import 'package:album_searcher_for_google_photos/states/shared_album_state.dart';
import 'package:flutter/widgets.dart';

class SharedAlbumServiceScope extends InheritedWidget {
  final SharedAlbumService service;

  const SharedAlbumServiceScope({
    Key? key,
    required this.service,
    required Widget child,
  }) : super(
          key: key,
          child: child,
        );

  static SharedAlbumService of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<SharedAlbumServiceScope>()!
        .service;
  }

  @override
  bool updateShouldNotify(covariant SharedAlbumServiceScope oldWidget) {
    return oldWidget.service != service;
  }
}

class SharedAlbumService {
  final AuthenticationStateData _authenticationStateData;
  final SharedAlbumStateData _sharedAlbumStateData;
  final StorageService _storageService;

  SharedAlbumService({
    required AuthenticationStateData authenticationStateData,
    required SharedAlbumStateData sharedAlbumStateData,
    required StorageService storageService,
  })   : _authenticationStateData = authenticationStateData,
        _sharedAlbumStateData = sharedAlbumStateData,
        _storageService = storageService;

  Future<List<Album>> list() async {
    final sharedAlbums = <Album>[];

    final pageSize = 50;
    String? pageToken;

    do {
      final uri = Uri.https(
        'photoslibrary.googleapis.com',
        '/v1/sharedAlbums',
        {
          'pageSize': '$pageSize',
          if (pageToken != null) 'pageToken': pageToken,
        },
      );

      final response = await _authenticationStateData.client!.get(uri);

      if (!response.isSuccessStatusCode) {
        throw Exception(response.body);
      }

      final data = json.decode(response.body) as Map<String, dynamic>;
      sharedAlbums.addAll(
        (data['sharedAlbums'] as List).map((e) => Album.fromJson(e)),
      );
      pageToken = data['nextPageToken'];
    } while (pageToken != null);

    await _storageService.setSharedAlbums(sharedAlbums);

    return _sharedAlbumStateData.sharedAlbums = sharedAlbums;
  }
}
