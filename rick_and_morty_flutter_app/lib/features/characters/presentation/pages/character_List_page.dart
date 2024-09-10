import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rick_and_morty_flutter_app/features/characters/presentation/bloc/app_theme/app_theme_cubit.dart';
import 'package:rick_and_morty_flutter_app/features/characters/presentation/widgets/character_list_container_widget.dart';
import '../bloc/character_bloc/character_bloc.dart';
import '../bloc/character_bloc/character_state.dart';

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
          //button that changes list view to grid view
          IconButton(onPressed: () {}, icon: FaIcon(FontAwesomeIcons.list))
        ],
      ),
      body: BlocBuilder<CharacterBloc, CharacterState>(
        builder: (context, characterState) {
          if (characterState is CharacterLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (characterState is CharacterLoaded) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.builder(
                itemCount: characterState.characters.length,
                itemBuilder: (BuildContext context, int index) {
                  final character = characterState.characters[index];
                  return CharacterListContainerWidget(character: character);
                },
              ),
            );
          } else if (characterState is CharacterError) {
            return Center(child: Text('Error: ${characterState.message}',       overflow: TextOverflow.ellipsis,
));
          } else {
            return Center(
                child: Text('No data available')); // Default fallback widget
          }
        },
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
