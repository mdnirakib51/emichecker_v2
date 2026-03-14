
import 'dart:developer';
import 'package:get/get.dart';
import '../../../global/constants/enum.dart';
import '../../local/preferences/local_storage.dart';
import '../../local/preferences/local_storage_keys.dart';

enum AppConfig {
  base,
  baseImage,
  logInUrl,
  logOutUrl,
  sessionsUrl,
  shiftsUrl,
  mediumsUrl,
  holyDayUrl,

  // =@ Student
  studentDashboardUrl,
  studentUpdateUrl,
  studentNoticeUrl,
  studentChangePasswordUrl,
  studentAttendanceUrl,
  studentFeeListUrl,
  studentLedgerUrl,
  studentSubjectUrl,
  studentLibraryListUrl,
  studentClassTeacherUrl,
  studentClassRoutineUrl,
  studentExamUrl,
  studentExamRoutineUrl,
  studentExamResultUrl,
  studentContentUrl,

  // =@ Teacher
  teacherDashboardUrl,
  teacherUpdateUrl,
  teacherNoticeUrl,
  teacherChangePasswordUrl,
  teacherAttendanceClassesUrl,
  teacherAttendanceGroupUrl,
  teacherAttendanceSectionUrl,
  teacherSearchStudentsAttendanceUrl,
  studentAttendanceSubmitUrl,
  teacherStudentsAttendanceViewUrl,
  teacherClassRoutineUrl,

  // =@ Teacher Mark
  teacherMarkClassesUrl,
  teacherMarkGroupUrl,
  teacherMarkSectionUrl,
  teacherMarkExamUrl,
  teacherMarkUnpublishExamUrl,
  teacherMarkSubjectUrl,
  teacherSearchStudentsMarkUrl,
  teacherStudentMarkSubmitUrl,
  teacherStudentsMarkViewUrl,

  teacherAllClassesUrl,
  teacherAllGroupUrl,
  teacherContentUrl,
  teacherContentCreateUrl,
  teacherContentUpdateUrl,
  teacherContentDeleteUrl,
}

extension AppUrlExtention on AppConfig {
  static String _baseUrl = "";

  // Method to set predefined URLs
  static void setUrl(UrlLink urlLink) {
    switch (urlLink) {
      case UrlLink.isLive:
        _baseUrl = "";
        break;
      case UrlLink.isDev:
        _baseUrl = ""; // Default dev URL
        break;
      case UrlLink.isLocalServer:
        _baseUrl = "";
        break;
    }
  }

  // Method to set custom URL from user input
  static void setCustomUrl(String customUrl) {
    if (!customUrl.startsWith('http://') && !customUrl.startsWith('https://')) {
      customUrl = 'https://$customUrl';
    }
    if (customUrl.endsWith('/')) {
      customUrl = customUrl.substring(0, customUrl.length - 1);
    }

    _baseUrl = customUrl;
  }

  static void initializeUrl({UrlLink defaultUrlLink = UrlLink.isDev}) {
    try {
      final String? savedBaseUrl = Get.find<LocalStorage>().getString(key: StorageKeys.baseUrl);

      if (savedBaseUrl != null && savedBaseUrl.isNotEmpty) {
        setCustomUrl(savedBaseUrl);
        log("Using saved URL: $savedBaseUrl");
      } else {
        setUrl(defaultUrlLink);
        log("Using default URL for: $defaultUrlLink");
      }
    } catch (e) {
      setUrl(defaultUrlLink);
      log("Error loading saved URL, using default: $e");
    }
  }

  // Getter to retrieve current base URL
  static String get baseUrl => _baseUrl;

