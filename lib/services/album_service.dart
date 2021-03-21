import 'dart:convert';

import 'package:album_searcher_for_google_photos/extensions/response_extensions.dart';
import 'package:album_searcher_for_google_photos/models/album.dart';
import 'package:album_searcher_for_google_photos/states/authentication_state.dart';
import 'package:flutter/widgets.dart';

class AlbumServiceScope extends InheritedWidget {
  final AlbumService service;

  const AlbumServiceScope({
    Key? key,
    required this.service,
    required Widget child,
  }) : super(
          key: key,
          child: child,
        );

  static AlbumService of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<AlbumServiceScope>()!
        .service;
  }

  @override
  bool updateShouldNotify(covariant AlbumServiceScope oldWidget) {
    return oldWidget.service != service;
  }
}

class AlbumService {
  final AuthenticationStateData _authenticationStateData;

  AlbumService({
    required AuthenticationStateData authenticationStateData,
  }) : _authenticationStateData = authenticationStateData;

  Future<Album> get(String id) async {
    final uri = Uri.https(
      'photoslibrary.googleapis.com',
      '/v1/albums/$id',
    );

    final response = await _authenticationStateData.client!.get(uri);

    if (!response.isSuccessStatusCode) {
      throw Exception(response.body);
    }

    return Album.fromJson(json.decode(response.body));
  }
}
