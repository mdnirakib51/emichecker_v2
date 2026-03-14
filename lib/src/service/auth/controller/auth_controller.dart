
import 'dart:developer';
import 'package:get/get.dart';
import '../../../domain/local/preferences/storage_controller.dart';
import '../model/auth_model.dart';
import '../model/holyday_model.dart';
import '../model/mediums_model.dart';
import '../model/sessions_model.dart';
import '../model/shifts_model.dart';
import 'auth_repo.dart';

class AuthController extends GetxController implements GetxService {
  static AuthController get current => Get.find();
  final AuthRepository repository = AuthRepository();
  final storageController = LocalStorageController.current;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _hasError = false;
  bool get hasError => _hasError;

  // Helper method to set loading state
  void _setLoadingState(bool isLoading) {
    _isLoading = isLoading;
    _hasError = false;
    update();
  }

  // Helper method to set error state
  void _setErrorState(bool hasError) {
    _isLoading = false;
    _hasError = hasError;
    update();
  }

  // =/@ LogIn Method
  AuthModel? authModel;
  Future reqLogIn({
    required String email,
    required String password,
  }) async {
    try {
      _setLoadingState(true);

      final response = await repository.reqLogIn(email: email, password: password);

      repository.requestHandler.updateHeader(token: response.token ?? "");
      storageController.saveRole(response.role ?? "");
      // locator<LocalStorage>().setInt(key: StorageKeys.storeId, value: response.storeUser?.storeId ?? 0);
      // locator<LocalStorage>().setInt(key: StorageKeys.branchId, value: 1);
      authModel = response;

      if(authModel != null){
        // Get.offAll(() => DashboardBottomNavigationBar());
      }

      _isLoading = false;
      update();
    } catch (e, s) {
      log('Error: ', error: e, stackTrace: s);
      _setErrorState(true);
    }
  }

  List<SessionsModel>? sessionsListData;

  List<String>? sessionsDropList;
  String selectSessionsId = "Select One";
  String selectSessions = "Select One";
  int selectSessionsIndex = -1;

  Future<void> removeSessions() async {
    selectSessionsId = "Select One";
    selectSessions = "Select One";
    selectSessionsIndex = -1;
  }

  Future getSessionsList() async {
    try {
      _setLoadingState(true);
      removeSessions();
      sessionsDropList = [];

      final response = await repository.getSessionsList();

      sessionsListData = response;
      sessionsDropList = sessionsListData?.map((item) => item.year ?? '').toList();

      if (sessionsListData != null && (sessionsListData?.isNotEmpty ?? false)) {
        selectSessionsId = sessionsListData?.first.id.toString() ?? "";
        selectSessions = sessionsListData?.first.year ?? '';
        selectSessionsIndex = 0;
      }

      _isLoading = false;
      update();
    } catch (e, s) {
      log('Error: ', error: e, stackTrace: s);
      _setErrorState(true);
    }
  }

  List<ShiftsModel>? shiftsListData;

  List<String>? shiftsDropList;
  String selectShiftsId = "Select One";
  String selectShifts = "Select One";
  int selectShiftsIndex = -1;

  Future<void> removeShifts() async {
    selectShiftsId = "Select One";
    selectShifts = "Select One";
    selectShiftsIndex = -1;
  }

  Future getShiftsList() async {
    try {
      _setLoadingState(true);
      removeShifts();
      shiftsDropList = [];

      final response = await repository.getShiftsList();

      shiftsListData = response;
      shiftsDropList = shiftsListData?.map((item) => item.shiftName ?? '').toList();

      if (shiftsListData != null && (shiftsListData?.isNotEmpty ?? false)) {
        selectShiftsId = shiftsListData?.first.id.toString() ?? "";
        selectShifts = shiftsListData?.first.shiftName ?? '';
        selectShiftsIndex = 0;
      }

      _isLoading = false;
      update();
    } catch (e, s) {
      log('Error: ', error: e, stackTrace: s);
      _setErrorState(true);
    }
  }

  List<MediumsModel>? mediumsListData;

  List<String>? mediumsDropList;
  String selectMediumsId = "Select One";
  String selectMediums = "Select One";
  int selectMediumsIndex = -1;

  Future<void> removeMediums() async {
    selectMediumsId = "Select One";
    selectMediums = "Select One";
    selectMediumsIndex = -1;
  }

  Future getMediumsList() async {
    try {
      _setLoadingState(true);
      removeMediums();
      mediumsDropList = [];

      final response = await repository.getMediumsList();

      mediumsListData = response;
      mediumsDropList = mediumsListData?.map((item) => item.mediumName ?? '').toList();

      if (mediumsListData != null && (mediumsListData?.isNotEmpty ?? false)) {
        selectMediumsId = mediumsListData?.first.id.toString() ?? "";
        selectMediums = mediumsListData?.first.mediumName ?? '';
        selectMediumsIndex = 0;
      }

      _isLoading = false;
      update();
    } catch (e, s) {
      log('Error: ', error: e, stackTrace: s);
      _setErrorState(true);
    }
  }

  HolyDayModel? holyDayModel;
  Future getHolyDayView() async {
    try {
      _setLoadingState(true);

      final response = await repository.getHolyDayView();

      holyDayModel = response;

      _isLoading = false;
      update();
    } catch (e, s) {
      log('Error: ', error: e, stackTrace: s);
      _setErrorState(true);
    }
  }

}
