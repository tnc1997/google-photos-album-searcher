import 'dart:convert';

import 'package:googleapis/photoslibrary/v1.dart';

import '../common/cache_service.dart';
import 'album_repository.dart';

class CachingAlbumRepository implements AlbumRepository {
  final AlbumRepository _inner;
  final CacheService _cacheService;

  const CachingAlbumRepository({
    required AlbumRepository inner,
    required CacheService cacheService,
  })  : _inner = inner,
        _cacheService = cacheService;

  @override
  Future<Album?> get(String albumId) async {
    try {
      if (await _cacheService._get() case final albums?) {
        return albums.where((album) {
          return album.id == albumId;
        }).singleOrNull;
      }
    } catch (e) {
      // ignored because the album is gotten from inner below
    }

    return await _inner.get(albumId);
  }

  @override
  Future<List<Album>> list() async {
    try {
      if (await _cacheService._get() case final albums?) {
        return albums;
      }
    } catch (e) {
      // ignored because the albums are listed from inner below
    }

    final albums = await _inner.list();

    try {
      await _cacheService._set(albums);
    } catch (e) {
      // ignored because we disregard cache set exceptions
    }

    return albums;
  }
}

extension _CacheServiceExtension on CacheService {
  static const _key = 'albums.json';

  Future<List<Album>?> _get() async {
    if (await get(_key) case final source?) {
      return (json.decode(source) as Iterable<dynamic>).map((json_) {
        return Album.fromJson(json_);
      }).toList();
    } else {
      return null;
    }
  }

  Future<void> _set(List<Album>? albums) async {
    await set(_key, albums != null ? json.encode(albums) : null);
  }
}
