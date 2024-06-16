import 'package:flutter/material.dart';

class SliverSearchBarDelegate extends SliverPersistentHeaderDelegate {
  SliverSearchBarDelegate({
    this.minExtent = 86,
    this.maxExtent = 86,
    required this.child,
  });

  @override
  double minExtent;

  @override
  double maxExtent;

  final Widget child;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            inputDecorationTheme: const InputDecorationTheme(
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
            ),
          ),
          child: child,
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(SliverSearchBarDelegate oldDelegate) {
    return minExtent != oldDelegate.minExtent ||
        maxExtent != oldDelegate.maxExtent ||
        child != oldDelegate.child;
  }
}
