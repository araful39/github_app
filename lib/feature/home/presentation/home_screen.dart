import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github_app/feature/home/controller/home_controller.dart';
import 'package:github_app/feature/repo_details/presentation/repo_details_screen.dart';
import 'package:github_app/theme/them_controller.dart';

class HomeScreen extends StatelessWidget {
  final String username;
  const HomeScreen({super.key, required this.username});

  @override
  Widget build(BuildContext context) {

    final HomeController controller = Get.put(HomeController()..username = username);
   
    final ThemeController themeController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Text('@$username Repos'),
        actions: [
          Obx(() => IconButton(
                icon: Icon(controller.isGridView.value ? Icons.list : Icons.grid_view),
                onPressed: controller.toggleView,
              )),
          Obx(() => IconButton(
                icon: Icon(
                  themeController.themeMode.value == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode,
                ),
                onPressed: themeController.toggleTheme,
              )),
        ],
      ),
      body: Column(
        children: [
          _buildFilterBar(controller),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else if (controller.error.value.isNotEmpty) {
                return Center(child: Text(controller.error.value));
              } else if (controller.filteredRepos.isEmpty) {
                return const Center(child: Text('No repositories found'));
              } else {
                return controller.isGridView.value
                    ? _buildGridView(controller)
                    : _buildListView(controller);
              }
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBar(HomeController controller) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: controller.searchRepos,
              decoration: InputDecoration(
                hintText: 'Search repos...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
          const SizedBox(width: 8),
          DropdownButton<String>(
            value: controller.sortBy.value,
            items: const [
              DropdownMenuItem(value: 'name', child: Text('Name')),
              DropdownMenuItem(value: 'stars', child: Text('Stars')),
              DropdownMenuItem(value: 'forks', child: Text('Forks')),
              DropdownMenuItem(value: 'updated', child: Text('Updated')),
            ],
            onChanged: controller.setSortBy,
          ),
        ],
      ),
    );
  }

  Widget _buildListView(HomeController controller) {
    return ListView.builder(
      itemCount: controller.filteredRepos.length,
      itemBuilder: (context, index) {
        final repo = controller.filteredRepos[index];
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: _getLanguageColor(repo.language),
              child: Text(repo.language[0]),
            ),
            title: Text(repo.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(repo.description ?? 'No description'),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('⭐ ${repo.stargazersCount}'),
                Text('⑂ ${repo.forksCount}'),
              ],
            ),
            onTap: () => Get.to(() => RepoDetailScreen(repo: repo)),
          ),
        );
      },
    );
  }

  Widget _buildGridView(HomeController controller) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: controller.filteredRepos.length,
      itemBuilder: (context, index) {
        final repo = controller.filteredRepos[index];
        return Card(
          child: InkWell(
            onTap: () => Get.to(() => RepoDetailScreen(repo: repo)),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 12,
                        backgroundColor: _getLanguageColor(repo.language),
                        child: Text(repo.language[0], style: const TextStyle(fontSize: 10)),
                      ),
                      const SizedBox(width: 8),
                      Expanded(child: Text(repo.name, style: const TextStyle(fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(repo.description ?? 'No description', maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12)),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('⭐ ${repo.stargazersCount}', style: const TextStyle(fontSize: 12)),
                      Text('⑂ ${repo.forksCount}', style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Color _getLanguageColor(String language) {
    final map = {
      'Dart': Colors.blue,
      'JavaScript': Colors.yellow,
      'Python': Colors.green,
      'Java': Colors.orange,
      'TypeScript': Colors.blueAccent,
    };
    return map[language] ?? Colors.grey;
  }
}