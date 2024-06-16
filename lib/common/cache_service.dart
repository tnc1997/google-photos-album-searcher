import 'cache_service_stub.dart'
    if (dart.library.io) 'cache_service_io.dart'
    if (dart.library.js_interop) 'cache_service_web.dart';

abstract interface class CacheService {
  factory CacheService() {
    return createCacheService();
  }

  Future<void> clear();

  Future<String?> get(String key);

  Future<void> set(String key, String? value);
}
