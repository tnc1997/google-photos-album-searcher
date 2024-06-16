extension StringExtensions on String {
  String uglify() {
    return toLowerCase().replaceAll(RegExp(r'\W'), '');
  }
}
