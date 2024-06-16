import 'dart:collection';

import 'package:googleapis/photoslibrary/v1.dart';

import '../common/paginator.dart';

class AlbumRepository {
  final PhotosLibraryApi _photosLibraryApi;

  const AlbumRepository({
    required PhotosLibraryApi photosLibraryApi,
  }) : _photosLibraryApi = photosLibraryApi;

  Future<Album?> get(String albumId) async {
    try {
      return await _photosLibraryApi.albums.get(albumId);
    } catch (e) {
      // ignored because the identifier could be for a shared album
    }

    try {
      return await _photosLibraryApi.sharedAlbums.get(albumId);
    } catch (e) {
      // ignored because null is returned when the album is not found
    }

    return null;
  }

  Future<List<Album>> list() async {
    final albums = HashSet<Album>(
      equals: (a, b) {
        return a.id == b.id;
      },
      hashCode: (a) {
        return a.id.hashCode;
      },
    );

    albums.addAll(
      await paginator<Album, ListAlbumsResponse>(
        (pageToken) {
          return _photosLibraryApi.albums.list(pageToken: pageToken);
        },
        (response) {
          return response.nextPageToken;
        },
        (response) {
          return response.albums;
        },
      ).expand((albums) {
        return albums;
      }).toList(),
    );

    albums.addAll(
      await paginator<Album, ListSharedAlbumsResponse>(
        (pageToken) {
          return _photosLibraryApi.sharedAlbums.list(pageToken: pageToken);
        },
        (response) {
          return response.nextPageToken;
        },
        (response) {
          return response.sharedAlbums;
        },
      ).expand((albums) {
        return albums;
      }).toList(),
    );

    return albums.toList();
  }
}
