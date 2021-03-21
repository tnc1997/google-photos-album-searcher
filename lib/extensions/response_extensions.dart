import 'package:http/http.dart';

extension ResponseExtensions on Response {
  bool get isSuccessStatusCode => statusCode >= 200 && statusCode < 300;
}
