import 'package:equatable/equatable.dart';

class ScreenState<T> extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState<T> extends ScreenState<T> {}

class LoadingState<T> extends ScreenState<T> {}

class SuccessState<T> extends ScreenState<T> {
  final T data;
  SuccessState({required this.data});

  @override
  List<Object?> get props => [data];
}

class ErrorState<T> extends ScreenState<T> {
  final String message;
  final StackTrace? stackTrace;
  ErrorState({required this.message, this.stackTrace});

  @override
  List<Object?> get props => [message];
}
