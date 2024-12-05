import 'dart:developer';

import 'package:cat_tinder/data_access/firebase_auth_service.dart';
import 'package:cat_tinder/data_access/user_informaiton.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationRepository {
  Stream<UserInformation> getCurrentUser();
  Future<UserInformation?> signUp(String email, String password);
  Future<UserInformation?> signIn(String email, String password);
  Future<void> signOut();
  Future<void> deleteUser();
  Future<void> sendPasswordResetEmail(String email);
  Future<void> setDisplayName(String displayName);
}

class FlutterAuthRepository implements AuthenticationRepository {
  final FirebaseAuthService _authService = FirebaseAuthService();

  @override
  Stream<UserInformation> getCurrentUser() {
    return _authService.currentUser()
      .handleError((error) { log(error.toString()); })
      .map((user) => UserInformation.fromUser(user));
  }

  @override
  Future<UserInformation?> signIn(String email, String password) async {
    UserCredential? credential = await _authService.signIn(email, password);
    return credential != null ? UserInformation.fromUser(credential.user!) : null;
  }

  @override
  Future<UserInformation?> signUp(String email, String password) async {
    UserCredential? credential = await _authService.signUp(email, password);
    return credential != null ? UserInformation.fromUser(credential.user!) : null;
  }

  @override
  Future<void> signOut() {
    return _authService.signOut();
  }

  @override
  Future<void> deleteUser() {
    return _authService.deleteUser();
  }

  @override
  Future<void> sendPasswordResetEmail(String email) {
    return _authService.sendPasswordResetEmail(email);
  }

  @override
  Future<void> setDisplayName(String displayName) {
    return _authService.setDisplayName(displayName);
  }
}
