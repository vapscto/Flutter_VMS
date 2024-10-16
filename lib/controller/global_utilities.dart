import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_ip_address/get_ip_address.dart';
import 'package:m_skool_flutter/apis/version_control_api.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/categories_api_item.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/screens/attachment_viewer.dart';
import 'package:m_skool_flutter/vms/Purchase_indent/screen/purchase_home.dart';
import 'package:m_skool_flutter/vms/Purchase_requisition/screen/purchase_home.dart';
import 'package:m_skool_flutter/vms/checkbook_approval/screen/cheque_approval.dart';
import 'package:m_skool_flutter/vms/gps/screen/gps_home.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_approval/screens/planner_approval_home.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_creation/screens/planner_create.dart';
import 'package:m_skool_flutter/vms/online_leave/screen/online_leave_home.dart';
import 'package:m_skool_flutter/vms/punch_report/screens/punch_report_home.dart';
import 'package:m_skool_flutter/vms/salary_slip/screen/salary_slip_home.dart';
import 'package:m_skool_flutter/vms/staff_leave_approval/screen/staff_leave_approval_home.dart';
import 'package:m_skool_flutter/vms/visitor%20managements/Screen/visitor_screen.dart';
import 'package:m_skool_flutter/vms/maker%20and%20checker/screen/home_screen.dart';
import 'package:m_skool_flutter/vms/petty_cash_approval/screen/pc_approval_HOME.dart';
import 'package:m_skool_flutter/vms/petty_cash_requisition/screen/pc_requisition_HOME.dart';
import 'package:m_skool_flutter/vms/sales_report/screens/sales_report_home_screen.dart';
import 'package:m_skool_flutter/vms/security/screen/Shome_Screen.dart';
import 'package:m_skool_flutter/vms/tadaModule/screens/tada_show_screen.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_advance_apply/screens/tada_advance_aplay_home.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_apply_module/screens/tada_apply_home_screen.dart';
import 'package:m_skool_flutter/vms/task%20creation/screens/taskCreationHome.dart';
import 'package:m_skool_flutter/vms/widgets/video_screen.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';

RxInt currentHomeTab = 0.obs;
RxList<int> previousHomeTab = [0].obs;
RxBool isPageLoading = false.obs;
RxString mobileNumber = "".obs;
RxString passWord = "".obs;
RxInt currentAuthTab = 0.obs;
RxInt currentTab = 0.obs;
Dio? dio;

Dio getGlobalDio() {
  dio ??= Dio();
  return dio!;
}

final IpAddress ipAddress = IpAddress(type: RequestType.json);

dynamic getIpAddress() async {
  return await ipAddress.getIpAddress();
}

Future<String> getMac() async {
  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  BaseDeviceInfo baseDeviceInfo = await deviceInfoPlugin.deviceInfo;
  logger.d(baseDeviceInfo.data);
  String model = baseDeviceInfo.data['model'];
  String? identifier = "";
  if (Platform.isIOS) {
    identifier = baseDeviceInfo.data['identifierForVendor'];
    identifier ??= "";
  }
  // String macAddress = await GetMac.macAddress;
  return Platform.isAndroid ? model : identifier;
}

Future<bool> checkConnectivity() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    return true;
  }
  return false;
}

Map<String, String> getSession() {
  Map<String, String> header = {
    "Cookie": cookieBox!.get("cookie") ?? "",
  };
  return header;
}

// Map<String,dynamic> getInsSession(){
//   Map<String, dynamic> header = {
//     "cookie": cookieBox!.get("session"),
//   };
//   return header;
// }

DateTime getDateTimeFromSeconds(
  int seconds,
) {
  return DateTime.fromMillisecondsSinceEpoch(seconds * 1000);
}

// String getTimeFromSecond(int seconds, {bool withTime = false}) {
//   String time = "";
//   time =
//       "${(withTime) ? DateTime.fromMillisecondsSinceEpoch(seconds * 1000).hour : ""}${(withTime) ? ":" : ""}${(withTime) ? numberList.elementAt(DateTime.fromMillisecondsSinceEpoch(seconds * 1000).minute) : ""}${(withTime) ? "," : ""}${DateTime.fromMillisecondsSinceEpoch(seconds * 1000).day} ${months.elementAt(DateTime.fromMillisecondsSinceEpoch(seconds * 1000).month - 1)} ${DateTime.fromMillisecondsSinceEpoch(seconds * 1000).year}";
//   return time;
// }

