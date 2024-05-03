import 'package:flutter/material.dart';
import 'package:minimal_music_player/models/song.dart';

class PlaylistProvider extends ChangeNotifier {
  /// Playlist of Song
  final List<Song> _playlist = [
    // Song 1
    Song(
      songName: 'All Rise',
      artisName: 'Blue',
      albumArtImagePath: 'assets/images/Blue.jpeg',
      audioPath: 'audio/All Rise.mp3',
    ),

    // Song 2
    Song(
      songName: 'Blizzard Gunner',
      artisName: 'BGM',
      albumArtImagePath: 'assets/images/BGM.jpeg',
      audioPath: 'audio/Blizzard Gunner.mp3',
    ),

    // Song 3
    Song(
      songName: 'Bubble Gum',
      artisName: 'NewJeans',
      albumArtImagePath: 'assets/images/NewJeans.jpeg',
      audioPath: 'audio/Bubble Gum.mp3',
    ),

    // Song 4
    Song(
      songName: 'Bye Bye Bye',
      artisName: 'NSYNC',
      albumArtImagePath: 'assets/images/NSYNC.jpeg',
      audioPath: 'audio/Bye Bye Bye.mp3',
    ),

    // Song 5
    Song(
      songName: 'I Want It That Way',
      artisName: 'Backstreet Boys',
      albumArtImagePath: 'assets/images/Backstreet Boys.jpeg',
      audioPath: 'audio/I Want It That Way.mp3',
    ),

    // Song 6
    Song(
      songName: 'SpecialZ',
      artisName: 'King Gnu',
      albumArtImagePath: 'assets/images/King Gnu.jpeg',
      audioPath: 'audio/SpecialZ.mp3',
    ),

    // Song 7
    Song(
      songName: 'Spot',
      artisName: 'Jennie',
      albumArtImagePath: 'assets/images/Jennie.jpeg',
      audioPath: 'audio/Spot.mp3',
    ),
  ];

  /// Bài hát hiện tại đang phát
  int? _currentSongIndex;

  /* ------------------------------- Getters ------------------------------- */

  /// Lấy danh sách các bài hát
  List<Song> get playlist => _playlist;

  /// Cho biết bài hát hiện đang chọn, nếu có
  int? get currentSongIndex => _currentSongIndex;

  /* ------------------------------- Setters ------------------------------- */

  /// Cập nhập bài hát mới đang chọn
  set currentSongIndex(int? newIndex) {
    _currentSongIndex = newIndex;
    // Update UI
    notifyListeners();
  }
}
