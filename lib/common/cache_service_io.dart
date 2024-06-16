import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'cache_service.dart';

CacheService createCacheService() {
  return const CacheServiceIo();
}

class CacheServiceIo implements CacheService {
  const CacheServiceIo();

  @override
  Future<void> clear() async {
    final directory = await _getDirectory();

    await for (final entity in directory.list()) {
      if (entity is File) {
        await entity.delete();
      }
    }
  }

  @override
  Future<String?> get(String key) async {
    final file = await _getFile(key);
    if (!await file.exists()) {
      return null;
    }

    final text = await file.readAsString();
    if (text.isEmpty) {
      return null;
    }

    return text;
  }

  @override
  Future<void> set(String key, String? value) async {
    final file = await _getFile(key);
    if (!await file.exists()) {
      await file.create();
    }

    if (value != null) {
      await file.writeAsString(value);
    } else {
      await file.delete();
    }
  }

  Future<Directory> _getDirectory() async {
    final parent = await getApplicationCacheDirectory();
    await parent.create();

    final child = Directory(join(parent.path, 'cache'));
    await child.create();

    return child;
  }

  Future<File> _getFile(String key) async {
    final directory = await _getDirectory();
    return File(join(directory.path, key));
  }
}
