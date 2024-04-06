import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/hr_modules/interview_schdule/controller/interview_sc_controller.dart';
import 'package:m_skool_flutter/vms/hr_modules/interview_schdule/model/candidate_list_model.dart';
import 'package:m_skool_flutter/vms/hr_modules/interview_schdule/model/interviewer_list_model.dart';

class InterViewSchduleAPI {
  InterViewSchduleAPI.init();
  static final InterViewSchduleAPI i = InterViewSchduleAPI.init();
  var dio = Dio();
  onLoad(
      {required String base,
      required int miId,
      required InterviewScController controller}) async {
    var api = base + URLS.interviewSchduleOnLoad;
    controller.loading(true);
    var response = await dio.post(api,
        data: {"MI_Id": miId}, options: Options(headers: getSession()));
    if (response.statusCode == 200) {
      CandidateListModel candidateListModel =
          CandidateListModel.fromJson(response.data['candidateDetailsList']);
      controller.candidateList.clear();
      controller.candidateList.addAll(candidateListModel.values!);
      InterviewerListModel interviewerListModel =
          InterviewerListModel.fromJson(response.data['interviewerList']);
      controller.interviewerList.clear();
      controller.interviewerList.addAll(interviewerListModel.values!);
      controller.loading(false);
    }
  }

  saveAPI(
      {required String base,
      required Map<String, dynamic> body,
      required InterviewScController controller}) async {
    var api = base + URLS.interviewSchedule;
    logger.i(api);
    logger.v(body);
    controller.saveing(true);
    var response = await dio.post(api,
        data: body, options: Options(headers: getSession()));
    if (response.statusCode == 200) {
      if (response.data['retrunMsg'] != "") {
        switch (response.data['retrunMsg']) {
          case "Duplicate":
            Fluttertoast.showToast(msg: "Record already exists..!!");
            break;
          case "NQ":
            Fluttertoast.showToast(
                msg: "Question Paper is Not set to the Candidate Position");
            Get.back();
            break;
          case "false":
            Fluttertoast.showToast(
                msg: "Record Not saved / Updated..",
                toastLength: Toast.LENGTH_LONG);
            break;
          case "Add":
            Fluttertoast.showToast(msg: "Interview Scheduled Successfully.");
            Get.back();
            break;
          case "Update":
            Fluttertoast.showToast(msg: "Interview Updated Successfully.");
            Get.back();
            break;
          case "Notification":
            Fluttertoast.showToast(msg: "Notification!");
            Get.back();
            break;
          default:
            Fluttertoast.showToast(
                msg: "Something went wrong..! Kindly contact Administrator",
                toastLength: Toast.LENGTH_LONG);
            break;
        }
      }
      controller.saveing(false);
    }
  }
}
