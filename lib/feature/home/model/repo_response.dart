// lib/models/repo_response.dart
class RepoResponse {
  final String name;
  final String? description;
  final int stargazersCount;
  final int forksCount;
  final String language;
  final DateTime updatedAt;
  final String htmlUrl;
  final bool private;

  RepoResponse({
    required this.name,
    this.description,
    required this.stargazersCount,
    required this.forksCount,
    required this.language,
    required this.updatedAt,
    required this.htmlUrl,
    required this.private,
  });

  factory RepoResponse.fromJson(Map<String, dynamic> json) {
    return RepoResponse(
      name: json['name'] ?? '',
      description: json['description'],
      stargazersCount: json['stargazers_count'] ?? 0,
      forksCount: json['forks_count'] ?? 0,
      language: json['language'] ?? 'Unknown',
      updatedAt: DateTime.parse(json['updated_at']),
      htmlUrl: json['html_url'],
      private: json['private'] ?? false,
    );
  }
}