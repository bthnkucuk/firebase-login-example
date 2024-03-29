import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userProvider =
    ChangeNotifierProvider<UserController>((ref) => UserController());

class UserController with ChangeNotifier {
  User? user;

  UserController() {
    listenUser();
  }

  void listenUser() async {
    FirebaseAuth.instance.userChanges().listen((User? firebaseUser) {
      user = firebaseUser;
      if (user == null) {
        // TODO
        if (kDebugMode) {
          print('user is null');
        }
      } else {
        if (kDebugMode) {
          print('user ${user?.email}');
        }
      }

      notifyListeners();
    });
  }
}
