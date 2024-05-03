import 'package:flutter/material.dart';
import 'package:minimal_music_player/themes/dark_mode.dart';
import 'package:minimal_music_player/themes/light_mode.dart';

class ThemeProvider extends ChangeNotifier {
  /// Mặc định khi mới chạy ứng dụng là chế độ "Light Mode"
  ThemeData _themeData = lightMode;

  /// Lấy thông tin chế độ hiện đang dùng
  ThemeData get themeData => _themeData;

  /// Lấy thông tin cho biết đang là chế độ "Dark" hay ko?
  bool get isDarkMode => _themeData == darkMode;

  /// Cài đặt chế độ hiển thị
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    // Update UI
    notifyListeners();
  }

  /// Đảo ngược chế độ đang hiển thị
  void toggleTheme() {
    (isDarkMode) ? _themeData = lightMode : _themeData = darkMode;
    // Update UI
    notifyListeners();
  }
}
