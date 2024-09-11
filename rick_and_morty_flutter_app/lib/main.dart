import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_flutter_app/dependency_injection.dart';
import 'package:rick_and_morty_flutter_app/features/characters/domain/usecases/character_usecase.dart';
import 'package:rick_and_morty_flutter_app/features/characters/presentation/bloc/app_theme/app_theme_cubit.dart';
import 'package:rick_and_morty_flutter_app/features/characters/presentation/bloc/character_bloc/character_bloc.dart';
import 'package:rick_and_morty_flutter_app/features/characters/presentation/bloc/views/view_cubit.dart';
import 'package:rick_and_morty_flutter_app/features/characters/presentation/pages/character_list_page.dart';

import 'features/characters/presentation/bloc/character_bloc/character_event.dart';

void main() {
  setup();  // Ensure this function initializes dependencies
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<AppThemeCubit>()),
        BlocProvider(create: (context) => getIt<ViewCubit>()), // Add this line
      ],
      child: BlocBuilder<AppThemeCubit, ThemeData>(
        builder: (context, themeData) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: themeData,
            home: BlocProvider(
              create: (_) =>
                  CharacterBloc(characterUsecase: getIt<CharacterUsecase>())
                    ..add(FetchCharacters()),  // Trigger the event here
              child: CharacterListPage(),
            ),
          );
        },
      ),
    );
  }
}
