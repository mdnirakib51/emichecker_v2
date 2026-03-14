
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'domain/local/preferences/local_storage.dart';
import 'domain/local/preferences/storage_controller.dart';
import 'domain/server/http_client/app_config.dart';
import 'global/constants/enum.dart';
import 'global/method/get_device_info.dart';
import 'initializer.dart';
import 'service/splash_screen/view/splash_screen.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    LocalStorage localStorage = LocalStorage();
    Get.put(localStorage); // Register LocalStorage instance
    Get.put(LocalStorageController());
    _initializeApp();
  }

  // ==# App Initialization Logic
  Future<void> _initializeApp() async {
    LocalStorage localStorage = Get.find<LocalStorage>();
    await localStorage.initLocalStorage();
    await init();

    AppUrlExtention.initializeUrl(defaultUrlLink: UrlLink.isDev);
    await GetDeviceInfo.getDeviceInfo();
  }

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen()
    );
  }
}
