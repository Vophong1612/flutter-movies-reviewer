sealed class APIResult<T> {
  const APIResult();
}

final class APISuccess<T> extends APIResult<T> {
  const APISuccess(this.value);
  final T value;
}

final class APIFailure<T> extends APIResult<T> {
  const APIFailure(this.exception);
  final Exception exception;
}