import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:github_app/feature/home/model/repo_response.dart';
import 'package:github_app/networks/dio/dio.dart';
import 'package:github_app/networks/endpoinst.dart';

class GetRepoApi {
  static final GetRepoApi _singleton = GetRepoApi._internal();
  GetRepoApi._internal();
  static GetRepoApi get instance => _singleton;

  Future<List<RepoResponse>> getUserRepos({required String userName}) async {
    try {
      Response response = await getHttp(Endpoints.userRepos(userName: userName));
      if (response.statusCode == 200) {
        return (response.data as List).map((json) => RepoResponse.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load repos');
      }
    } catch (error) {
      log("Error fetching repos: $error");
      rethrow;
    }
  }
}