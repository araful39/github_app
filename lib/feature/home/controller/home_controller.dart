import 'package:get/get.dart';
import 'package:github_app/feature/home/controller/api.dart';
import 'package:github_app/feature/home/model/repo_response.dart';

class HomeController extends GetxController {
  late final String username;
  final GetRepoApi api = GetRepoApi.instance;

  RxList<RepoResponse> repos = <RepoResponse>[].obs;
  RxList<RepoResponse> filteredRepos = <RepoResponse>[].obs;
  RxBool isLoading = false.obs;
  RxString error = ''.obs;
  RxBool isGridView = false.obs;
  RxString sortBy = 'name'.obs;
  String searchQuery = '';

  Future<void> fetchRepos() async {
    try {
      isLoading.value = true;
      error.value = '';
      final response = await api.getUserRepos(userName: username);
      repos.assignAll(response);
      filteredRepos.assignAll(response);
      _applyFilters();
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void toggleView() => isGridView.value = !isGridView.value;

  void searchRepos(String query) {
    searchQuery = query.toLowerCase();
    _applyFilters();
  }

  void setSortBy(String? value) {
    if (value != null) {
      sortBy.value = value;
      _applyFilters();
    }
  }

  void _applyFilters() {
    var list = repos.where((repo) => repo.name.toLowerCase().contains(searchQuery)).toList();

    switch (sortBy.value) {
      case 'name':
        list.sort((a, b) => a.name.compareTo(b.name));
        break;
      case 'stars':
        list.sort((a, b) => b.stargazersCount.compareTo(a.stargazersCount));
        break;
      case 'forks':
        list.sort((a, b) => b.forksCount.compareTo(a.forksCount));
        break;
      case 'updated':
        list.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
        break;
    }

    filteredRepos.assignAll(list);
  }


  @override
  void onInit() {
    fetchRepos();
    super.onInit();
  }
}