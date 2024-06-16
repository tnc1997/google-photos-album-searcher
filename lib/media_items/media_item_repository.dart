import 'package:googleapis/photoslibrary/v1.dart';

import '../common/paginator.dart';

class MediaItemRepository {
  final PhotosLibraryApi _photosLibraryApi;

  const MediaItemRepository({
    required PhotosLibraryApi photosLibraryApi,
  }) : _photosLibraryApi = photosLibraryApi;

  Future<MediaItem?> get(String mediaItemId) async {
    try {
      return await _photosLibraryApi.mediaItems.get(mediaItemId);
    } catch (e) {
      // ignored because null is returned when the media item is not found
    }

    return null;
  }

  Future<List<MediaItem>> search(String albumId) async {
    return await paginator<MediaItem, SearchMediaItemsResponse>(
      (pageToken) {
        return _photosLibraryApi.mediaItems.search(
          SearchMediaItemsRequest(
            albumId: albumId,
            pageToken: pageToken,
          ),
        );
      },
      (response) {
        return response.nextPageToken;
      },
      (response) {
        return response.mediaItems;
      },
    ).expand((albums) {
      return albums;
    }).toList();
  }
}
