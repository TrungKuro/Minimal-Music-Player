import 'package:audioplayers/audioplayers.dart';
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

  /* ----------------------------- AUDIO PLAYER ---------------------------- */

  // Khởi tạo Audio Player
  final AudioPlayer _audioPlayer = AudioPlayer();

  // Giám sát Durations
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  /// Constructor of PlaylistProvider.
  /// Tự động thiết lập các lắng nghe thời lượng mỗi khi được khởi tạo.
  PlaylistProvider() {
    listenToDuration();
  }

  /// Initially not Playing
  bool _isPlaying = false;

  /// Play the song
  void play() async {
    // Lấy đường dẫn bài hát hiện tại đang chọn
    final path = _playlist[currentSongIndex!].audioPath;
    // Dừng bài hát hiện tại đang phát nếu có
    await _audioPlayer.stop();
    // Cho phát bài hát mới đang chọn
    await _audioPlayer.play(AssetSource(path));
    // Bật cờ phát nhạc
    _isPlaying = true;
    // Update UI
    notifyListeners();
  }

  /// Pause current song
  void pause() async {
    // Tạm dừng bài hát hiện tại đang phát nếu có
    await _audioPlayer.pause();
    // Tắt cờ phát nhạc
    _isPlaying = false;
    // Update UI
    notifyListeners();
  }

  /// Resume Playing
  void resume() async {
    // Phát tiếp bài hát hiện tại đang tạm dừng nếu có
    await _audioPlayer.resume();
    // Bật cờ phát nhạc
    _isPlaying = true;
    // Update UI
    notifyListeners();
  }

  /// Pause or Resume
  void pauseOrResume() async {
    // Nếu đang phát thì dừng lại và ngược la5i
    (_isPlaying) ? pause() : resume();
  }

  /// Seek to a specific position in the current song.
  /// Di chuyển thanh trượt đến vị trí muốn nghe của bài hát.
  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  /// Play Next Song
  void playNextSong() {
    // Nếu bài hát hiện tại đang có
    if (_currentSongIndex != null) {
      if (_currentSongIndex! < _playlist.length - 1) {
        // Đến bài tiếp theo, nếu chưa phải là bài cuối cùng
        _currentSongIndex = _currentSongIndex! + 1;
      } else {
        // Nếu là bài cuối cùng, quay lại bài hát đầu tiên
        _currentSongIndex = 0;
      }
    }
    // Cho phát nhạc
    play();
  }

  /// Play Previous Song
  void playPreviousSong() {
    // Nếu bài hát đã được phát hơn 2 giây, thì restart lại bài hát hiện tại
    if (_currentDuration.inSeconds > 2) {
      seek(Duration.zero);
    }
    // Ngược lại cho quay về bài trước
    else {
      if (_currentSongIndex! > 0) {
        // Quay về bài trước, nếu chưa phải là bài đầu tiên
        _currentSongIndex = _currentSongIndex! - 1;
      } else {
        // Nếu là bài đầu tiên, quay lại bài hát cuối cùng
        _currentSongIndex = _playlist.length - 1;
      }
      // Cho phát nhạc
      play();
    }
  }

  /// Listen to Duration
  void listenToDuration() {
    // Lắng nghe thời lượng hiện tại của bài hát
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      // Update UI
      notifyListeners();
    });

    // Lắng nghe tổng thời lượng bài hát
    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      // Update UI
      notifyListeners();
    });

    // Lắng nghe khi hoàn thành bài hát
    _audioPlayer.onPlayerComplete.listen((event) {
      // Cho phát bài tiếp theo
      playNextSong();
    });
  }

  /// Dispose Audio Player

  /* ------------------------------- Getters ------------------------------- */

  /// Lấy danh sách các bài hát
  List<Song> get playlist => _playlist;

  /// Cho biết bài hát hiện đang chọn, nếu có
  int? get currentSongIndex => _currentSongIndex;

  /// Cho biết có đang phát nhạc hay ko?
  bool get isPlaying => _isPlaying;

  /// Cho biết tổng thời lượng của bài hát hiện tại
  Duration get totalDuration => _totalDuration;

  /// Cho biết thời lượng hiện đang phát
  Duration get currentDuration => _currentDuration;

  /* ------------------------------- Setters ------------------------------- */

  /// Cập nhập bài hát mới đang chọn
  set currentSongIndex(int? newIndex) {
    _currentSongIndex = newIndex;
    // Cho phát nhạc với chỉ mục mới
    if (_currentSongIndex != null) {
      play();
    }
    // Update UI
    notifyListeners();
  }
}
