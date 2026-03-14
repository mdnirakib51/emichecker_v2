
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'domain/local/preferences/local_storage.dart';
import 'domain/local/preferences/storage_controller.dart';
import 'domain/server/http_client/request_handler.dart';
import 'service/auth/controller/auth_controller.dart';

Future<void> init() async {

  // // ==# Register GetIt services within GetX for further access
  Get.put(RequestHandler(dio: Dio()));
  Get.put(LocalStorage());
  Get.put(LocalStorageController());

  Get.put(AuthController());

}
