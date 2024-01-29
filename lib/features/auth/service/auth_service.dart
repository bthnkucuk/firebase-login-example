import 'package:firebase_auth/firebase_auth.dart';
import 'package:hero_games/core/exception/app_exceptions.dart';
import 'package:hero_games/core/toast/show_toast.dart';

class AuthService {
  const AuthService();

  Future<UserCredential> login(
    String email,
    String password,
  ) async {
    try {
      return await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } catch (error) {
      if (error is FirebaseAuthException) {
        var errorMessage = switch (error.code) {
          'INVALID_LOGIN_CREDENTIALS' => 'Email or password is wrong!',
          _ => 'Somerthing went wrong!'
        };

        throw AuthException(errorMessage);
      }

      throw UnknownAppException();
    }
  }
}
