import 'package:album_searcher_for_google_photos/specifications/and_composite_specification.dart';
import 'package:album_searcher_for_google_photos/specifications/or_composite_specification.dart';

abstract class Specification<T> {
  const Specification();

  factory Specification.falsy() => _FalsySpecification<T>();

  factory Specification.truthy() => _TruthySpecification<T>();

  Specification<T> operator &(Specification<T> specification) {
    return and(specification);
  }

  Specification<T> operator |(Specification<T> specification) {
    return or(specification);
  }

  Specification<T> and(Specification<T> specification) {
    return AndCompositeSpecification(
      left: this,
      right: specification,
    );
  }

  bool isSatisfiedBy(T value);

  Specification<T> or(Specification<T> specification) {
    return OrCompositeSpecification(
      left: this,
      right: specification,
    );
  }
}

class _FalsySpecification<T> extends Specification<T> {
  const _FalsySpecification();

  @override
  bool isSatisfiedBy(T value) {
    return false;
  }
}

class _TruthySpecification<T> extends Specification<T> {
  const _TruthySpecification();

  @override
  bool isSatisfiedBy(T value) {
    return true;
  }
}
