import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/github_repo.dart';

class GithubService {
  final http.Client _client;

  GithubService({required http.Client client}) : _client = client;

  Future<List<GithubRepo>> fetchRepos() async {
    final url = Uri.parse('https://api.github.com/users/jjosh102/repos');
    final response = await _client.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> list = json.decode(response.body);
      final repos = list
          .whereType<Map<String, dynamic>>()
          .map((e) => GithubRepo.fromJson(e))
          .where((repo) => repo.topics.any((t) => t.toLowerCase() == 'show'))
          .toList();

      repos.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
      return repos;
    } else {
      throw Exception('Failed to load repositories');
    }
  }
}
