import 'package:equatable/equatable.dart';

abstract class AuthFormEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class EmailChanged extends AuthFormEvent {
  EmailChanged(this.email);
  final String email;

  @override
  List<Object?> get props => [email];
}

class PasswordChanged extends AuthFormEvent {
  PasswordChanged(this.password);
  final String password;

  @override
  List<Object?> get props => [password];
}

class TogglePasswordVisibility extends AuthFormEvent {}

class FormSubmitted extends AuthFormEvent {
  FormSubmitted({required this.isSignIn});
  final  bool isSignIn;

  @override
  List<Object?> get props => [isSignIn];
}

class FormReset extends AuthFormEvent {}
