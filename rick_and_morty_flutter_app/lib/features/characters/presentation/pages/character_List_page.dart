import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../bloc/app_theme/app_theme_cubit.dart';
import '../widgets/character_grid_container_widget.dart';
import '../bloc/character_bloc/character_bloc.dart';
import '../bloc/character_bloc/character_state.dart';
import '../bloc/views/view_cubit.dart';
import '../widgets/character_list_container_widget.dart';

class CharacterListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rick & Morty Characters'),
        actions: <Widget>[
          IconButton(
            icon: FaIcon(FontAwesomeIcons.sun),
            tooltip: 'Light/Dark Mode',
            onPressed: () {
              context.read<AppThemeCubit>().toggleTheme();
            },
          ),
          IconButton(
            icon: FaIcon(FontAwesomeIcons.list),
            tooltip: 'Toggle View',
            onPressed: () {
              context.read<ViewCubit>().toggleView();
            },
          ),
        ],
      ),
      body: BlocBuilder<CharacterBloc, CharacterState>(
        builder: (context, characterState) {
          if (characterState is CharacterLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (characterState is CharacterLoaded) {
            return BlocBuilder<ViewCubit, ViewType>(
              builder: (context, viewType) {
                if (viewType == ViewType.list) {
                  // List View
                  return ListView.builder(
                    padding: const EdgeInsets.all(10.0),
                    itemCount: characterState.characters.length,
                    itemBuilder: (BuildContext context, int index) {
                      final character = characterState.characters[index];
                      return CharacterListContainerWidget(character: character);
                    },
                  );
                } else {
                  // Grid View
                  return GridView.builder(
                    padding: const EdgeInsets.all(10.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 0.9, // Adjust as needed
                    ),
                    itemCount: characterState.characters.length,
                    itemBuilder: (BuildContext context, int index) {
                      final character = characterState.characters[index];
                      return CharacterGridContainerWidget(character: character);
                    },
                  );
                }
              },
            );
          } else if (characterState is CharacterError) {
            return Center(
              child: Text(
                'Error: ${characterState.message}',
                overflow: TextOverflow.ellipsis,
              ),
            );
          } else {
            return Center(
              child: Text('No data available'),
            );
          }
        },
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}