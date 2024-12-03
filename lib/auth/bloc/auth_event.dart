import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignUp extends AuthEvent {}
class SignIn extends AuthEvent {}
class SignOut extends AuthEvent {}
class DeleteUser extends AuthEvent {}

class AuthError extends AuthEvent {
   AuthError(this.errorCode, this.errorMessage);
  final String errorCode;
  final String errorMessage;
}