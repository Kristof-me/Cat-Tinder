import 'package:cat_tinder/auth/auth_repository.dart';
import 'package:cat_tinder/auth/bloc/auth_event.dart';
import 'package:cat_tinder/auth/bloc/auth_state.dart';
import 'package:cat_tinder/data_access/user_informaiton.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this.authRepository) : super(InitialState()) {
    on<Initialize>((event, emit) async {
      UserInformation user = await authRepository.getCurrentUser().first; 
      emit(user.uid != null ? SignedInUser(user) : NoUser());
    });

    // To initialize the state
    add(Initialize());

    on<SignIn>((event, emit) async {
      UserInformation user = await authRepository.getCurrentUser().first;
      emit(user.uid != null ? SignedInUser(user) : AuthFailed());
    });

    on<SignUp>((event, emit) async {
      UserInformation user = await authRepository.getCurrentUser().first;
      emit(user.uid != null ? SignedInUser(user) : AuthFailed());
    });

    on<AuthError>((event, emit) => emit(ErrorForUser(event.errorCode, event.errorMessage)));

    on<SignOut>((event, emit) => emit(NoUser()));

    on<DeleteUser>((event, emit) => emit(NoUser()));
  }

  final AuthenticationRepository authRepository;
}