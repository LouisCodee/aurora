/// Base class for all Use Cases with no parameters
abstract class UseCase<T, Params> {
  Future<T> call(Params params);
}

/// Used when a use case takes no parameters
class NoParams {}
