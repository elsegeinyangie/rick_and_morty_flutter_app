import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rick_and_morty_flutter_app/features/characters/presentation/bloc/app_theme/app_theme_cubit.dart';
import '../bloc/character_bloc/character_bloc.dart';

class CharacterListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rick & Morty Characters'),
        actions: <Widget>[
          IconButton(
            icon:  FaIcon(FontAwesomeIcons.sun),
            tooltip: 'Light/Dark Mode',
            onPressed: () {
              context.read<AppThemeCubit>().toggleTheme();
            },
          ),
          //button that changes list view to grid view
          IconButton(onPressed: () {}, icon: FaIcon(FontAwesomeIcons.list))
        ],
      ),
    );
  }
}
