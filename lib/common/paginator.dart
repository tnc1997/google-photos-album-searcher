Stream<List<E>> paginator<E, T>(
  Future<T> Function(String? pageToken) response,
  String? Function(T response) nextPageToken,
  List<E>? Function(T response) values,
) async* {
  String? pageToken_;

  do {
    final response_ = await response(pageToken_);

    if (values(response_) case final values_?) {
      yield values_;
    }

    pageToken_ = nextPageToken(response_);
  } while (pageToken_ != null);
}
