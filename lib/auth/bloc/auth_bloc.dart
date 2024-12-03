import 'package:cat_tinder/auth/auth_repository.dart';
import 'package:cat_tinder/auth/bloc/auth_event.dart';
import 'package:cat_tinder/auth/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthenticationRepository authRepo) : authRepository = authRepo, super(NoUser()) {
    on<SignIn>((event, emit) async {
      UserInfo user = await authRepository.getCurrentUser().first;
      emit(user.uid != null ? SignedInUser(user) : AuthFailed());
    });

    on<SignUp>((event, emit) async {
      UserInfo user = await authRepository.getCurrentUser().first;
      emit(user.uid != null ? SignedInUser(user) : AuthFailed());
    });

    on<AuthError>((event, emit) => emit(ErrorForUser(event.errorCode, event.errorMessage)));

    on<SignOut>((event, emit) => emit(NoUser()));

    on<DeleteUser>((event, emit) => emit(NoUser()));
  }

  final AuthenticationRepository authRepository;
}