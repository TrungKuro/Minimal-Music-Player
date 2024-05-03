import 'package:flutter/material.dart';
import 'package:minimal_music_player/pages/setting_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          // LOGO
          DrawerHeader(
            child: Center(
              child: Icon(
                Icons.music_note,
                size: 40,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          // HOME TILE
          Padding(
            padding: const EdgeInsets.only(
              left: 25,
            ),
            child: ListTile(
              title: const Text('H O M E'),
              leading: const Icon(Icons.home),
              // Quay lại Home Page
              onTap: () => Navigator.pop(context),
            ),
          ),
          // SETTING TILE
          Padding(
            padding: const EdgeInsets.only(
              left: 25,
            ),
            child: ListTile(
              title: const Text('S E T T I N G'),
              leading: const Icon(Icons.settings),
              onTap: () {
                // Quay lại Home Page
                Navigator.pop(context);
                // Chuyển sang Setting Page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingPage(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
