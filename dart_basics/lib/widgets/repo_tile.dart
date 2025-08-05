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
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
          side: const BorderSide(color: Color(0xFF30363D)),
        ),
        color: Theme.of(context).cardColor,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                repo.name ?? '',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF58A6FF),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                repo.description ?? 'No description provided.',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall!.copyWith(color: Colors.grey[400]),
              ),
              const SizedBox(height: 8),
              if (repo.topics.isNotEmpty)
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: repo.topics
                      .where((topic) => topic.toLowerCase() != 'show')
                      .map(
                        (topic) => Chip(
                          label: Text(
                            topic,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                          backgroundColor: const Color(0xFF238636),
                          labelPadding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: -2,
                          ),
                          visualDensity:
                              VisualDensity.compact, 
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap, 
                        ),
                      )
                      .toList(),
                ),
              const SizedBox(height: 8),
              Row(
                children: [
                  if (repo.language != null)
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 4,
                          backgroundColor: Colors.orange,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          repo.language!,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  if (repo.language != null) const SizedBox(width: 12),
                  if (repo.stargazersCount > 0)
                    Row(
                      children: [
                        const Icon(
                          Icons.star_border,
                          size: 16,
                          color: Colors.amber,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          repo.stargazersCount.toString(),
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  const SizedBox(width: 12),
                  Text(
                    'Updated ${repo.updatedAt.toLocal().toIso8601String().split('T')[0]}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF8B949E),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
