
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';

import '../feature/username/controller/user_controller.dart';

final locator = GetIt.instance;
final appData = locator.get<GetStorage>();

void diSetup() {
  locator.registerSingleton<GetStorage>(GetStorage());

  Get.lazyPut<UserController>(() => UserController()); // <-- IMPORTANT

}
