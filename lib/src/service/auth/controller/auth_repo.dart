
import '../../../domain/server/http_client/api_helper.dart';
import '../../../domain/server/http_client/app_config.dart';
import '../model/auth_model.dart';
import '../model/holyday_model.dart';
import '../model/mediums_model.dart';
import '../model/sessions_model.dart';
import '../model/shifts_model.dart';

class AuthRepository extends ApiHelper {

  Future<AuthModel> reqLogIn({
    required String email,
    required String password
  }) async {

    Map<String, dynamic> params = {};
    params['email'] = email;
    params['password'] = password;

    final response = await requestHandler.postWrp(AppConfig.logInUrl.url, params, isFormData: true);
    if(response.code == 200 || response.code == 201){
      return AuthModel.fromJson(response.data ?? {});
    }

    throw Exception('Login failed with code ${response.code}: ${response.message}');
  }

  Future<List<SessionsModel>> getSessionsList() async {
    final response = await requestHandler.getWrp(AppConfig.sessionsUrl.url);
    if(response.code == 200 || response.code == 201){
      if (response.data is List) {
        return (response.data as List).map((categoryJson) => SessionsModel.fromJson(categoryJson)).toList();
      } else {
        return [];
      }
    }

    throw Exception('Response failed with code ${response.code}: ${response.message}');
  }

  Future<List<ShiftsModel>> getShiftsList() async {
    final response = await requestHandler.getWrp(AppConfig.shiftsUrl.url);
    if(response.code == 200 || response.code == 201){
      if (response.data is List) {
        return (response.data as List).map((categoryJson) => ShiftsModel.fromJson(categoryJson)).toList();
      } else {
        return [];
      }
    }

    throw Exception('Response failed with code ${response.code}: ${response.message}');
  }

  Future<List<MediumsModel>> getMediumsList() async {
    final response = await requestHandler.getWrp(AppConfig.mediumsUrl.url);
    if(response.code == 200 || response.code == 201){
      if (response.data is List) {
        return (response.data as List).map((categoryJson) => MediumsModel.fromJson(categoryJson)).toList();
      } else {
        return [];
      }
    }

    throw Exception('Response failed with code ${response.code}: ${response.message}');
  }

  Future<HolyDayModel> getHolyDayView() async {
    final response = await requestHandler.getWrp(AppConfig.holyDayUrl.url);
    if(response.code == 200 || response.code == 201){
      return HolyDayModel.fromJson(response.data ?? {});
    }
    throw Exception('Response failed with code ${response.code}: ${response.message}');
  }

}
