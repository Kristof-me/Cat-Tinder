import 'package:cat_tinder/data_access/user_informaiton.dart';
import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends AuthState {}
class NoUser extends AuthState {}
class LoadingUser extends AuthState {}

class ErrorForUser extends AuthState {
  ErrorForUser(this.errorCode, this.errorMessage);
  final String errorCode;
  final String errorMessage;
}

class SignedInUser extends AuthState {
  SignedInUser(this.user);
  final UserInformation user;

  @override
  List<Object?> get props => [user];
}

class AuthFailed extends AuthState {}