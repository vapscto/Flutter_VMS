import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/noc_approval/controller/noc_approved_controller.dart';
import 'package:m_skool_flutter/vms/noc_approval/model/noc_approved_model.dart';
import 'package:m_skool_flutter/vms/noc_approval/model/noc_details_model.dart';

class NocApproveAPI {
  NocApproveAPI.init();
  static final NocApproveAPI i = NocApproveAPI.init();
  certificateLoad({
    required String base,
    required NocApprovedController controller,
    required int userId,
    required int miId,
  }) async {
    var dio = Dio();
    var api = base + URLS.nocLoad;
    try {
      controller.approved(true);
      var response =
          await dio.post(api, options: Options(headers: getSession()), data: {
        "UserId": userId,
        "MI_Id": miId,
      });
      if (response.statusCode == 200) {
        NocApprovedModel nocApprovedModel =
            NocApprovedModel.fromJson(response.data['aprovedlist']);
        controller.approvedList.clear();
        controller.approvedList.addAll(nocApprovedModel.values!);

        controller.approved(true);
      }
    } on DioError catch (e) {
      logger.e(e.message);
    } on Exception catch (e) {
      logger.e(e.toString());
    }
  }

  Future<NocDetailsModel?> nocDetails({
    required String base,
    required NocApprovedController controller,
    required int userId,
    required int miId,
    required int iSMCERTREQId,
    required int hrmeId,
  }) async {
    var dio = Dio();
    var api = base + URLS.nocDetails;
    try {
      var response =
          await dio.post(api, options: Options(headers: getSession()), data: {
        "ISMCERTREQ_Id": iSMCERTREQId,
        "HRME_Id": hrmeId,
        "MI_Id": miId,
        "UserId": userId
      });
      if (response.statusCode == 200) {
        NocDetailsModel nocApprovedModel =
            NocDetailsModel.fromJson(response.data['getloaddetails']);
        controller.maxLevel.value = response.data['maxmumlevel'];
        // controller.nocEmpDetails.addAll(nocApprovedModel.values!);
        return nocApprovedModel;
      }
    } on DioError catch (e) {
      logger.e(e.message);
    } on Exception catch (e) {
      logger.e(e.toString());
    }
    return null;
  }

  nocApprove(
      {required String base,
      required NocApprovedController controller,
      required Map<String, dynamic> body}) async {
    var dio = Dio();
    var api = base + URLS.nocApproval;
    try {
      var response = await dio.post(api,
          options: Options(headers: getSession()), data: body);
      if (response.statusCode == 200) {
        if (response.data['returnval'] == true) {
          Fluttertoast.showToast(msg: "Record saved successfully");
        } else if (response.data['returnval'] == false) {
          Fluttertoast.showToast(msg: "Record Not saved successfully");
        }
      }
    } on DioError catch (e) {
      logger.e(e.message);
    } on Exception catch (e) {
      logger.e(e.toString());
    }
  }
}
