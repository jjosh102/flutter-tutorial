import 'package:dart_basics/screens/repo_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/github_repo_provider.dart';
import '../widgets/repo_tile.dart';

class RepoListScreen extends ConsumerWidget {
  const RepoListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncRepos = ref.watch(githubRepoProvider);

    return Scaffold(
      appBar: AppBar(
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
      ),
      body: asyncRepos.when(
        data: (repos) => ListView.builder(
          itemCount: repos.length,
          itemBuilder: (context, index) {
            final repo = repos[index];
            return RepoTile(
              repo: repo,
              onTap: () =>
                  navigateWithSlide(context, RepoDetailScreen(repo: repo)),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
      ),
    );
  }

  void navigateWithSlide(BuildContext context, Widget page) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, animation, _) => page,
        transitionsBuilder: (_, animation, _, child) {
          const begin = Offset(0.0, 1.0); // Slide from bottom
          const end = Offset.zero;
          final tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: Curves.easeOut));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }
}
