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
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/categories_api_item.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/screens/attachment_viewer.dart';
import 'package:m_skool_flutter/screens/notification.dart';
import 'package:m_skool_flutter/student/interaction/screen/interaction_home.dart';
import 'package:m_skool_flutter/vms/Purchase_indent/screen/purchase_home.dart';
import 'package:m_skool_flutter/vms/Purchase_requisition/screen/purchase_home.dart';
import 'package:m_skool_flutter/vms/Purchase_requisition/screen/requsition_grid.dart';
import 'package:m_skool_flutter/vms/all_emp_review/emp_review.dart';
import 'package:m_skool_flutter/vms/call_letter/call_letter_home.dart';
import 'package:m_skool_flutter/vms/candidate_interview_list/screen/canidate_home.dart';
import 'package:m_skool_flutter/vms/certificate_approval/certificate_approval.dart';
import 'package:m_skool_flutter/vms/checkbook_approval/screen/cheque_approval.dart';
import 'package:m_skool_flutter/vms/dr_genration/screens/dailyrpt_home.dart';
import 'package:m_skool_flutter/vms/driver_indent/driver_indent_home.dart';
import 'package:m_skool_flutter/vms/employee_punch/screen/employee_sal_home.dart';
import 'package:m_skool_flutter/vms/extension/extension_home_screen.dart';
import 'package:m_skool_flutter/vms/final_tour_approval/screens/final_approval_list.dart';
import 'package:m_skool_flutter/vms/gps/screen/gps_home.dart';
import 'package:m_skool_flutter/vms/health_chequeup/screens/healtha_check_up.dart';
import 'package:m_skool_flutter/vms/hr_modules/interview_report/int_report_home.dart';
import 'package:m_skool_flutter/vms/hr_modules/interview_schdule/interview_schdule.dart';
import 'package:m_skool_flutter/vms/hr_modules/job_posting/job_posting_home.dart';
import 'package:m_skool_flutter/vms/interviewer_feedback/screens/interview_home_screen.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_approval/screens/planner_home_screen.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_creation/screens/planner_create.dart';
import 'package:m_skool_flutter/vms/new_candidate/screen/new_canidate_home.dart';
import 'package:m_skool_flutter/vms/noc_approval/screens/noc_approval_home.dart';
import 'package:m_skool_flutter/vms/online_leave/screen/apply_leave_home.dart';
import 'package:m_skool_flutter/vms/petty_indent_approval/screen/pc_indent_approval_home.dart';
import 'package:m_skool_flutter/vms/punch_report/screens/punch_report_home.dart';
import 'package:m_skool_flutter/vms/rating_report/screen/rating_report_home.dart';
import 'package:m_skool_flutter/vms/salary_details/screen/salary_home_screen.dart';
import 'package:m_skool_flutter/vms/salary_slip/screen/salary_slip_home.dart';
import 'package:m_skool_flutter/vms/staff_leave_approval/screen/leave_list_home.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_a._approval/screens/tada_show_screen.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_approval/screens/tada_approval_home.dart';
import 'package:m_skool_flutter/vms/tada_tour_approval/screens/tada_tour_view.dart';
// import 'package:m_skool_flutter/vms/tada_tour_approval/screens/tada_tour_view.dart';
import 'package:m_skool_flutter/vms/tour_mapping/screen/tour_maping_list.dart';
import 'package:m_skool_flutter/vms/utils/video_screen.dart';
import 'package:m_skool_flutter/vms/visitor%20managements/Screen/visitor_screen.dart';
import 'package:m_skool_flutter/vms/maker%20and%20checker/screen/home_screen.dart';
import 'package:m_skool_flutter/vms/petty_cash_approval/screen/pc_approval_home.dart';
import 'package:m_skool_flutter/vms/petty_cash_requisition/screen/pc_requisition_home.dart';
import 'package:m_skool_flutter/vms/sales_report/screens/sales_report_home_screen.dart';
import 'package:m_skool_flutter/vms/security/screen/shome_screen.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_advance_apply/screens/tada_advance_aplay_home.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_apply_module/screens/tada_apply_home_screen.dart';
import 'package:m_skool_flutter/vms/task%20creation/screens/task_creation_h/task_creation_home.dart';
import 'package:m_skool_flutter/vms/visitor_approval/screen/visitor_home.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';
import '../model/version_change.dart';
import '../vms/hr_modules/add_to_hrms/add_to_hrms_home.dart';

