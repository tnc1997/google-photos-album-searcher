import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:http/retry.dart';

class AuthenticatingClient extends BaseClient {
  AuthenticatingClient({
    Client? inner,
    required GoogleSignIn googleSignIn,
  }) : _googleSignIn = googleSignIn {
    _inner = RetryClient(
      inner ?? Client(),
      retries: 1,
      when: (response) {
        return response.statusCode == 401;
      },
      onRetry: (request, response, retryCount) async {
        await _googleSignIn.currentUser?.clearAuthCache();

        _authentication = await _googleSignIn.currentUser?.authentication;

        if (_authentication?.accessToken case final accessToken?) {
          request.headers['authorization'] = 'Bearer $accessToken';
        }
      },
    );
  }

  late final Client _inner;
  final GoogleSignIn _googleSignIn;

  GoogleSignInAuthentication? _authentication;

  @override
  Future<StreamedResponse> send(BaseRequest request) async {
    _authentication ??= await _googleSignIn.currentUser?.authentication;

    if (_authentication?.accessToken case final accessToken?) {
      request.headers['authorization'] = 'Bearer $accessToken';
    }

    return await _inner.send(request);
  }
}
