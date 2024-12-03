import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserInformation extends Equatable {
  const UserInformation({this.uid, this.email, this.displayName, this.isVerified});

  UserInformation.fromUser(User user)
      : uid = user.uid,
        email = user.email,
        displayName = user.displayName,
        isVerified = user.emailVerified;

  final String? uid;
  final String? email;
  final String? displayName;
  final bool? isVerified;

  String? getDisplayedName() {
    return displayName ?? email;
  }

  @override
  List<Object?> get props => [ uid, email, displayName ];
}
