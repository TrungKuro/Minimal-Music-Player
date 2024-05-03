import 'package:flutter/material.dart';
import 'package:minimal_music_player/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class NeuBox extends StatelessWidget {
  final Widget? child;

  const NeuBox({
    super.key,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    /// Kiểm tra xem có phải đang là chế độ "Dark Mode" ko?
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          // Darker shadow on Bottom Right
          BoxShadow(
            color: isDarkMode ? Colors.black : Colors.grey.shade300,
            blurRadius: 15,
            offset: const Offset(4, 4),
          ),
          // Lighter shadow on Top Left
          BoxShadow(
            color: isDarkMode ? Colors.grey.shade800 : Colors.white,
            blurRadius: 15,
            offset: const Offset(-4, -4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: child,
    );
  }
}
