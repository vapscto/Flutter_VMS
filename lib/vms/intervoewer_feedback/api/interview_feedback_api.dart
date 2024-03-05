import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/intervoewer_feedback/controller/interview_feedback_controller.dart';
import 'package:m_skool_flutter/vms/intervoewer_feedback/model/interview_grid_list_model.dart';
import 'package:m_skool_flutter/vms/intervoewer_feedback/model/update_data_model.dart';

class InterviewFeedbackAPI {
  InterviewFeedbackAPI.init();
  static final InterviewFeedbackAPI i = InterviewFeedbackAPI.init();
  onload({
    required String base,
    required InterviewFeedbackController controller,
    required Map<String, dynamic> body,
  }) async {
    logger.i(body);
    var dio = Dio();
    var api = base + URLS.interviewList;
    try {
      controller.listLoading(true);
      var response = await dio.post(api,
          options: Options(headers: getSession()), data: body);
      if (response.statusCode == 200) {
        InterviewModelList interviewModelList = InterviewModelList.fromJson(
            response.data['vmsCandidateInterviewList']);
        controller.interviewList.clear();
        controller.interviewList.addAll(interviewModelList.values!);
        controller.listLoading(false);
      }
    } on DioError catch (e) {
      logger.e(e.message);
    } on Exception catch (e) {
      logger.e(e.toString());
    }
  }

  saveFeedback({
    required String base,
    required InterviewFeedbackController controller,
    required Map<String, dynamic> body,
  }) async {
    logger.i(body);
    var dio = Dio();
    var api = base + URLS.saveFeedback;
    logger.w(api);
    try {
      controller.saveLoading(true);
      var response = await dio.post(api,
          options: Options(headers: getSession()), data: body);
      if (response.statusCode == 200) {
        if (response.data['retrunMsg'] == "Add") {
          Fluttertoast.showToast(msg: "Record Saved Successfully..");
        } else if (response.data['retrunMsg'] == "Update") {
          Fluttertoast.showToast(msg: "Record Saved Successfully..");
        } else if (response.data['retrunMsg'] == 'false') {
          Fluttertoast.showToast(msg: "Record Not saved");
        } else {}
        controller.saveLoading(false);
      }
    } on DioError catch (e) {
      logger.e(e.message);
    } on Exception catch (e) {
      logger.e(e.toString());
    }
  }

  // details
  detailsAPI({
    required String base,
    required InterviewFeedbackController controller,
    required int id,
  }) async {
    var dio = Dio();
    var api = '$base${URLS.editData}$id';
    logger.w(api);
    try {
      controller.getUpdate(true);
      var response = await dio.get(
        api,
        options: Options(headers: getSession()),
      );
      if (response.statusCode == 200) {
        InterviewUPdateModel interviewModelList =
            InterviewUPdateModel.fromJson(response.data['vmsEditValue']);
        controller.updateData.clear();
        controller.updateData.addAll(interviewModelList.values!);
        controller.getUpdate(false);
      }
    } on DioError catch (e) {
      logger.e(e.message);
    } on Exception catch (e) {
      logger.e(e.toString());
    }
  }
}