RxInt currentHomeTab = 0.obs;
RxList<int> previousHomeTab = [0].obs;
RxBool isPageLoading = false.obs;
RxString mobileNumber = "".obs;
RxString passWord = "".obs;
RxInt currentAuthTab = 0.obs;
RxInt currentTab = 0.obs;
Dio? dio;
String deviceid = '';
TabController? newController;
List<int> checkedIndex = [];
String latestVersion = '';
TextEditingController numberController = TextEditingController();

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

  if (pageName.toLowerCase().contains('task') ||
      pageName.toLowerCase().contains("call") ||
      pageName.toLowerCase().contains("schedule interview")) {
    return "${icon}Classwork.png";
  }
  if (pageName.toLowerCase().contains('sales')) {
    return "${icon}OnlinePayment.png";
  }
  if (pageName.toLowerCase().contains('planner') ||
      pageName.toLowerCase().contains('dr')) {
    return "${icon}Homework.png";
  }
  if (pageName.toLowerCase().contains("library") ||
      pageName.toLowerCase().contains('petty')) {
    return "${icon}Library.png";
  }

  if (pageName.toLowerCase().contains("exam") ||
      pageName.toLowerCase().contains('tada') ||
      pageName.toLowerCase().contains("candidate list")) {
    return "${icon}exam.png";
  }
  if (pageName.toLowerCase().contains("certificate") ||
      pageName.toLowerCase().contains("noc")) {
    return "${icon}Certificate.png";
  }
  if (pageName.toLowerCase().contains("entry") &&
          !pageName.toLowerCase().contains("mark") ||
      pageName.toLowerCase().contains("job posting")) {
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

  if (pageName.toLowerCase().contains("extension")) {
    return icon += "staff_hw.png";
  }
  if (pageName.toLowerCase().contains("requisition report")) {
    return icon += "staff_classwork.png";
  }
  if (pageName.toLowerCase().contains("notice") ||
      pageName.toLowerCase().contains("interview report")) {
    return icon += "staff_nb.png";
  }

  if (pageName.toLowerCase().contains("birth")) {
    return icon += "staff_bday.png";
  }
  if (pageName.toLowerCase().contains("interaction") ||
      pageName.toLowerCase().contains("add to hrms")) {
    return icon += "staff_interaction.png";
  }
  if (pageName.toLowerCase().contains("leave")) {
    return icon += "staff_olp.png";
  }
  if (pageName.toLowerCase().contains("coe") ||
      pageName.toLowerCase().contains('security')) {
    return icon += "staff_coe.png";
  }

  if (pageName.toLowerCase().contains("slip")) {
    return icon += "FeeReceipt.png";
  }

  if (pageName.toLowerCase().contains("student") ||
      pageName.toLowerCase().contains('maker') ||
      pageName.toLowerCase().contains("schedule list")) {
    return icon += "student_details.png";
  }
  if (pageName.toLowerCase().contains("interaction") ||
      pageName.toLowerCase().contains('visitor')) {
    return icon += "staff_interaction.png";
  }

  if (pageName.toLowerCase().contains("slip")) {
    return icon += "FeeReceipt.png";
  }
  if (pageName.toLowerCase().contains("employee") ||
      pageName.toLowerCase().contains('purchase')) {
    return icon += "employee_details.png";
  }
  if (pageName.toLowerCase().contains('cheaque')) {
    return icon += "manager_fee.png";
  }
  if (pageName.toLowerCase().contains("notice") ||
      pageName.toLowerCase().contains('staff') ||
      pageName.toLowerCase().contains('rating')) {
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
  } else {}
}

