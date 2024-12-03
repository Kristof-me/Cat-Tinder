import 'package:cat_tinder/auth/auth_repository.dart';
import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class NoUser extends AuthState {}
class LoadingUser extends AuthState {}

class ErrorForUser extends AuthState {
  ErrorForUser(this.errorCode, this.errorMessage);
  final String errorCode;
  final String errorMessage;
}

class SignedInUser extends AuthState {
  SignedInUser(this.user);
  final UserInfo user;

  @override
  List<Object?> get props => [user];
}

class AuthFailed extends AuthState {}