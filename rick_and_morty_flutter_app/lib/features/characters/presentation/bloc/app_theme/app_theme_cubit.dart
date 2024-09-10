import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:rick_and_morty_flutter_app/theme/theme.dart';


class AppThemeCubit extends Cubit<ThemeData> {
  AppThemeCubit() : super(lightMode);

  void toggleTheme() {
    if (state.brightness == Brightness.dark) {
      emit(lightMode);
    } else {
      emit(darkMode);
    }
  }

}
