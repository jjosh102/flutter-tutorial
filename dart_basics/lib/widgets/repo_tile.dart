import 'package:flutter/material.dart';
import '../models/github_repo.dart';

class RepoTile extends StatelessWidget {
  final GithubRepo repo;
  final VoidCallback onTap;

  const RepoTile({super.key, required this.repo, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(repo.name ?? '', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 4),
              Text(
                repo.description ?? 'No description available',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 8),
              if (repo.topics.isNotEmpty)
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: repo.topics
                      .where((topic) => topic.toLowerCase() != 'show')
                      .map((topic) => Chip(label: Text(topic)))
                      .toList(),
                ),
              const SizedBox(height: 8),
              Row(
                children: [
                  if (repo.language != null)
                    Row(
                      children: [
                        const CircleAvatar(radius: 4, backgroundColor: Colors.blue),
                        const SizedBox(width: 4),
                        Text(repo.language!),
                      ],
                    ),
                  if (repo.language != null) const SizedBox(width: 12),
                  if (repo.stargazersCount > 0)
                    Row(
                      children: [
                        const Icon(Icons.star, size: 16, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(repo.stargazersCount.toString()),
                      ],
                    ),
                  const SizedBox(width: 12),
                  Text(
                    'Updated ${repo.updatedAt.toLocal().toIso8601String().split('T')[0]}',
                    style: const TextStyle(fontSize: 12, color: Color.fromARGB(255, 39, 44, 56)),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
