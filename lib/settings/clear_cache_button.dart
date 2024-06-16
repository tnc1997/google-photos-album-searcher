import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/cache_service.dart';

class ClearCacheButton extends StatelessWidget {
  const ClearCacheButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () async {
        await context.read<CacheService>().clear();
      },
      icon: const Icon(Icons.refresh),
      label: const Text('CLEAR CACHE'),
    );
  }
}
