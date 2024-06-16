import 'cache_service.dart';

CacheService createCacheService() {
  return const CacheServiceStub();
}

class CacheServiceStub implements CacheService {
  const CacheServiceStub();

  @override
  Future<void> clear() {
    throw UnimplementedError();
  }

  @override
  Future<String?> get(String key) {
    throw UnimplementedError();
  }

  @override
  Future<void> set(String key, String? value) {
    throw UnimplementedError();
  }
}
