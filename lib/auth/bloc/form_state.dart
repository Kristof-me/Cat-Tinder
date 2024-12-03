import 'package:flutter/material.dart';

class AuthFormState {
  final AutovalidateMode autovalidateMode;
  final String email;
  final String emailError;
  final String password;
  final String passwordError;
  final bool passwordVisibility;

  AuthFormState({
    this.autovalidateMode = AutovalidateMode.disabled,
    this.email = '',
    this.emailError = '',
    this.password = '',
    this.passwordError = '',
    this.passwordVisibility = false,
  });

  AuthFormState copyWith({
    AutovalidateMode? autovalidateMode,
    String? email,
    String? emailError,
    String? password,
    String? passwordError,
    bool? passwordVisibility,
  }) {
    return AuthFormState(
      autovalidateMode: autovalidateMode ?? this.autovalidateMode,
      email: email ?? this.email,
      emailError: emailError ?? this.emailError,
      password: password ?? this.password,
      passwordError: passwordError ?? this.passwordError,
      passwordVisibility: passwordVisibility ?? this.passwordVisibility,
    );
  }
}
