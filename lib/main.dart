import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:github_app/feature/username/presention/user_name_screen.dart';
import 'package:github_app/helpers/di.dart';
import 'package:github_app/networks/dio/dio.dart';

void main()async{
    WidgetsFlutterBinding.ensureInitialized();
 
  await GetStorage.init();
  diSetup();


  DioSingleton.instance.create();

   runApp(
    const MyApp(),
   );

}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
            title: 'GitHub App',
            // theme: ThemeData(
            //     unselectedWidgetColor: Colors.white,
            //     primarySwatch: CustomTheme.kToDark,
            //     useMaterial3: false,
            //     scaffoldBackgroundColor: AppColor.cFFFFFF,
            //     appBarTheme:
            //         const AppBarTheme(color: AppColor.cFFFFFF, elevation: 0)),
            debugShowCheckedModeBanner: false,
           builder: EasyLoading.init(
        builder: (context, widget) {
          return MediaQuery(
            data: MediaQuery.of(context),
            child: widget!,
          );
        },
      ),

      home: UserNameScreen(),
    );
  }
}