  String get url {
    switch (this) {
      case AppConfig.base:
        return _baseUrl;
      case AppConfig.baseImage:
        return "";
    /// ==========/@ Auth Api Url @/==========
      case AppConfig.logInUrl:
        return '/api/login';
      case AppConfig.logOutUrl:
        return '/api/logout';

    /// ==========/@ Global Api Url @/==========
      case AppConfig.sessionsUrl:
        return '/api/sessions';
      case AppConfig.shiftsUrl:
        return '/api/shifts';
      case AppConfig.mediumsUrl:
        return '/api/mediums';
      case AppConfig.holyDayUrl:
        return '/api/holiday';

    /// ==========/@ Student Url @/==========
      case AppConfig.studentDashboardUrl:
        return '/api/student/dashboard';
      case AppConfig.studentUpdateUrl:
        return '/api/student/profile-update';
      case AppConfig.studentNoticeUrl:
        return '/api/student/notices';
      case AppConfig.studentChangePasswordUrl:
        return '/api/student/change-password';
      case AppConfig.studentAttendanceUrl:
        return '/api/student/attendance';
      case AppConfig.studentFeeListUrl:
        return '/api/student/fee-list';
      case AppConfig.studentLedgerUrl:
        return '/api/student/ledger';
      case AppConfig.studentLibraryListUrl:
        return '/api/student/library';
      case AppConfig.studentSubjectUrl:
        return '/api/student/subject-list';
      case AppConfig.studentClassTeacherUrl:
        return '/api/student/class-teacher';
      case AppConfig.studentClassRoutineUrl:
        return '/api/student/class-routine';
      case AppConfig.studentExamUrl:
        return '/api/student/exams';
      case AppConfig.studentExamRoutineUrl:
        return '/api/student/show_exam_routine';
      case AppConfig.studentExamResultUrl:
        return '/api/student/result';
      case AppConfig.studentContentUrl:
        return '/api/student/web-download';

    /// ==========/@ Teacher Attendance Url @/==========
      case AppConfig.teacherDashboardUrl:
        return '/api/teacher/dashboard';
      case AppConfig.teacherUpdateUrl:
        return '/api/teacher/profile-update';
      case AppConfig.teacherNoticeUrl:
        return '/api/teacher/notices';
      case AppConfig.teacherChangePasswordUrl:
        return '/api/teacher/change-password';
      case AppConfig.teacherAttendanceClassesUrl:
        return '/api/teacher/get-attendance-classes';
      case AppConfig.teacherAttendanceGroupUrl:
        return '/api/teacher/get-groups-teacher';
      case AppConfig.teacherAttendanceSectionUrl:
        return '/api/teacher/get-sections-teacher';
      case AppConfig.teacherSearchStudentsAttendanceUrl:
        return '/api/teacher/student-attendance-details';
      case AppConfig.studentAttendanceSubmitUrl:
        return '/api/teacher/student-attendance-save';
      case AppConfig.teacherStudentsAttendanceViewUrl:
        return '/api/teacher/monthly-attendance-view';
      case AppConfig.teacherClassRoutineUrl:
        return '/api/teacher/class-routine';

    /// ==========/@ Teacher Mark Url @/==========
      case AppConfig.teacherMarkClassesUrl:
        return '/api/teacher/subject-classes';
      case AppConfig.teacherMarkGroupUrl:
        return '/api/teacher/get-groups-filtered-subject-wise';
      case AppConfig.teacherMarkSectionUrl:
        return '/api/teacher/get-sections-filtered-subject-wise';
      case AppConfig.teacherMarkExamUrl:
        return '/api/teacher/get-exams';
      case AppConfig.teacherMarkUnpublishExamUrl:
        return '/api/teacher/getUnpublishedExams';
      case AppConfig.teacherMarkSubjectUrl:
        return '/api/teacher/get-subjects';
      case AppConfig.teacherSearchStudentsMarkUrl:
        return '/api/teacher/mark-entry-view';
      case AppConfig.teacherStudentMarkSubmitUrl:
        return '/api/teacher/mark-entry-save';
      case AppConfig.teacherStudentsMarkViewUrl:
        return '/api/teacher/mark-sheet';

      case AppConfig.teacherAllClassesUrl:
        return '/api/teacher/getClasses';
      case AppConfig.teacherAllGroupUrl:
        return '/api/teacher/getGroups';
      case AppConfig.teacherContentUrl:
        return '/api/teacher/web-download';
      case AppConfig.teacherContentCreateUrl:
        return '/api/teacher/web-download-store';
      case AppConfig.teacherContentUpdateUrl:
        return '/api/teacher/web-download-update';
      case AppConfig.teacherContentDeleteUrl:
        return '/api/teacher/web-download-delete';
    }
  }
}