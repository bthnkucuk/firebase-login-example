import 'package:firebase_auth/firebase_auth.dart';

class UserCredentialWithBioAndBirthDate {
  final UserCredential userCredential;
  final String? bio;
  final DateTime? birthDate;

  UserCredentialWithBioAndBirthDate({
    required this.userCredential,
    required this.bio,
    required this.birthDate,
  });
}
