import 'package:cat_tinder/data_access/firebase_auth_service.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserInfo extends Equatable {
  const UserInfo({this.uid, this.email, this.displayName});

  UserInfo.fromUser(User user)
      : uid = user.uid,
        email = user.email,
        displayName = user.displayName;

  final String? uid;
  final String? email;
  final String? displayName;

  String? getDisplayedName() {
    return displayName ?? email;
  }

  @override
  List<Object?> get props => [ uid, email, displayName ];
}

abstract class AuthenticationRepository {
  Stream<UserInfo> getCurrentUser();
  Future<UserInfo?> signUp(String email, String password);
  Future<UserInfo?> signIn(String email, String password);
  Future<void> signOut();
  Future<void> deleteUser();
  Future<void> sendPasswordResetEmail(String email);
  Future<void> setDisplayName(String displayName);
}

class FlutterAuthRepository implements AuthenticationRepository {
  final FirebaseAuthService _authService = FirebaseAuthService();

  @override
  Stream<UserInfo> getCurrentUser() {
    return _authService.currentUser().map((user) => UserInfo.fromUser(user!));
  }

  @override
  Future<UserInfo?> signIn(String email, String password) async {
    UserCredential? credential = await _authService.signIn(email, password);
    return credential != null ? UserInfo.fromUser(credential.user!) : null;
  }

  @override
  Future<UserInfo?> signUp(String email, String password) async {
    UserCredential? credential = await _authService.signUp(email, password);
    return credential != null ? UserInfo.fromUser(credential.user!) : null;
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
