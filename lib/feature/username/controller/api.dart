import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:github_app/feature/username/model/user_name_response.dart';
import 'package:github_app/networks/dio/dio.dart';
import 'package:github_app/networks/endpoinst.dart';
import 'package:github_app/networks/exception_handler/data_source.dart';

class GetUserNameApi {
  static final GetUserNameApi _singleton = GetUserNameApi._internal();
  GetUserNameApi._internal();
  static GetUserNameApi get instance => _singleton;
  Future<UserNameResponse> userName({required String userName}) async {
    try {
      Response response = await getHttp(Endpoints.userName(userName: userName));
      if (response.statusCode == 200 || response.statusCode == 201) {
        UserNameResponse data = UserNameResponse.fromJson(response.data);
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      log("--------eeeeeeee-$error");
      rethrow;
    }
  }
}
