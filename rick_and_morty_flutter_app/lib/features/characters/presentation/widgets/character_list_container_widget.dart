import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rick_and_morty_flutter_app/features/characters/presentation/bloc/app_theme/app_theme_cubit.dart';

import '../../../../dependency_injection.dart';
import '../../domain/entities/character_entity.dart';

class CharacterListContainerWidget extends StatelessWidget {
  final CharacterEntity character;

  CharacterListContainerWidget({required this.character});

  @override
  Widget build(BuildContext context) {
    debugPrint('Building character widget for ${character.name}');

    final primaryColor = Theme.of(context).colorScheme.primary;
    final secondaryColor = Theme.of(context).colorScheme.secondary;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: primaryColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          //add image (url of image from api of current character)
          Image.network(
            character.image,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 16),
          //column widget that will contain the name and status of current character
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                character.name,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: secondaryColor,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Row(
                children: [
                  Text(
                    'Status: ',
                    style: TextStyle(
                      fontSize: 14,
                      color: secondaryColor.withOpacity(0.8),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    character.status,
                    style: TextStyle(
                      fontSize: 14,
                      color: character.status == 'Alive'
                          ? Colors.green
                          : Colors.red,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
