
import 'dart:convert';
import 'dart:developer' show log;
import 'dart:math' show min;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide Response, FormData;
import 'package:dio/dio.dart';
import '../../../global/utils/show_toast.dart';
import '../../local/preferences/local_storage.dart';
import '../../local/preferences/local_storage_keys.dart';
import '../../local/preferences/storage_controller.dart';
import 'api_check.dart';
import 'app_config.dart';
import 'response_wrapper.dart';

class RequestHandler extends GetxController {
  RequestHandler({
    required Dio dio,
  })  : _dio = dio;

  final mainUrl = AppConfig.base.url;
  final storageController = LocalStorageController.current;

  final Dio _dio;
  Dio get dio => _dio;

  void _initialize() {
    final currentToken = Get.find<LocalStorage>().getString(key: StorageKeys.accessToken);

    if (currentToken != null) {
      log("==/@ Access Token: $currentToken");
      _updateDioHeaders(token: currentToken);
    } else{
      log("Token Not Found!! $currentToken");
    }
  }

  void _updateDioHeaders({required String? token}) {
    dio.options.headers['Authorization'] = 'Bearer $token';
    dio.options.headers['Connection'] = 'keep-alive';
  }

  Future<void> updateHeader({required String token}) async {
    storageController.saveUserToken(token);

    log("#UpdatedHeader: ৳TOKEN => ${storageController.accessToken}");
    _updateDioHeaders(token: storageController.accessToken);
  }

  Future<void> updateStore({int? storeId}) async {
    Get.find<LocalStorage>().setInt(key: StorageKeys.storeId, value: storeId);
  }

  Future<ResponseWrapper> postWrp(
      String url,
      dynamic params, {
        bool? isFormData = false,
        String? errorMsg,
        String? baseUrl,
        Options? options,
        Map<String, dynamic>? queryParams,
      }) async {
    _initialize();
    printTest(" === Start API Request === ");

    try {

      final formData = FormData.fromMap(params);

      final response = await dio.post(
        baseUrl ?? mainUrl + url,
        data: isFormData == true ? formData : params,
        queryParameters: queryParams,
        options: options,
      );

      debugPrint("""
==/@
    Message: "Success.."
    Method: "#POST"
    Url: ${response.realUri}
    ${isFormData == true ? "Form " : ''}Params: $params
    Headers: ${dio.options.headers.toString()}
    StatusCode: ${response.statusCode}
    Response Data: ${response.data}
==/@
""");

      // Check if the response data is a string and parse it if necessary
      final Map<String, dynamic> responseData = response.data is String
          ? jsonDecode(response.data)
          : response.data;

      ResponseWrapper resWrp = ResponseWrapper.fromJson(responseData);

      ApiCheckerDec.checkApi(responseData['code'], responseData['message']);
      return resWrp;
    } on DioException catch (error, stackTrace) {
      Map<String, dynamic> responseData;
      try {
        responseData = error.response?.data is String
            ? jsonDecode(error.response?.data)
            : error.response?.data ?? {'code': error.response?.statusCode, 'message': error.message};
      } catch (e) {
        responseData = {
          'code': error.response?.statusCode,
          'message': error.message
          // 'message': 'Received non-JSON response: ${error.response?.data?.toString().substring(0, 100)}...'
        };
      }

      throw RequestException(
        method: "/POST",
        url: baseUrl ?? mainUrl + url,
         statusCode: responseData['code'],
         message: responseData['message'],
         data: params,
         error: error,
         trace: stackTrace,
         res: error.response,
         errorMsg: error.message,
      );
    } catch (error, stackTrace) {
      throw RequestException(
        method: "/POST",
        url: baseUrl ?? mainUrl + url,
        message: errorMsg,
        data: params,
        error: error,
        trace: stackTrace,
      );
    }
  }

  Future<ResponseWrapper> getWrp(
      String url, {
        dynamic params,
        String? errorMsg,
        String? baseUrl,
        Options? options,
        Map<String, dynamic>? queryParams,
      }) async {
    _initialize();
    printTest(" === Start API GET Request === ");

    try {
      // Making the GET request
      final response = await dio.get(
        baseUrl ?? mainUrl + url,
        data: params,
        queryParameters: queryParams,
        options: options,
      );

      debugPrint("""
==/@
    Message: "Success.."
    Method: "#GET"
    Url: ${response.realUri}
    Params: $params
    Headers: ${dio.options.headers.toString()}
    StatusCode: ${response.statusCode}
    Response Data: ${response.data}
==/@
""");

      // Check if the response data is a string and parse it if necessary
      final Map<String, dynamic> responseData = response.data is String
          ? jsonDecode(response.data)
          : response.data;

      // Wrapping the response data into ResponseWrapper
      ResponseWrapper resWrp = ResponseWrapper.fromJson(responseData);

      return resWrp;
    } on DioException catch (error, stackTrace) {
      Map<String, dynamic> responseData;
      try {
        responseData = error.response?.data is String
            ? jsonDecode(error.response?.data)
            : error.response?.data ?? {'code': error.response?.statusCode, 'message': error.message};
      } catch (e) {
        responseData = {
          'code': error.response?.statusCode,
          'message': error.message
          // 'message': 'Received non-JSON response: ${error.response?.data?.toString().substring(0, 100)}...'
        };
      }

      throw RequestException(
        method: "/GET",
        url: baseUrl ?? mainUrl + url,
        statusCode: responseData['code'],
        message: responseData['message'],
        data: params,
        error: error,
        trace: stackTrace,
        res: error.response,
        errorMsg: error.message,
      );
    } catch (error, stackTrace) {
      throw RequestException(
        method: "/GET",
        url: baseUrl ?? mainUrl + url,
        message: errorMsg,
        data: params,
        error: error,
        trace: stackTrace,
      );
    }
  }