toCapitalized(String value) {
  return value.capitalize;
}

String baseUrlFromInsCode(String pageName, MskoolController mskoolController) {
  for (int i = 0;
      i < mskoolController.universalInsCodeModel!.value.apiarray.values.length;
      i++) {
    final CategoriesApiItem api = mskoolController
        .universalInsCodeModel!.value.apiarray.values
        .elementAt(i);
    if (api.iivrscurLAPIName.toLowerCase() == pageName) {
      return api.iivrscurLAPIURL;
    }
  }
  return "";
}

String getDashBoardIconByName(String title) {
  String returnValue = "assets/images/";
  switch (title) {
    case "Attendance":
      returnValue += "Attendance.png";
      break;
    case "Fee Details":
      returnValue += "FeeReceipt.png";
      break;
    case "Fee Payment":
      returnValue += "OnlinePayment.png";
      break;
    case "Fee Analysis":
      returnValue += "FeeAnalysis.png";
      break;
    case "Classwork":
      returnValue += "Classwork.png";
      break;
    case "Homework":
      returnValue += "Homework.png";
      break;
    case "COE":
      returnValue += "Coe.png";
      break;
    case "Notice Board":
      returnValue += "Noticeboard.png";
      break;
    case "Library":
      returnValue += "Library.png";
      break;
    case "Syllabus":
      returnValue += "Attendance.png";
      break;
    case "Exam":
      returnValue += "exam.png";
      break;
    case "Interaction":
      returnValue += "Interaction.png";
      break;
    case "Certificate":
      returnValue += "Certificate.png";
      break;
    case "Time Table":
      returnValue += "Timetable.png";
      break;
    case "Fee Receipt":
      returnValue += "FeeReceipt.png";
      break;
    default:
      returnValue += "Timetable.png";
  }
  return returnValue;
}

String getStaffDashboardIcon(String pageName) {
  String icon = "assets/images/";

  if (pageName.toLowerCase().contains("entry") &&
      !pageName.toLowerCase().contains("mark")) {
    return icon += "staff_stu_attendance.png";
  }

  if (pageName.toLowerCase().contains("attendance")) {
    return icon += "staff_attendance.png";
  }

  if (pageName.toLowerCase().contains("time")) {
    return icon += "staff_tt.png";
  }

  if (pageName.toLowerCase().contains("mark")) {
    return icon += "staff_me.png";
  }

  if (pageName.toLowerCase().contains("punch")) {
    return icon += "staff_pr.png";
  }

  if (pageName.toLowerCase().contains("salary details")) {
    return icon += "staff_dt.png";
  }

  if (pageName.toLowerCase().contains("homework")) {
    return icon += "staff_hw.png";
  }
  if (pageName.toLowerCase().contains("classwork")) {
    return icon += "staff_classwork.png";
  }
  if (pageName.toLowerCase().contains("notice")) {
    return icon += "staff_nb.png";
  }

  if (pageName.toLowerCase().contains("birth")) {
    return icon += "staff_bday.png";
  }
  if (pageName.toLowerCase().contains("interaction")) {
    return icon += "staff_interaction.png";
  }
  if (pageName.toLowerCase().contains("leave")) {
    return icon += "staff_olp.png";
  }
  if (pageName.toLowerCase().contains("coe")) {
    return icon += "staff_coe.png";
  }

  if (pageName.toLowerCase().contains("slip")) {
    return icon += "FeeReceipt.png";
  }

  return icon += "Timetable.png";
}

