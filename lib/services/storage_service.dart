import 'dart:convert';

import 'package:album_searcher_for_google_photos/enums/layout_mode.dart';
import 'package:album_searcher_for_google_photos/models/album.dart';
import 'package:flutter/material.dart';
import 'package:oauth2/oauth2.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageServiceScope extends InheritedWidget {
  final StorageService service;

  const StorageServiceScope({
    Key? key,
    required this.service,
    required Widget child,
  }) : super(
          key: key,
          child: child,
        );

  static StorageService of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<StorageServiceScope>()!
        .service;
  }

  @override
  bool updateShouldNotify(covariant StorageServiceScope oldWidget) {
    return oldWidget.service != service;
  }
}

class StorageService {
  final _credentialsKey = 'credentials';
  final _layoutModeKey = 'layoutMode';
  final _sharedAlbumsKey = 'sharedAlbums';
  final _sharedPreferences = SharedPreferences.getInstance();
  final _themeModeKey = 'themeMode';

  Future<Credentials?> getCredentials() async {
    final string = (await _sharedPreferences).getString(_credentialsKey);

    return string != null ? Credentials.fromJson(string) : null;
  }

  Future<LayoutMode?> getLayoutMode() async {
    final int = (await _sharedPreferences).getInt(_layoutModeKey);

    return int != null ? LayoutMode.values[int] : null;
  }

  Future<List<Album>?> getSharedAlbums() async {
    final string = (await _sharedPreferences).getString(_sharedAlbumsKey);

    return string != null
        ? (json.decode(string) as List).map((e) => Album.fromJson(e)).toList()
        : null;
  }

  Future<ThemeMode?> getThemeMode() async {
    final int = (await _sharedPreferences).getInt(_themeModeKey);

    return int != null ? ThemeMode.values[int] : null;
  }

  Future<void> removeCredentials() async {
    await (await _sharedPreferences).remove(_credentialsKey);
  }

  Future<void> removeLayoutMode() async {
    await (await _sharedPreferences).remove(_layoutModeKey);
  }

  Future<void> removeSharedAlbums() async {
    await (await _sharedPreferences).remove(_sharedAlbumsKey);
  }

  Future<void> removeThemeMode() async {
    await (await _sharedPreferences).remove(_themeModeKey);
  }

  Future<void> setCredentials(Credentials credentials) async {
    await (await _sharedPreferences).setString(
      _credentialsKey,
      credentials.toJson(),
    );
  }

  Future<void> setLayoutMode(LayoutMode layoutMode) async {
    await (await _sharedPreferences).setInt(
      _layoutModeKey,
      layoutMode.index,
    );
  }

  Future<void> setSharedAlbums(List<Album> sharedAlbums) async {
    await (await _sharedPreferences).setString(
      _sharedAlbumsKey,
      json.encode(sharedAlbums),
    );
  }

  Future<void> setThemeMode(ThemeMode themeMode) async {
    await (await _sharedPreferences).setInt(
      _themeModeKey,
      themeMode.index,
    );
  }
}
