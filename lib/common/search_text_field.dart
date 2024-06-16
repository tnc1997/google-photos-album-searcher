import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key,
    this.onChanged,
  });

  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        hintText: 'Search',
        prefixIcon: Icon(Icons.search),
      ),
      autofocus: true,
      onChanged: onChanged,
    );
  }
}
