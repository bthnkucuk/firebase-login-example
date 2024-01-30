import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HobbyService {
  Future<void> add(User user, String hobby) async {
    if (FirebaseAuth.instance.currentUser?.uid == null) {
      return;
    }
    DocumentSnapshot<Map<String, dynamic>>? snapShot;
    try {
      snapShot = await FirebaseFirestore.instance
          .collection('hobbies')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get();
    } catch (_) {}

    List<dynamic> hobbies = snapShot?.data()?['user_hobbies'] ?? [];
    hobbies.add(hobby);

    hobbies = hobbies.toSet().toList();

    await FirebaseFirestore.instance
        .collection('hobbies')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set({'user_hobbies': hobbies});
  }

  Future<void> remove(User user, String hobby) async {
    if (FirebaseAuth.instance.currentUser?.uid == null) {
      return;
    }
    final snapShot = await FirebaseFirestore.instance
        .collection('hobbies')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();

    final List<dynamic> hobbies = snapShot.data()?['user_hobbies'] ?? [];
    hobbies.removeWhere((element) => element == hobby);

    await FirebaseFirestore.instance
        .collection('hobbies')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .update({'user_hobbies': hobbies});
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> listen() {
    return FirebaseFirestore.instance
        .collection('hobbies')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .snapshots();
  }
}
