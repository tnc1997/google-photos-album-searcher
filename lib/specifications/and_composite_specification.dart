import 'package:album_searcher_for_google_photos/specifications/composite_specification.dart';
import 'package:album_searcher_for_google_photos/specifications/specification.dart';

class AndCompositeSpecification<T> extends CompositeSpecification<T> {
  AndCompositeSpecification({
    required Specification<T> left,
    required Specification<T> right,
  }) : super(
          left: left,
          right: right,
        );

  @override
  bool isSatisfiedBy(T value) {
    return left.isSatisfiedBy(value) && right.isSatisfiedBy(value);
  }
}
