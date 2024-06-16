import 'dart:async';

import 'package:flutter/foundation.dart';

class StreamNotifier<T> extends ChangeNotifier implements ValueListenable<T> {
  StreamNotifier({
    required Stream<T> stream,
    required T initialValue,
  }) : _value = initialValue {
    _subscription = stream.listen(
      (value) {
        if (_value != value) {
          _value = value;
          notifyListeners();
        }
      },
    );
  }

  T _value;

  StreamSubscription<T>? _subscription;

  @override
  T get value {
    return _value;
  }

  @override
  Future<void> dispose() async {
    await _subscription?.cancel();
    super.dispose();
  }
}
