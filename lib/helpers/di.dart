
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:github_app/feature/home/controller/home_controller.dart';

import '../feature/username/controller/user_controller.dart';

final locator = GetIt.instance;
final appData = locator.get<GetStorage>();

void diSetup() {
 Get.lazyPut(() => UserController());
  Get.lazyPut(() => HomeController());

}