String getManagerDashboardIconByName(String pageName) {
  String icon = "assets/images/";

  if (pageName.toLowerCase().contains("student")) {
    return icon += "student_details.png";
  }
  if (pageName.toLowerCase().contains("interaction")) {
    return icon += "staff_interaction.png";
  }
  if (pageName.toLowerCase().contains("leave")) {
    return icon += "staff_olp.png";
  }
  if (pageName.toLowerCase().contains("coe")) {
    return icon += "staff_coe.png";
  }

  if (pageName.toLowerCase().contains("slip")) {
    return icon += "FeeReceipt.png";
  }
  if (pageName.toLowerCase().contains("employee")) {
    return icon += "employee_details.png";
  }
  if (pageName.toLowerCase().contains("fee")) {
    return icon += "manager_fee.png";
  }
  if (pageName.toLowerCase().contains("notice")) {
    return icon += "staff_nb.png";
  }

  return icon += "Timetable.png";
}

String getDashboardIcon(String pageName) {
  String icon = "assets/images/";

  if (pageName.toLowerCase().contains("attendance") ||
      pageName.toLowerCase().contains("syllabus")) {
    return "${icon}Attendance.png";
  }
  if (pageName.toLowerCase().contains("fee")) {
    if (pageName.toLowerCase().contains("analysis")) {
      return "${icon}FeeAnalysis.png";
    }
    if (pageName.toLowerCase().contains("payment")) {
      return "${icon}OnlinePayment.png";
    }
    return "${icon}FeeReceipt.png";
  }

  if (pageName.toLowerCase().contains("classwork")) {
    return "${icon}Classwork.png";
  }

  if (pageName.toLowerCase().contains("homework") ||
      pageName.toLowerCase().contains('planner')) {
    return "${icon}Homework.png";
  }
  if (pageName.toLowerCase().contains("library")) {
    return "${icon}Library.png";
  }

  if (pageName.toLowerCase().contains("exam")) {
    return "${icon}exam.png";
  }
  if (pageName.toLowerCase().contains("certificate")) {
    return "${icon}Certificate.png";
  }
  if (pageName.toLowerCase().contains("entry") &&
      !pageName.toLowerCase().contains("mark")) {
    return icon += "staff_stu_attendance.png";
  }

  if (pageName.toLowerCase().contains("attendance")) {
    return icon += "staff_attendance.png";
  }

  if (pageName.toLowerCase().contains("time")) {
    return icon += "staff_tt.png";
  }

  if (pageName.toLowerCase().contains("mark")) {
    return icon += "staff_me.png";
  }

  if (pageName.toLowerCase().contains("punch")) {
    return icon += "staff_pr.png";
  }

  if (pageName.toLowerCase().contains("salary details")) {
    return icon += "staff_dt.png";
  }

  if (pageName.toLowerCase().contains("homework")) {
    return icon += "staff_hw.png";
  }
  if (pageName.toLowerCase().contains("classwork")) {
    return icon += "staff_classwork.png";
  }
  if (pageName.toLowerCase().contains("notice")) {
    return icon += "staff_nb.png";
  }

  if (pageName.toLowerCase().contains("birth")) {
    return icon += "staff_bday.png";
  }
  if (pageName.toLowerCase().contains("interaction")) {
    return icon += "staff_interaction.png";
  }
  if (pageName.toLowerCase().contains("leave")) {
    return icon += "staff_olp.png";
  }
  if (pageName.toLowerCase().contains("coe")) {
    return icon += "staff_coe.png";
  }

  if (pageName.toLowerCase().contains("slip")) {
    return icon += "FeeReceipt.png";
  }

  if (pageName.toLowerCase().contains("student")) {
    return icon += "student_details.png";
  }
  if (pageName.toLowerCase().contains("interaction")) {
    return icon += "staff_interaction.png";
  }

  if (pageName.toLowerCase().contains("slip")) {
    return icon += "FeeReceipt.png";
  }
  if (pageName.toLowerCase().contains("employee")) {
    return icon += "employee_details.png";
  }
  if (pageName.toLowerCase().contains("fee")) {
    return icon += "manager_fee.png";
  }
  if (pageName.toLowerCase().contains("notice")) {
    return icon += "staff_nb.png";
  }
  return icon += "Timetable.png";
}

Future<void> initializeFCMNotification() async {
  var messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    provisional: false,
    sound: true,
  );
  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    // print('User granted permission');
  } else {
    // print('User declined or has not accepted permission');
  }
}