pushNotificationNavigator({
  required LoginSuccessModel loginSuccessModel,
  required MskoolController mskoolController,
}) async {
  Get.to(() => NotificationScreen(
        loginSuccessModel: loginSuccessModel,
        mskoolController: mskoolController,
        openFor: loginSuccessModel.roleforlogin!,
      ));
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

  String version = packageInfo.version;
  // latestVersion = version;
  logger.i(version);
  final VersionChangeModel? ctrl =
      await VersionControlApi.instance.checkVersionAndShowUpgrade(
    miId: loginSuccessModel.mIID!,
    version: version,
    base: baseUrlFromInsCode(
      "portal",
      mskoolController,
    ),
  );
  latestVersion = ctrl!.values!.last.iMVEAppVersion ?? '';
  if (ctrl.values!.isNotEmpty) {
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
) {
  logger.i(pageName);
  if (pageName == "DR Generation") {
    Get.to(() => DailyReportGenration(
          loginSuccessModel: loginSuccessModel,
          mskoolController: mskoolController,
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
  if (pageName == "Task Creation") {
    Get.to(() => TaskCreationHome(
          loginSuccessModel: loginSuccessModel,
          mskoolController: mskoolController,
          previousScreen: pageName,
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

  if (pageName == "GPS attendance") {
    Get.to(
      () => GpasHomeScreen(
        loginSuccessModel: loginSuccessModel,
        mskoolController: mskoolController,
      ),
    );
  }

  if (pageName == "Interaction") {
    Get.to(() => InteractionHomeScreen(
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

  if (pageName == "Requisition Report") {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return RequisitionGrid(
        loginSuccessModel: loginSuccessModel,
        mskoolController: mskoolController,
      );
    }));

    return;
  }

  if (pageName == "TADA Apply") {
    Get.to(() => TadaApplyHomeScreen(
          loginSuccessModel: loginSuccessModel,
          mskoolController: mskoolController,
          previousScreen: 0,
        ));
    return;
  }
  if (pageName == 'TADA Advance Approval') {
    Get.to(() => TadaAdvanceApproveScreen(
          loginSuccessModel: loginSuccessModel,
          mskoolController: mskoolController,
        ));
  }
  if (pageName == 'TADA Approval') {
    Get.to(() => TadaApproveHomeScreen(
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

  if (pageName == "Petty Cash Approval") {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return PCApprovalHome(
        loginSuccessModel: loginSuccessModel,
        mskoolController: mskoolController,
      );
    }));
  }

  if (pageName == "Petty Indent Approval") {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return PcIndentApprovalHome(
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

  if (pageName == "Rating Report") {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return RatingReportHome(
        loginSuccessModel: loginSuccessModel,
        mskoolController: mskoolController,
      );
    }));
  }
  if (pageName == "TADA Tour Approval") {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return TadaViewTourView(
        loginSuccessModel: loginSuccessModel,
        mskoolController: mskoolController,
      );
    }));
  }
  if (pageName == "Tour Maping") {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return TourMapingList(
        loginSuccessModel: loginSuccessModel,
        mskoolController: mskoolController,
      );
    }));
  }
  if (pageName == "Leave Apply") {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return ApplyLeaveHomeScreen(
        loginSuccessModel: loginSuccessModel,
        mskoolController: mskoolController,
        title: pageName,
      );
    }));
    return;
  }

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

  if (pageName == "Punch Report") {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return PunchReport(
        loginSuccessModel: loginSuccessModel,
        mskoolController: mskoolController,
        title: pageName,
        previousScreen: '0',
      );
    }));
    return;
  }

  if (pageName == "Visitor management") {
    Get.to(() => VisitorManagementHome(
          loginSuccessModel: loginSuccessModel,
          mskoolController: mskoolController,
        ));
    return;
  }

  if (pageName == "Visitor Approval") {
    Get.to(() => VisitorApprovalHome(
          loginSuccessModel: loginSuccessModel,
          mskoolController: mskoolController,
        ));
    return;
  }

  if (pageName == "Leave Approval") {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return ListLeaveHomeScreen(
        loginSuccessModel: loginSuccessModel,
        mskoolController: mskoolController,
        title: pageName,
      );
    }));
    return;
  }
  if (pageName == "Planner Approval") {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return PlannerApprovalTabScreen(
        loginSuccessModel: loginSuccessModel,
        mskoolController: mskoolController,
      );
    }));
    return;
  }
  if (pageName == 'Salary Details') {
    Get.to(() => SalaryHomeScreen(
        loginSuccessModel: loginSuccessModel,
        mskoolController: mskoolController,
        title: pageName,
        index: 0));
  }

  if (pageName == "Health Checkup") {
    Get.to(
      () => HomeHCheckup(
        loginSuccessModel: loginSuccessModel,
        mskoolController: mskoolController,
      ),
    );
    return;
  }

  if (pageName == "Staff in and Out") {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return EmployeepunchHome(
        loginSuccessModel: loginSuccessModel,
        mskoolController: mskoolController,
      );
    }));
    return;
  }
  if (pageName == "Extension") {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return ExtensionHomeScreen(
        loginSuccessModel: loginSuccessModel,
        mskoolController: mskoolController,
        title: pageName,
      );
    }));
    return;
  }
  if (pageName == "Certificate Approval") {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return CertificateApproval(
        loginSuccessModel: loginSuccessModel,
        mskoolController: mskoolController,
        title: pageName,
      );
    }));
    return;
  }
  if (pageName == "Interview Feedback") {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return InterviewerHomeScreen(
        loginSuccessModel: loginSuccessModel,
        mskoolController: mskoolController,
      );
    }));
    return;
  }
  if (pageName == "Driver Ind. Approval") {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return DriverIndentApproval(
        loginSuccessModel: loginSuccessModel,
        mskoolController: mskoolController,
      );
    }));
    return;
  }
  if (pageName == "Employee Ratings") {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return AllEmpReviewHome(
        loginSuccessModel: loginSuccessModel,
        mskoolController: mskoolController,
      );
    }));
    return;
  }
  if (pageName == "NOC Approval") {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return NocApproval(
        loginSuccessModel: loginSuccessModel,
        mskoolController: mskoolController,
      );
    }));
    return;
  }
  if (pageName == "Add To HRMS") {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return AddToHrmsHome(
        loginSuccessModel: loginSuccessModel,
        mskoolController: mskoolController,
        title: pageName,
      );
    }));
    return;
  }
  if (pageName == "Schedule Interview") {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return InterViewSchduleHome(
        loginSuccessModel: loginSuccessModel,
        mskoolController: mskoolController,
        title: pageName,
      );
    }));
    return;
  }
  if (pageName == "Job Posting") {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return JobPostingHomeScreen(
        loginSuccessModel: loginSuccessModel,
        mskoolController: mskoolController,
        title: pageName,
      );
    }));
    return;
  }

  if (pageName == "Schedule List") {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return CandidateHome(
        loginSuccessModel: loginSuccessModel,
        mskoolController: mskoolController,
      );
    }));
    return;
  }
  //
    if (pageName == "TADA Final Submission") {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return FinalTadaTourApprovalList(
        loginSuccessModel: loginSuccessModel,
        mskoolController: mskoolController,
      );
    }));
    return;
  }
  if (pageName == "Candidate list") {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return NewCandidateHome(
        loginSuccessModel: loginSuccessModel,
        mskoolController: mskoolController,
      );
    }));
    return;
  }

  if (pageName == "Interview Report") {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return InterviewReportHome(
        loginSuccessModel: loginSuccessModel,
        mskoolController: mskoolController,
        title: pageName,
      );
    }));
    return;
  }
  if (pageName == "Call Letter") {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return CallLetterHome(
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

Icon getFileIcon(String fileType) {
  IconData iconData = Icons.insert_drive_file;
  if (fileType.endsWith(".pdf")) {
    iconData = Icons.picture_as_pdf;
  } else if (fileType.endsWith('.doc') || fileType.endsWith('.docx')) {
    iconData = Icons.description;
  } else if (fileType.endsWith('.xls') || fileType.endsWith('.xlsx')) {
    iconData = Icons.table_chart;
  } else if (fileType.endsWith('.ppt') || fileType.endsWith('.pptx')) {
    iconData = Icons.slideshow;
  } else if (fileType.endsWith('.png') ||
      fileType.endsWith('.jpg') ||
      fileType.endsWith('.jpeg')) {
    iconData = Icons.image;
  }

  return Icon(
    iconData,
    size: 40,
    color: Colors.indigo,
  );
}

String formatTime(double hours) {
  int totalMinutes = (hours * 60).round();
  int hoursPart = totalMinutes ~/ 60;
  int minutesPart = totalMinutes % 60;
  String formattedTime = '$hoursPart:${minutesPart.toString().padLeft(2, '0')}';
  return formattedTime;
}

String returnHour(double hours) {
  int totalMinutes = (hours * 60).round();
  int hoursPart = totalMinutes ~/ 60;
  int minutesPart = totalMinutes % 60;
  String formattedTime = '$hoursPart:$minutesPart';
  return formattedTime;
}

String formatTimeWithHour(double hours) {
  int totalMinutes = (hours * 60).round();
  int hoursPart = totalMinutes ~/ 60;
  int minutesPart = totalMinutes % 60;
  String formattedTime =
      '$hoursPart Hrs:${minutesPart.toString().padLeft(2, '0')} Mins';
  return formattedTime;
}

String dateFormat(DateTime dt) {
  return '${dt.year}-${dt.month}-${dt.day}';
}

String dateFormat1(DateTime dt) {
  return '${numberList[dt.day]}-${numberList[dt.month]}-${dt.year}';
}

String dateFormatNew(DateTime dt) {
  return '${numberList[dt.day]}-${months[dt.month - 1]}-${dt.year}';
}

List interviewRound = [
  {"name": "Face to Face"},
  {"name": "Telephonic"},
  {"name": "Written"},
  {"name": "Technical"},
  {"name": "HR Round"},
  {"name": "Department Head"},
  {"name": "Managerial"},
  {"name": "MD Round"},
  {"name": "Third Party"},
  {"name": "Online Test"},
  {"name": "Online Test VC"},
  {"name": "Others"},
];
List interviewstatus = [
  {"name": "Upcomming"},
  {"name": "InProgress"},
];
List companyName = [
  {"name": "Vaps Knowledge Services Pvt Ltd"},
  {"name": "Vaps Technosoft Pvt Ltd"},
  {"name": "Unnathi Marketing"},
  {"name": "Smart infrastructure and Service"},
  {"name": "Marga Innovation infrastructure and Developer"},
  {"name": "Pacific System Enterprises"},
  {"name": "Global Quality Training & Assessors Pvt Ltd"},
  {"name": "Vaps Akshaya Foundation"},
  {"name": "House of Raadhya"},
];
