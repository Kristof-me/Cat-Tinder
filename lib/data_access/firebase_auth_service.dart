import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  FirebaseAuth auth = FirebaseAuth.instance;

  Stream<User?> currentUser() {
    return auth.authStateChanges().map((User? user) {
      return user;
    });
  }

  Future<UserCredential?> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      User? user = FirebaseAuth.instance.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
      }
      
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    }
  }

  Future<UserCredential?> signIn(String email, String password) async {
    try {
      return await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    }
  }

  Future<void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }

  Future<void> deleteUser() async {
    return await FirebaseAuth.instance.currentUser!.delete();
  }

  Future<void> sendPasswordResetEmail(String email) async {
    return await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  Future<void> setDisplayName(String displayName) async {
    return await FirebaseAuth.instance.currentUser!.updateDisplayName(displayName);
  }
}
