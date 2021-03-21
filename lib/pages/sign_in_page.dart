import 'package:album_searcher_for_google_photos/widgets/sign_in_elevated_button.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text('Welcome to Album Searcher for Google Photos'),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: SignInElevatedButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
