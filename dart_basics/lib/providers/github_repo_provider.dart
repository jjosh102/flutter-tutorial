import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../models/github_repo.dart';
import '../services/github_service.dart';

final httpClientProvider = Provider<http.Client>((ref) {
  final client = http.Client();
  ref.onDispose(() => client.close());
  return client;
});

final githubServiceProvider = Provider<GithubService>((ref) {
  final client = ref.watch(httpClientProvider);
  return GithubService(client: client);
});

final githubRepoProvider = FutureProvider<List<GithubRepo>>((ref) {
  final service = ref.watch(githubServiceProvider);
  return service.fetchRepos(); 
});

