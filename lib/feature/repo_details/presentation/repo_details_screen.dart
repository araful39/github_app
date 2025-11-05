import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:github_app/feature/home/model/repo_response.dart';
import 'package:url_launcher/url_launcher.dart';

class RepoDetailScreen extends StatelessWidget {
  final RepoResponse repo;
  const RepoDetailScreen({super.key, required this.repo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(repo.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(repo.name, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            if (repo.description != null) ...[
              Text(repo.description!, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 16),
            ],
            _infoRow('Language', repo.language),
            _infoRow('Stars', repo.stargazersCount.toString()),
            _infoRow('Forks', repo.forksCount.toString()),
            _infoRow('Private', repo.private ? 'Yes' : 'No'),
            _infoRow('Last Updated', _formatDate(repo.updatedAt)),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              icon: const Icon(Icons.open_in_browser),
              label: const Text('Open in GitHub'),
              onPressed: () {
                log('Opening ${repo.htmlUrl}');
                _launchURL(repo.htmlUrl, context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
void _launchURL(String url, BuildContext context) async {
  final uri = Uri.parse(url);
  try {
    final launched = await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
    if (!launched) {
      // Fallback or show message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $url')),
      );
    }
  } catch (e) {
    print('Error launching URL: $e');
  }
}
}
