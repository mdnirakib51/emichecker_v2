
import 'dart:developer';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'local_storage.dart';
import 'local_storage_keys.dart';

class LocalStorageController extends GetxController {
  static LocalStorageController get current => Get.find();
  SharedPreferences? prefs;
  LocalStorageController({this.prefs});

  String? get accessToken => Get.find<LocalStorage>().getString(key: StorageKeys.accessToken);
  String? get role => Get.find<LocalStorage>().getString(key: StorageKeys.role);

  @override
  void onInit() {
    super.onInit();
    log("initialing preferences in storage controller ...");
    initSharePreference();
  }

  Future<void> initSharePreference() async {
    prefs = await SharedPreferences.getInstance();
    update();
  }

  Future<void> saveUserToken(String token) async {
    Get.find<LocalStorage>().setString(key: StorageKeys.accessToken, value: token);
    update();
  }

  Future<void> saveRole(String role) async {
    Get.find<LocalStorage>().setString(key: StorageKeys.role, value: role);
    update();
  }

}