pushNotificationNavigator({
  required LoginSuccessModel loginSuccessModel,
  required MskoolController mskoolController,
}) async {
  // Get.to(() => NotificationScreen(
  //       loginSuccessModel: loginSuccessModel,
  //       mskoolController: mskoolController,
  //       openFor: loginSuccessModel.roleforlogin!,
  //     ));
}

notificationCallback(
  NotificationResponse details,
) async {
  Map<String, dynamic> subject = jsonDecode(details.payload!);
  logger.d(subject);
  MskoolController mskoolController = Get.find<MskoolController>();
  logger.d('notificationcall back');
  pushNotificationNavigator(
      loginSuccessModel: mskoolController.loginSuccessModel!.value,
      mskoolController: mskoolController);
}

void version(LoginSuccessModel loginSuccessModel,
    MskoolController mskoolController) async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  // String appName = packageInfo.appName;
  // String packageName = packageInfo.packageName;
  String version = packageInfo.version;
  // String buildNumber = packageInfo.buildNumber;

  final bool ctrl = await VersionControlApi.instance.checkVersionAndShowUpgrade(
    miId: loginSuccessModel.mIID!,
    version: version,
    base: baseUrlFromInsCode(
      "portal",
      mskoolController,
    ),
  );

  if (ctrl) {
    Get.dialog(AlertDialog(
      title: const Text("Update App!"),
      content: const Text(
        "We have updated this app with new feature's and several bug fixes, we strongly recommend you to update the app before using",
        style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w400),
      ),
      actions: [
        TextButton(
            onPressed: () async {
              Get.close(1);
            },
            child: const Text("Later")),
        TextButton(
          onPressed: () async {
            Get.close(1);
            if (Platform.isIOS) {
              if (await canLaunchUrl(Uri.parse(URLS.appStorelink))) {
                await launchUrl(Uri.parse(URLS.appStorelink),
                    mode: LaunchMode.externalApplication);
                return;
              }
            }
            if (await canLaunchUrl(Uri.parse(URLS.playStoreLink))) {
              await launchUrl(Uri.parse(URLS.playStoreLink),
                  mode: LaunchMode.externalApplication);
            }
          },
          child: const Text("Update"),
        ),
      ],
    ));
  }
}

