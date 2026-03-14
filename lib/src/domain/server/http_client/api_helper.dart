
import 'package:get/get.dart';
import '../../local/preferences/storage_controller.dart';
import 'request_handler.dart';

abstract class ApiHelper{
  final requestHandler = Get.find<RequestHandler>();
  final storageController = Get.find<LocalStorageController>();
}