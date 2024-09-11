import 'package:flutter/material.dart';
import 'package:rick_and_morty_flutter_app/features/characters/domain/entities/character_entity.dart';

import '../pages/character_details_page.dart';

class CharacterGridContainerWidget extends StatelessWidget {
  final CharacterEntity character;

  CharacterGridContainerWidget({required this.character});

  @override
    Widget build(BuildContext context) {
      final primaryColor = Theme.of(context).colorScheme.primary;
      final secondaryColor = Theme.of(context).colorScheme.secondary;

      return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CharacterDetailsPage(character: character),
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.all(10.0),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Character Image (on top)
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  character.image,
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 8),
              // Character Name (below image)
              Text(
                character.name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: secondaryColor,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(height: 4),
              // Character Status (below name)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
              ),
            ],
          ),
        ),
      );
    }
  }
