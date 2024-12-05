import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeModeCubit extends Cubit<ThemeMode> {
  ThemeModeCubit() : super(ThemeMode.system);

  //void setMode(ThemeMode mode) => emit(mode);

  void step() {
    if(state == ThemeMode.system) {
      emit(ThemeMode.light);
    } else if(state == ThemeMode.light) {
      emit(ThemeMode.dark);
    } else {
      emit(ThemeMode.system);
    }
  }
}