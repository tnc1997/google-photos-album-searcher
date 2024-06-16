import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OpenInGooglePhotosIconButton extends StatelessWidget {
  const OpenInGooglePhotosIconButton({
    super.key,
    required this.productUrl,
  });

  final String productUrl;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        await launchUrl(
          Uri.parse(productUrl),
          webOnlyWindowName: '_blank',
        );
      },
      tooltip: 'Open in Google Photos',
      icon: const Icon(Icons.open_in_new),
    );
  }
}
