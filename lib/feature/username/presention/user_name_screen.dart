import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github_app/feature/username/controller/user_controller.dart';

class UserNameScreen extends StatelessWidget {
  UserNameScreen({super.key});

  final UserController controller = Get.find<UserController>();
  final TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GitHub User')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                  labelText: 'Enter GitHub username',
                  border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                controller.fetchUser(usernameController.text);
              },
              child: const Text('Fetch User'),
            ),
            const SizedBox(height: 16),
            Obx(() {
              if (controller.isLoading.value) {
                return const CircularProgressIndicator();
              } else if (controller.error.value.isNotEmpty) {
                return Text(
                  'Error: ${controller.error.value}',
                  style: const TextStyle(color: Colors.red),
                );
              } else if (controller.user.value != null) {
                final user = controller.user.value!;
                return Column(
                  children: [
                     (user.avatarUrl != null && user.avatarUrl!.isNotEmpty)
            ? CachedNetworkImage(
                imageUrl: user.avatarUrl!,
                width: 100,
                height: 100,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.error),
              )
            : const Icon(Icons.person, size: 100),
                    const SizedBox(height: 8),
                    Text('Login: ${user.login}',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text('Bio: ${user.bio}'),
                  ],
                );
              } else {
                return const Text('No data yet');
              }
            }),
          ],
        ),
      ),
    );
  }
}

