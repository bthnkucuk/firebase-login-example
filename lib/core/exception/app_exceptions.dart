abstract class AppException implements Exception {
  final String message;

  AppException(this.message);

  @override
  String toString() {
    return message;
  }
}

class AuthException extends AppException {
  AuthException(super.message);
}

class UnknownAppException extends AppException {
  UnknownAppException() : super('Somerthing went wrong!');
}
