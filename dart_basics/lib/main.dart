import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/repo_list_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GitHub Projects',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: const Color.fromARGB(255, 39, 44, 56)),
      home: const RepoListScreen(),
    );
  }
}
