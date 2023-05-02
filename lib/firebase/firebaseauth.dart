import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseAuthProvider = Provider<MyFirebaseAuth>((ref) {
  return MyFirebaseAuth();
});

class MyFirebaseAuth {
  Future<String?> getUserName() async {
    final user = await FirebaseAuth.instance.currentUser;
    try {
      return user?.displayName;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}
