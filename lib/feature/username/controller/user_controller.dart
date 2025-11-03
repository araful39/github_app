import 'package:get/get.dart';
import 'package:github_app/feature/username/controller/api.dart';
import 'package:github_app/feature/username/model/user_name_response.dart';

class UserController extends GetxController {
  final GetUserNameApi userRepository = GetUserNameApi.instance;

  Rx<UserNameResponse?> user = Rx<UserNameResponse?>(null);
  RxBool isLoading = false.obs;
  RxString error = ''.obs;

  Future<void> fetchUser(String userName) async {
    try {
      isLoading.value = true;
      error.value = '';
      user.value = await userRepository.userName(userName: userName);
    } catch (e) {
      error.value = e.toString();
      user.value = null;
    } finally {
      isLoading.value = false;
    }
  }
}
