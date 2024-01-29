class ScreenState<T> {}

class InitialState<T> extends ScreenState<T> {}

class LoadingState<T> extends ScreenState<T> {}

class SuccessState<T> extends ScreenState<T> {
  final T data;
  SuccessState({required this.data});
}

class ErrorState<T> extends ScreenState<T> {
  final String message;
  final StackTrace? stackTrace;
  ErrorState({required this.message, this.stackTrace});
}
