// ignore_for_file: avoid_init_to_null

import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class AuthFormState extends Equatable {
  final String email;
  final String? emailError;
  final String password;
  final String? passwordError;
  final bool showPassword;
  final bool isLoading;
  final bool isSuccessful;

  const AuthFormState({
    this.email = '',
    this.emailError = null,
    this.password = '',
    this.passwordError = null,
    this.showPassword = false,
    this.isLoading = false,
    this.isSuccessful = false,
  });

  AuthFormState copyWith({
    AutovalidateMode? autovalidateMode,
    String? email,
    String? emailError,
    String? password,
    String? passwordError,
    bool? showPassword,
    bool? isLoading,
    bool? isSuccessful,
  }) {
    return AuthFormState(
      email: email ?? this.email,
      emailError: emailError,
      password: password ?? this.password,
      passwordError: passwordError,
      showPassword: showPassword ?? this.showPassword,
      isLoading: isLoading ?? this.isLoading,
      isSuccessful: isSuccessful ?? this.isSuccessful,
    );
  }

  @override
  List<Object> get props => [
    email,
    emailError ?? '',
    password,
    passwordError ?? '',
    showPassword,
    isLoading,
    isSuccessful,
  ];
}
