import 'package:firebase_auth/firebase_auth.dart';
import '/core/exception/app_exceptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/features/auth/model/register_request_model.dart';
import '/features/auth/model/sign_in_request_model.dart';
import '/features/auth/model/user_credential_with_bio_and_birth.dart';

class AuthService {
  const AuthService();

  Future<UserCredential> login(SignInRequestModel model) async {
    try {
      return await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: model.email, password: model.password);
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

  Future<UserCredentialWithBioAndBirthDate> register(
      RegisterRequestModel model) async {
    try {
      return await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: model.email, password: model.password)
          .then((firebaseUser) async {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(firebaseUser.user!.uid)
            .set({
          'fullName': model.fullName,
          'email': model.email,
          'biography': model.biography,
          'birthDate': model.birthDate.millisecondsSinceEpoch,
        });
        return UserCredentialWithBioAndBirthDate(
          userCredential: firebaseUser,
          bio: model.biography,
          birthDate: model.birthDate,
        );
      });
    } catch (error) {
      if (error is FirebaseAuthException) {
        throw AuthException(error.message ?? 'Something went wrong!');
      }

      throw UnknownAppException();
    }
  }
}
