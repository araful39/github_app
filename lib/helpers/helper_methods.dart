import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

Future<void> initInternetChecker() async {
  final checker = InternetConnectionChecker.createInstance(
    checkInterval: const Duration(seconds: 2),
  );

  checker.onStatusChange.listen((status) {
    switch (status) {
      case InternetConnectionStatus.connected:
        EasyLoading.dismiss(); // remove loading if any
        EasyLoading.showSuccess('✅ Internet connected',
            duration: const Duration(seconds: 2));
        break;

      case InternetConnectionStatus.disconnected:
        EasyLoading.showError(
          '❌ No internet connection',
          duration: const Duration(seconds: 3),
        );
        break;

      case InternetConnectionStatus.slow:
        EasyLoading.showInfo(
          '⚠️ Connection seems slow',
          duration: const Duration(seconds: 3),
        );
        break;
    }
  });
}
