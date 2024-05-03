import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:minimal_music_player/components/neu_box.dart';
import 'package:minimal_music_player/models/playlist_provider.dart';
import 'package:provider/provider.dart';

class SongPage extends StatelessWidget {
  const SongPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(
      builder: (context, value, child) {
        // Get Playlist
        final playlist = value.playlist;
        // Get current song index
        final currentSong = playlist[value.currentSongIndex ?? 0];
        // Return UI
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 25,
                right: 25,
                bottom: 25,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // APP BAR
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // BACK BUTTON
                      IconButton(
                        onPressed: () {
                          // Quay lại Home Page
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back),
                      ),
                      // TITLE
                      const Text('P L A Y L I S T'),
                      // MENU BUTTON
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.menu),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  // ALBUM ARTWORK
                  NeuBox(
                    child: Column(
                      children: [
                        // IMAGE
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(currentSong.albumArtImagePath),
                        ),
                        // SONG NAME & ARTIST NAME & ICON
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // SONG NAME & ARTIST NAME
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    currentSong.songName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(currentSong.artisName),
                                ],
                              ),
                              // HEART ICON
                              const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // SONG DURATION PROGRESS
                  Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 25,
                          right: 25,
                          top: 25,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // START TIME
                            Text('0:00'),
                            // SHUFFLE ICON
                            Icon(Icons.shuffle),
                            // REPEAT ICON
                            Icon(Icons.repeat),
                            // END TIME
                            Text('0:00'),
                          ],
                        ),
                      ),
                      // SONG DURATION PROGRESS
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          thumbShape: const RoundSliderThumbShape(
                            enabledThumbRadius: 0,
                          ),
                        ),
                        child: Slider(
                          min: 0,
                          max: 100,
                          value: 50,
                          activeColor: Colors.amber,
                          onChanged: (value) {},
                        ),
                      ),
                    ],
                  ),
                  // PLAYBACK CONTROLS
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      // SKIP PREVIOUS
                      Expanded(
                        child: GestureDetector(
                          onTap: () {},
                          child: const NeuBox(
                            child: Icon(Icons.skip_previous),
                          ),
                        ),
                      ),
                      // PLAY PAUSE
                      const SizedBox(width: 20),
                      Expanded(
                        flex: 2,
                        child: GestureDetector(
                          onTap: () {},
                          child: const NeuBox(
                            child: Icon(Icons.play_arrow),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      // SKIP FORWARD
                      Expanded(
                        child: GestureDetector(
                          onTap: () {},
                          child: const NeuBox(
                            child: Icon(Icons.skip_next),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
