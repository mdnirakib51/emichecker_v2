
import 'dart:developer';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../domain/local/preferences/local_storage.dart';
import '../../../domain/local/preferences/local_storage_keys.dart';
import '../view/login_screen.dart';

class AuthService {

  static Future<void> saveCredentials({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    try {
      if (rememberMe) {
        Get.find<LocalStorage>().setString(key: StorageKeys.email, value: email);
        Get.find<LocalStorage>().setString(key: StorageKeys.password, value: password);
      } else {
        Get.find<LocalStorage>().remove(key: StorageKeys.email);
        Get.find<LocalStorage>().remove(key: StorageKeys.password);
      }
      Get.find<LocalStorage>().setBool(key: StorageKeys.rememberMe, value: rememberMe);
    } catch (e) {
      log("Error saving credentials: $e");
    }
  }

  static Map<String, dynamic> loadSavedCredentials() {
    try {
      final bool savedRememberMe = Get.find<LocalStorage>().getBool(key: StorageKeys.rememberMe, isFalse: false);
      String email = "";
      String password = "";

      if (savedRememberMe) {
        email = Get.find<LocalStorage>().getString(key: StorageKeys.email) ?? "";
        password = Get.find<LocalStorage>().getString(key: StorageKeys.password) ?? "";
      }

      return {
        'email': email,
        'password': password,
        'remember_me': savedRememberMe,
      };
    } catch (e) {
      log("Error loading credentials: $e");
      return {
        'email': "",
        'password': "",
        'remember_me': false,
      };
    }
  }

  static Future<void> performLogout() async {
    try {
      final String? token = Get.find<LocalStorage>().getString(key: StorageKeys.accessToken);
      SharedPreferences preferences = await SharedPreferences.getInstance();

      // Save data that should persist after logout
      final Map<String, dynamic> persistentData = {
        'base_url': Get.find<LocalStorage>().getString(key: StorageKeys.baseUrl),
        'email': Get.find<LocalStorage>().getString(key: StorageKeys.email),
        'password': Get.find<LocalStorage>().getString(key: StorageKeys.password),
        'remember_me': Get.find<LocalStorage>().getBool(key: StorageKeys.rememberMe),
      };

      log("===/@ User Token before clearing: $token");
      log("===/@ Persistent data: $persistentData");

      // Clear all preferences
      await preferences.clear();
      await preferences.setBool('isFirstRun', false);

      // Restore persistent data
      await _restorePersistentData(persistentData);

      // Navigate to login screen
      await Get.offAll(() => const LogInScreen());

    } catch (e) {
      log("Error during logout: $e");
    }
  }

  static Future<void> _restorePersistentData(Map<String, dynamic> data) async {
    if (data['base_url'] != null && data['base_url'].toString().isNotEmpty) {
      Get.find<LocalStorage>().setString(key: StorageKeys.baseUrl, value: data['base_url']);
    }

    if (data['remember_me'] == true) {
      if (data['email'] != null) {
        Get.find<LocalStorage>().setString(key: StorageKeys.email, value: data['email']);
      }
      if (data['password'] != null) {
        Get.find<LocalStorage>().setString(key: StorageKeys.password, value: data['password']);
      }
      Get.find<LocalStorage>().setBool(key: StorageKeys.rememberMe, value: true);
    }
  }

  static Future<void> clearCredentials() async {
    try {
      Get.find<LocalStorage>().remove(key: StorageKeys.email);
      Get.find<LocalStorage>().remove(key: StorageKeys.password);
      Get.find<LocalStorage>().setBool(key: StorageKeys.rememberMe, value: false);
    } catch (e) {
      log("Error clearing credentials: $e");
    }
  }
}
