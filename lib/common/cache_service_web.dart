import 'dart:js_interop';

import 'package:web/web.dart';

import 'cache_service.dart';

CacheService createCacheService() {
  return const CacheServiceWeb();
}

class CacheServiceWeb implements CacheService {
  const CacheServiceWeb();

  @override
  Future<void> clear() async {
    await set('albums.json', null);
  }

  @override
  Future<String?> get(String key) async {
    final handle = await _getFileHandle(key);
    final file = await handle.getFile().toDart;
    final text = await file.text().toDart;
    return text.toDart.isNotEmpty ? text.toDart : null;
  }

  @override
  Future<void> set(String key, String? value) async {
    final handle = await _getFileHandle(key);
    final writable = await handle.createWritable().toDart;

    try {
      if (value != null) {
        await writable.write(value.toJS).toDart;
      } else {
        await writable.truncate(0).toDart;
      }
    } finally {
      await writable.close().toDart;
    }
  }

  Future<FileSystemDirectoryHandle> _getDirectory() async {
    final directory = await window.navigator.storage.getDirectory().toDart;
    final options = FileSystemGetDirectoryOptions(create: true);
    return await directory.getDirectoryHandle('cache', options).toDart;
  }

  Future<FileSystemDirectoryHandle> _getDirectoryHandle(String name) async {
    final directory = await _getDirectory();
    final options = FileSystemGetDirectoryOptions(create: true);
    return await directory.getDirectoryHandle(name, options).toDart;
  }

  Future<FileSystemFileHandle> _getFileHandle(String name) async {
    final directory = await _getDirectory();
    final options = FileSystemGetFileOptions(create: true);
    return await directory.getFileHandle(name, options).toDart;
  }
}
