import 'package:cat_tinder/auth/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cat_tinder/auth/bloc/form_state.dart';

class FormCubit extends Cubit<AuthFormState> {
  FormCubit() : super(AuthFormState()); 
  // TextEditingControl placed here, based on: https://github.com/felangel/bloc/issues/2293
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? isEmailValid(String email) {
    if(RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      return null;
    }

    return 'Invalid email address';
  }
  
  void emailChanged(String value) {
    emit(state.copyWith(email: value, emailError: isEmailValid(value)));
  }

  String? isPasswordValid(String password) {
    if (password.length >= 6) {
      return null;
    }

    return 'Password must be at least 6 characters long';
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: value, passwordError: isPasswordValid(value)));
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(passwordVisibility: !state.passwordVisibility));
  }

  void onSubmit(AuthenticationRepository authRepository) {
    // TODO on submit action
  }
}
