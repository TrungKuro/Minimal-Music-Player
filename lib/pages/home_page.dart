import 'package:flutter/material.dart';
import 'package:minimal_music_player/components/my_drawer.dart';
import 'package:minimal_music_player/models/playlist_provider.dart';
import 'package:minimal_music_player/models/song.dart';
import 'package:minimal_music_player/pages/song_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// Go to a Song
  void goToSong(int songIndex) {
    // Update current song index
    Provider.of<PlaylistProvider>(context, listen: false).currentSongIndex = songIndex;
    // Chuyển sang Song Page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SongPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* ----------------------------- Top App ----------------------------- */
      appBar: AppBar(
        title: const Text('P L A Y   L I S T'),
      ),
      drawer: const MyDrawer(),
      /* ---------------------------- Bottom App --------------------------- */
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Consumer<PlaylistProvider>(
        builder: (context, value, child) {
          // Get the playlist
          final List<Song> playlist = value.playlist;
          // Return list view UI
          return ListView.builder(
            itemCount: playlist.length,
            itemBuilder: (context, index) {
              // Get individual song
              final Song song = playlist[index];
              // Return list tile UI
              return ListTile(
                title: Text(song.songName),
                subtitle: Text(song.artisName),
                leading: Image.asset(song.albumArtImagePath),
                onTap: () => goToSong(index),
              );
            },
          );
        },
      ),
    );
  }
}