  Future<ResponseWrapper> putWrp(
      String url,
      dynamic params, {
        bool? isFormData = false,
        String? errorMsg,
        String? baseUrl,
        Options? options,
        Map<String, dynamic>? queryParams,
      }) async {
    _initialize();
    printTest(" === Start API PUT Request === ");

    try {
      final formData = FormData.fromMap(params);

      final response = await dio.put(
        baseUrl ?? mainUrl + url,
        data: isFormData == true ? formData : params,
        queryParameters: queryParams,
        options: options,
      );

      debugPrint("""
==/@
    Message: "Success.."
    Method: "#PUT"
    Url: ${response.realUri}
    Params: $params
    Headers: ${dio.options.headers.toString()}
    StatusCode: ${response.statusCode}
    Response Data: ${response.data}
==/@
""");

      final Map<String, dynamic> responseData = response.data is String
          ? jsonDecode(response.data)
          : response.data;

      ResponseWrapper resWrp = ResponseWrapper.fromJson(responseData);

      ApiCheckerDec.checkApi(responseData['code'], responseData['message']);
      return resWrp;
    } on DioException catch (error, stackTrace) {
      Map<String, dynamic> responseData;
      try {
        responseData = error.response?.data is String
            ? jsonDecode(error.response?.data)
            : error.response?.data ?? {'code': error.response?.statusCode, 'message': error.message};
      } catch (e) {
        responseData = {
          'code': error.response?.statusCode,
          'message': error.message
          // 'message': 'Received non-JSON response: ${error.response?.data?.toString().substring(0, 100)}...'
        };
      }

      throw RequestException(
        method: "/PUT",
        url: baseUrl ?? mainUrl + url,
        statusCode: responseData['code'],
        message: responseData['message'],
        data: params,
        error: error,
        trace: stackTrace,
        res: error.response,
        errorMsg: error.message,
      );
    } catch (error, stackTrace) {
      throw RequestException(
        method: "/PUT",
        url: baseUrl ?? mainUrl + url,
        message: errorMsg,
        data: params,
        error: error,
        trace: stackTrace,
      );
    }
  }

  Future<ResponseWrapper> deleteWrp(
      String url, {
        dynamic params,
        String? errorMsg,
        String? baseUrl,
        Options? options,
        Map<String, dynamic>? queryParams,
      }) async {
    _initialize();
    printTest(" === Start API DELETE Request === ");

    try {

      final response = await dio.delete(
        baseUrl ?? mainUrl + url,
        data: params,
        queryParameters: queryParams,
        options: options,
      );

      debugPrint("""
==/@
    Message: "Success.."
    Method: "#DELETE"
    Url: ${response.realUri}
    Params: $params
    Headers: ${dio.options.headers.toString()}
    StatusCode: ${response.statusCode}
    Response Data: ${response.data}
==/@
""");

      final Map<String, dynamic> responseData = response.data is String
          ? jsonDecode(response.data)
          : response.data;

      ResponseWrapper resWrp = ResponseWrapper.fromJson(responseData);

      ApiCheckerDec.checkApi(responseData['code'], responseData['message']);
      return resWrp;
    } on DioException catch (error, stackTrace) {
      Map<String, dynamic> responseData;
      try {
        responseData = error.response?.data is String
            ? jsonDecode(error.response?.data)
            : error.response?.data ?? {'code': error.response?.statusCode, 'message': error.message};
      } catch (e) {
        responseData = {
          'code': error.response?.statusCode,
          'message': error.message
          // 'message': 'Received non-JSON response: ${error.response?.data?.toString().substring(0, 100)}...'
        };
      }

      throw RequestException(
        method: "/DELETE",
        url: baseUrl ?? mainUrl + url,
        statusCode: responseData['code'],
        message: responseData['message'],
        data: params,
        error: error,
        trace: stackTrace,
        res: error.response,
        errorMsg: error.message,
      );
    } catch (error, stackTrace) {
      throw RequestException(
        method: "/DELETE",
        url: baseUrl ?? mainUrl + url,
        message: errorMsg,
        data: params,
        error: error,
        trace: stackTrace,
      );
    }
  }

}

class RequestException implements Exception {
  String method;
  String url;
  int? statusCode;
  String? message;
  Object error;
  Response? res;
  StackTrace trace;
  dynamic data;
  String? errorMsg;

  RequestException({
    required this.method,
    required this.url,
    this.statusCode,
    this.message,
    required this.error,
    this.res,
    this.data,
    required this.trace,
    this.errorMsg
  }) {
    try {
      ApiCheckerDec.checkApi(statusCode ?? 0, message?.toString() ?? "Unknown error");
    } catch (e) {
      // Handle any errors from ApiCheckerDec
    }

    printTest("=== Request Exception ===");
    log(
      """
==/@
    Method: $method
    Url: $url
    StatusCode: $statusCode
    Message: $message
    Params: ${data.toString()}
    Response: ${res?.data.toString().substring(0, min(100, (res?.data.toString().length ?? 0)))}...
    ErrorMsg: "$errorMsg"
==/@
""",
      name: "#RequestException",
      time: DateTime.now(),
      error: error,
      stackTrace: trace,
    );
  }
}