void openMappedPages(
  String pageName,
  LoginSuccessModel loginSuccessModel,
  MskoolController mskoolController,
  BuildContext context,
  // HwCwNbController hwCwNbController
) {
  logger.i(pageName);
  if (pageName == "Punch Report") {
    Get.to(() => PunchReport(
          loginSuccessModel: loginSuccessModel,
          mskoolController: mskoolController,
          title: pageName,
        ));
    return;
  }
  if (pageName == "Maker and Checker") {
    Get.to(() => MakerCheckerHome(
          loginSuccessModel: loginSuccessModel,
          mskoolController: mskoolController,
        ));
    return;
  }
  if (pageName == "Cheaque Book Approval") {
    Get.to(() => ChequeApproval(
          loginSuccessModel: loginSuccessModel,
          mskoolController: mskoolController,
        ));
    return;
  }

  if (pageName == "Planner Creation") {
    Get.to(() => PlannerCreateHomeScreen(
          mskoolController: mskoolController,
          loginSuccessModel: loginSuccessModel,
        ));
    return;
  }
  if (pageName == "Salary Slip") {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return SalarySlipHome(
        loginSuccessModel: loginSuccessModel,
        mskoolController: mskoolController,
      );
    }));

    return;
  }
  // if (pageName == "DR Generation") {
  //   Navigator.push(context, MaterialPageRoute(builder: (_) {
  //     return TaskCreationHome(
  //       loginSuccessModel: loginSuccessModel,
  //       mskoolController: mskoolController,
  //     );
  //   }));

  //   return;
  // }
  if (pageName == "TADA Apply") {
    Get.to(() => TadaApplyHomeScreen(
          loginSuccessModel: loginSuccessModel,
          mskoolController: mskoolController,
          previousScreen: 0,
        ));
    return;
  }
  if (pageName == 'TADA Approval') {
    Get.to(() => TadaListScreen(
          loginSuccessModel: loginSuccessModel,
          mskoolController: mskoolController,
        ));
  }
  if (pageName == 'sales and report') {
    Get.to(() => SalesReportHomeScreen(
          loginSuccessModel: loginSuccessModel,
          mskoolController: mskoolController,
        ));
  }
  if (pageName == 'TADA advance apply') {
    Get.to(() => TadaAdvanceApplyScreen(
          loginSuccessModel: loginSuccessModel,
          mskoolController: mskoolController,
        ));
  }
  if (pageName == 'Task Creation') {
    Get.to(() => TaskCreationHome(
          loginSuccessModel: loginSuccessModel,
          mskoolController: mskoolController,
        ));
  }

  ///PETTY CASH ///

  if (pageName == "Petty Cash Approval") {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return PCApprovalHome(
        loginSuccessModel: loginSuccessModel,
        mskoolController: mskoolController,
      );
    }));
  }

  if (pageName == "Cash Request") {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return PCRequisitionHome(
        loginSuccessModel: loginSuccessModel,
        mskoolController: mskoolController,
      );
    }));
  }

  if (pageName == "Petty Cash  Requisition") {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return PCRequisitionHome(
        loginSuccessModel: loginSuccessModel,
        mskoolController: mskoolController,
      );
    }));
  }

  ///////////////

  if (pageName == "Purchase Indent Approval") {
    Get.to(() => PurchaseIndentHome(
          loginSuccessModel: loginSuccessModel,
          mskoolController: mskoolController,
        ));
    return;
  }

  if (pageName == "Purchase Requisition") {
    Get.to(() => PurchaserequisitionHome(
          loginSuccessModel: loginSuccessModel,
          mskoolController: mskoolController,
        ));
    return;
  }
  if (pageName == "Security") {
    Get.to(() => ShomeScreen(
          loginSuccessModel: loginSuccessModel,
          mskoolController: mskoolController,
        ));
    return;
  }

  if (pageName == "GPS attendance") {
    Get.to(() => GpasHomeScreen(
          loginSuccessModel: loginSuccessModel,
          mskoolController: mskoolController,
        ));
    return;
  }

  Widget hSize({required double height}) {
    return SizedBox(
      height: height,
    );
  }

  Widget wSize({required double width}) {
    return SizedBox(
      height: width,
    );
  }

  if (pageName == "Visitor management") {
    Get.to(() => VisitorManagementHome(
          loginSuccessModel: loginSuccessModel,
          mskoolController: mskoolController,
        ));
    return;
  }
  if (pageName == "Leave Approval") {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return StaffLeaveApproval(
        loginSuccessModel: loginSuccessModel,
        mskoolController: mskoolController,
        title: pageName,
      );
    }));
    return;
  }
  if (pageName == "Leave Apply") {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return OnlineLeaveApply(
        loginSuccessModel: loginSuccessModel,
        mskoolController: mskoolController,
        title: pageName,
      );
    }));
    return;
  }
  if (pageName == "Planner Approval") {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return PlannerApprovalHomeScreen(
        loginSuccessModel: loginSuccessModel,
        mskoolController: mskoolController,
        title: pageName,
      );
    }));
    return;
  }
}

bool isWebsite(String url) {
  if (url.endsWith(".pdf") ||
      url.endsWith(".png") ||
      url.endsWith(".jpeg") ||
      url.endsWith(".jpg") ||
      url.endsWith(".other") ||
      url.endsWith(".mp4") ||
      url.endsWith(".txt") ||
      url.endsWith("doc") ||
      url.endsWith(".docx") ||
      url.endsWith(".xls") ||
      url.endsWith(".xlsx") ||
      url.endsWith(".gif") ||
      url.endsWith(".ppt") ||
      url.endsWith(".pptx") ||
      url.endsWith(".")) {
    return false;
  }

  return true;
}

void createPreview(BuildContext context, String url) {
  if (!url.isExcelFileName &&
      !url.isPPTFileName &&
      !url.isPDFFileName &&
      !url.isVideoFileName &&
      !url.isImageFileName &&
      !url.isDocumentFileName &&
      !url.isAudioFileName) {
    launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    return;
  }
  if (url.isVideoFileName) {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return VideoScreen(videoUrl: url);
    }));
  } else {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return AttachmentViewer(
        loadFromRawData: false,
        url: url,
      );
    }));
  }
}
