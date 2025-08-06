import 'package:flutter/material.dart';
import '../models/github_repo.dart';

class RepoDetailScreen extends StatelessWidget {
  final GithubRepo repo;

  const RepoDetailScreen({super.key, required this.repo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(repo.name ?? 'Repository'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text(repo.name ?? '', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text(repo.description ?? 'No description provided.', style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 16),
            if (repo.homepage != null && repo.homepage!.isNotEmpty)
              ElevatedButton.icon(
                onPressed: () {
                  // to do
                },
                icon: const Icon(Icons.link),
                label: const Text('Visit Homepage'),
              ),
            const Divider(height: 32),
            Text('Details:', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            _infoRow('Language', repo.language),
            _infoRow('Stars', repo.stargazersCount.toString()),
            _infoRow('Watchers', repo.watchersCount.toString()),
            _infoRow('Forks', repo.forksCount.toString()),
            _infoRow('Open Issues', repo.openIssuesCount.toString()),
            _infoRow('Default Branch', repo.defaultBranch),
            _infoRow('License', repo.license?.name ?? 'None'),
            const SizedBox(height: 16),
            Text('Activity Timeline:', style: Theme.of(context).textTheme.titleMedium),
            _infoRow('Created', repo.createdAt.toLocal().toIso8601String().split('T')[0]),
            _infoRow('Updated', repo.updatedAt.toLocal().toIso8601String().split('T')[0]),
            _infoRow('Pushed', repo.pushedAt.toLocal().toIso8601String().split('T')[0]),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value ?? '-', style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
