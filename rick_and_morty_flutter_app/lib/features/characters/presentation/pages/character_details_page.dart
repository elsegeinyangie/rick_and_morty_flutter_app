import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rick_and_morty_flutter_app/features/characters/presentation/widgets/episodes_grid.dart';

import '../../domain/entities/character_entity.dart';
import '../bloc/app_theme/app_theme_cubit.dart';

class CharacterDetailsPage extends StatelessWidget {
  final CharacterEntity character;

  CharacterDetailsPage({required this.character});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final secondaryColor = Theme.of(context).colorScheme.secondary;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: secondaryColor,
            expandedHeight: 300.0,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                character.image,
                fit: BoxFit.cover,
              ),
              title: Text(character.name, style: TextStyle(fontWeight: FontWeight.bold),),
            ),
            actions: <Widget>[
              IconButton(
                icon: FaIcon(FontAwesomeIcons.sun),
                tooltip: 'Light/Dark Mode',
                onPressed: () {
                  context.read<AppThemeCubit>().toggleTheme();
                },
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            'SPECIES',
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline),
                          ),
                          Text(
                            character.species,
                            style: TextStyle(
                              color: secondaryColor,
                              fontSize: 14.0,
                            ),
                          )
                        ],
                      ),
                      SizedBox(width: 30),
                      Column(
                        children: [
                          Text(
                            'STATUS',
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline),
                          ),
                          Text(
                            character.status,
                            style: TextStyle(
                              color: character.status == 'Alive'
                                  ? Colors.green
                                  : Colors.red,
                              fontSize: 14.0,
                            ),
                          )
                        ],
                      ),
                      SizedBox(width: 30),
                      Column(
                        children: [
                          Text(
                            'GENDER',
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline),
                          ),
                          Text(
                            character.gender,
                            style: TextStyle(
                              color: secondaryColor,
                              fontSize: 14.0,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Location: ',
                              style: TextStyle(
                                color: secondaryColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0,
                              ),
                            ),
                            Text(
                              character.location,
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Episodes with ${character.name}',
                              style: TextStyle(
                                color: secondaryColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: secondaryColor.withOpacity(0.5),
                    thickness: 0.2,
                  ),
                  //episode grid
                  EpisodesGrid(episodeUrls: character.episodes)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
