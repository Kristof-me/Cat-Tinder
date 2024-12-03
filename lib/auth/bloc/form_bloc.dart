import 'package:cat_tinder/auth/auth_repository.dart';
import 'package:cat_tinder/auth/bloc/form_event.dart';
import 'package:cat_tinder/auth/bloc/form_validation.dart';
import 'package:cat_tinder/data_access/user_informaiton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cat_tinder/auth/bloc/form_state.dart';

class AuthFormBloc extends Bloc<AuthFormEvent, AuthFormState> with FormValidation {
  AuthFormBloc(this._authRepository) : super(AuthFormState()) {
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
      if (state.emailError != null || state.passwordError != null) {
        return;
      }

      emit(state.copyWith(isLoading: true));

      try {
        UserInformation? user;

        if (event.isSignIn) {
          user = await _authRepository.signIn(state.email, state.password);
        } else {
          user = await _authRepository.signUp(state.email, state.password);
        }

        if (user == null) {
          emit(state.copyWith(isLoading: false, emailError: 'An error occurred. Please try again.'));
          return;
        }
        
        if(user.isVerified == false) {
          emit(state.copyWith(isLoading: false, emailError: 'Please verify your email address by clicking the link sent to you'));
        }

        emit(state.copyWith(isLoading: false, isSuccessful: true));
      } on FirebaseAuthException catch (error) {
        emit(state.copyWith( isLoading: false, emailError: '${error.message} (${error.code})' ));  
      }
    });
  }

  String? getEmailError(String email) {
    return isValidEmail(email) ? null : 'Invalid email address';
  }

  String? getPasswordError(String password) {
    return isValidPassword(password) ? null : 'Password must be at least 6 characters';
  }

  final AuthenticationRepository _authRepository;
}
