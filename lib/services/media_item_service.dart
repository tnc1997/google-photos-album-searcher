import 'dart:convert';
import 'dart:io';

import 'package:album_searcher_for_google_photos/extensions/response_extensions.dart';
import 'package:album_searcher_for_google_photos/models/media_item.dart';
import 'package:album_searcher_for_google_photos/states/authentication_state.dart';
import 'package:flutter/widgets.dart';

class MediaItemServiceScope extends InheritedWidget {
  final MediaItemService service;

  const MediaItemServiceScope({
    Key? key,
    required this.service,
    required Widget child,
  }) : super(
          key: key,
          child: child,
        );

  static MediaItemService of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<MediaItemServiceScope>()!
        .service;
  }

  @override
  bool updateShouldNotify(covariant MediaItemServiceScope oldWidget) {
    return oldWidget.service != service;
  }
}

class MediaItemService {
  final AuthenticationStateData _authenticationStateData;

  MediaItemService({
    required AuthenticationStateData authenticationStateData,
  }) : _authenticationStateData = authenticationStateData;

  Future<MediaItem> get(String id) async {
    final uri = Uri.https(
      'photoslibrary.googleapis.com',
      '/v1/mediaItems/$id',
    );

    final response = await _authenticationStateData.client!.get(uri);

    if (!response.isSuccessStatusCode) {
      throw Exception(response.body);
    }

    return MediaItem.fromJson(json.decode(response.body));
  }

  Future<List<MediaItem>> search(String albumId) async {
    final mediaItems = <MediaItem>[];

    final pageSize = 100;
    String? pageToken;

    do {
      final uri = Uri.https(
        'photoslibrary.googleapis.com',
        '/v1/mediaItems:search',
      );

      final response = await _authenticationStateData.client!.post(
        uri,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: json.encode({
          'albumId': albumId,
          'pageSize': pageSize,
          if (pageToken != null) 'pageToken': pageToken,
        }),
      );

      if (!response.isSuccessStatusCode) {
        throw Exception(response.body);
      }

      final data = json.decode(response.body) as Map<String, dynamic>;
      mediaItems.addAll(
        (data['mediaItems'] as List).map((e) => MediaItem.fromJson(e)),
      );
      pageToken = data['nextPageToken'];
    } while (pageToken != null);

    return mediaItems;
  }
}
