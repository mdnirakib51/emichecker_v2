
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../global/utils/show_toast.dart';
import '../../../service/auth/controller/auth_service.dart';

class ApiChecker {
  static void checkApi(Response response) {
    if(response.statusCode == 400 || response.statusCode == 401 || response.statusCode == 403 || response.statusCode == 404) {
      showCustomSnackBar(response.data['message']);
    } else if(response.statusCode == 200 || response.statusCode == 201){
      showCustomSnackBar(response.data['message'], isError: false);
    } else {
      showCustomSnackBar(response.data['message'].toString());
    }
  }
}

// class ApiCheckerDec {
//   static void checkApi(int statusCode, String message) {
//     if(statusCode == 401 || statusCode == 403 || statusCode == 404) {
//       showCustomSnackBar(message, icon: Icons.info);
//     } else if(statusCode == 400){
//       showCustomSnackBar(message, icon: Icons.info);
//     } else if(statusCode == 200 || statusCode == 201){
//       showCustomSnackBar(message, icon: Icons.check_circle, isError: false);
//     } else {
//       showCustomSnackBar(message);
//     }
//   }
// }

class ApiCheckerDec {
  static void checkApi(int statusCode, String message) async {
    if(statusCode == 401 || statusCode == 403 || statusCode == 404) {
      showCustomSnackBar(message, icon: Icons.info);
    } else if(statusCode == 400){
      showCustomSnackBar(message, icon: Icons.info);
    } else if(statusCode == 500){
      await AuthService.performLogout();
      showCustomSnackBar(message, icon: Icons.info);
    } else if(statusCode == 200 || statusCode == 201){
      showCustomSnackBar(message, icon: Icons.check_circle, isError: false);
    } else {
      showCustomSnackBar(message);
    }
  }
}
