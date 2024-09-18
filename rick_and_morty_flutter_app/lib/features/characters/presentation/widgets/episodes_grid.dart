import 'package:flutter/material.dart';
import 'package:rick_and_morty_flutter_app/features/characters/domain/entities/character_entity.dart';
import 'package:url_launcher/url_launcher.dart';

class EpisodesGrid extends StatelessWidget {
  List<String> episodeUrls;

  EpisodesGrid({required this.episodeUrls});

  // void _launchURL(String url) async {
  //   final Uri _url = Uri.parse(url);
  //   if (!await launchUrl(_url)) {
  //     throw Exception('Could not launch $_url');
  //   }
  // }
  String episode = '';
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final secondaryColor = Theme.of(context).colorScheme.secondary;

    return SizedBox(
      height: 350.0,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        shrinkWrap: true,
        padding: EdgeInsets.all(0),
        itemCount: episodeUrls.length,
        itemBuilder: (context, index) {
          // Extract episode number from URL or just use index
          episode = 'S${index + 1}EP${index + 1}';

          return SizedBox(
            width: 80,
            height: 40,
            child: ElevatedButton(
              onPressed: () {},
              child: Text(
                episode,
                style: TextStyle(
                  color: secondaryColor,
                  fontSize: 14,
                ),
              ),
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: primaryColor),
            ),
          );
        },
      ),
    );
  }
}
