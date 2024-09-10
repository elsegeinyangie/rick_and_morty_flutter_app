import 'package:flutter/material.dart';
import 'package:rick_and_morty_flutter_app/dependency_injection.dart';
import 'package:rick_and_morty_flutter_app/features/characters/domain/usecases/character_usecase.dart';
import 'package:rick_and_morty_flutter_app/features/characters/presentation/bloc/app_theme/app_theme_cubit.dart';
import 'package:rick_and_morty_flutter_app/features/characters/presentation/bloc/character_bloc/character_bloc.dart';
import 'package:rick_and_morty_flutter_app/features/characters/presentation/pages/character_List_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  setup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AppThemeCubit>(),
    child: BlocBuilder<AppThemeCubit, ThemeData>(
        builder: (context, themeData) {
          return MaterialApp(
            theme: themeData,
            home: BlocProvider(
              create: (_) =>
                  CharacterBloc(characterUsecase: getIt<CharacterUsecase>())
                    ..add(FetchCharacter()),
              child: CharacterListPage(),
            ),
          );
        },
      ),
    );
  }
}
