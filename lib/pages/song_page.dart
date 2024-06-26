import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:minimal_music_player/components/neu_box.dart';
import 'package:minimal_music_player/models/playlist_provider.dart';
import 'package:provider/provider.dart';

class SongPage extends StatelessWidget {
  const SongPage({super.key});

  /// Chuyển đổi Duration sang định dạng (Minute:Second)
  String formatTime(Duration duration) {
    String digitSeconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    String digitMinutes = duration.inMinutes.toString().padLeft(2, '0');
    return '$digitMinutes:$digitSeconds';
  }

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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 25,
                          right: 25,
                          top: 25,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // START TIME
                            Text(formatTime(value.currentDuration)),
                            // SHUFFLE ICON
                            IconButton(
                              icon: value.isShuffle
                                  ? const Icon(
                                      Icons.shuffle_on_rounded,
                                      color: Colors.amber,
                                    )
                                  : const Icon(
                                      Icons.shuffle,
                                    ),
                              onPressed: value.toggleShuffle,
                            ),
                            // REPEAT ICON
                            IconButton(
                              icon: value.isRepeat
                                  ? const Icon(
                                      Icons.repeat_one_on_rounded,
                                      color: Colors.amber,
                                    )
                                  : const Icon(
                                      Icons.repeat,
                                    ),
                              onPressed: value.toggleRepeat,
                            ),
                            // END TIME
                            Text(formatTime(value.totalDuration)),
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
                          max: value.totalDuration.inSeconds.toDouble(),
                          value: value.currentDuration.inSeconds.toDouble(),
                          activeColor: Colors.amber,
                          onChanged: (position) {},
                          onChangeEnd: (position) {
                            // Thực hiện khi người dùng thực hiện xong việc kéo thanh trượt
                            value.seek(Duration(seconds: position.toInt()));
                          },
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
                          onTap: value.playPreviousSong,
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
                          onTap: value.pauseOrResume,
                          child: NeuBox(
                            child: Icon(value.isPlaying ? Icons.pause : Icons.play_arrow),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      // SKIP FORWARD
                      Expanded(
                        child: GestureDetector(
                          onTap: value.playNextSong,
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
