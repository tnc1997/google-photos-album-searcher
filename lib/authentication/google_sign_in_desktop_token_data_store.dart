import 'dart:convert';
import 'dart:io';

import 'package:google_sign_in_desktop/google_sign_in_desktop.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class GoogleSignInDesktopTokenDataStore
    implements GoogleSignInDesktopStore<GoogleSignInDesktopTokenData> {
  static const _basename = 'tokens.json';

  const GoogleSignInDesktopTokenDataStore();

  @override
  Future<GoogleSignInDesktopTokenData?> get() async {
    final directory = await getApplicationSupportDirectory();

    final file = File(join(directory.path, _basename));
    if (!await file.exists()) {
      return null;
    }

    final text = await file.readAsString();
    if (text.isEmpty) {
      return null;
    }

    return GoogleSignInDesktopTokenData.fromJson(json.decode(text));
  }

  @override
  Future<void> set(GoogleSignInDesktopTokenData? value) async {
    final directory = await getApplicationSupportDirectory();

    final file = File(join(directory.path, _basename));
    if (!await file.exists()) {
      await file.create();
    }

    if (value != null) {
      await file.writeAsString(json.encode(value));
    } else {
      await file.delete();
    }
  }
}
