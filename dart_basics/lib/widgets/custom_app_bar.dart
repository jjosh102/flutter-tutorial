import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 1, 4, 9),
      leading: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Profile'),
                content: const Text('You tapped the profile avatar.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          },
          child: const CircleAvatar(
            radius: 10,
            backgroundImage: NetworkImage(
              'https://avatars.githubusercontent.com/u/50490077?v=4',
              scale: .5,
            ),
          ),
        ),
      ),
      title: const Text(
        'jjosh102',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
          color: Color.fromARGB(255, 240, 246, 252),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
