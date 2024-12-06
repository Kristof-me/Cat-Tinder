// ignore_for_file: avoid_print

// using code from: https://petercoding.com/firebase/2022/03/28/using-firebase-with-bloc-pattern-in-flutter/
import 'package:bloc/bloc.dart';
 
class AppBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print('onEvent $event');
  }
 
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('onChange $change');
  }
 
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('onTransition $transition');
  }
 
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('onError (${bloc.runtimeType}) $error');
    super.onError(bloc, error, stackTrace);
  }
}