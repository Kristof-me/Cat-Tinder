import 'package:cat_tinder/auth/bloc/auth_bloc.dart';
import 'package:cat_tinder/auth/bloc/auth_event.dart';
import 'package:cat_tinder/auth/bloc/form_event.dart';
import 'package:cat_tinder/auth/bloc/form_validation.dart';
import 'package:cat_tinder/data_access/user_informaiton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cat_tinder/auth/bloc/form_state.dart';

class AuthFormBloc extends Bloc<AuthFormEvent, AuthFormState> with FormValidation {
  AuthFormBloc(this._authBloc) : super(AuthFormState()) {
    on<EmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email, emailError: getEmailError(event.email)));
    });

    on<PasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password, passwordError: getPasswordError(event.password)));
    });

    on<TogglePasswordVisibility>((event, emit) {
      emit(state.copyWith(showPassword: !state.showPassword));
    });

    on<FormReset>((event, emit) {
      emit(AuthFormState());
    });

    on<FormSubmitted>((event, emit) async {
      if (state.emailError != '' || state.passwordError != '') {
        return;
      }

      emit(state.copyWith(isLoading: true));

      try {
        UserInformation? user;

        if (event.isSignIn) {
          user = await _authBloc.authRepository.signIn(state.email, state.password);
          _authBloc.add(SignIn());
        } else {
          user = await _authBloc.authRepository.signUp(state.email, state.password);
          _authBloc.add(SignUp());
        }

        if (user == null) {
          emit(state.copyWith(isLoading: false, emailError: 'An error occurred. Please try again.'));
          return;
        }

        emit(state.copyWith(isLoading: false, isSuccessful: true));
      } on FirebaseAuthException catch (error) {
        emit(state.copyWith( isLoading: false, emailError: '${error.message} (${error.code})' ));  
      }
    });
  }

  String getEmailError(String email) {
    return isValidEmail(email) ? '' : 'Invalid email address';
  }

  String getPasswordError(String password) {
    return isValidPassword(password) ? '' : 'Password must be at least 6 characters';
  }

  final AuthBloc _authBloc;
}
