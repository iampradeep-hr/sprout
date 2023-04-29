import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';


final firebaseAuthProvider = Provider<MyFirebaseAuth>((ref) {
  return MyFirebaseAuth();
});


class MyFirebaseAuth {
  GoogleSignInAccount? _cachedAccount;

  Future<String?> getUserName() async {
    try {
      if (_cachedAccount == null) {
        _cachedAccount = await GoogleSignIn().signIn();
      }
      if (_cachedAccount != null) {
        return _cachedAccount!.displayName;
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}

