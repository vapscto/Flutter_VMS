import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/certificate_approval/controller/certificate_controller.dart';
import 'package:m_skool_flutter/vms/certificate_approval/model/certi_emp_list.dart';
import 'package:m_skool_flutter/vms/certificate_approval/model/certificate_approval_model.dart';
import 'package:m_skool_flutter/vms/certificate_approval/model/certificate_doc_model.dart';
import 'package:m_skool_flutter/vms/certificate_approval/model/certificate_employee_list.dart';
import 'package:m_skool_flutter/vms/certificate_approval/model/certificate_list_model.dart';
import 'package:m_skool_flutter/vms/certificate_approval/model/certificate_view_model.dart';
import 'package:m_skool_flutter/vms/certificate_approval/model/final_approval_model.dart';
import 'package:m_skool_flutter/vms/certificate_approval/model/previous_approved_model.dart';

class CertificateLoadAPI {
  CertificateLoadAPI.init();
  static final CertificateLoadAPI instance = CertificateLoadAPI.init();
  certificateLoad({
    required String base,
    required CertificateController controller,
    required int userId,
  }) async {
    var dio = Dio();
    var api = base + URLS.certificateList;
    try {
      controller.loading(true);
      var response = await dio.post(api,
          options: Options(headers: getSession()), data: {"UserId": userId});
      if (response.statusCode == 200) {
        CertificatelistModel certificatelistModel =
            CertificatelistModel.fromJson(response.data['cerfificatelist']);
        controller.certificatelist.addAll(certificatelistModel.values!);
        CertificateApprovalListModel certificateApprovalListModel =
            CertificateApprovalListModel.fromJson(response.data['aprovedlist']);
        controller.certificateApprovalList
            .addAll(certificateApprovalListModel.values!);
        controller.loading(true);
      }
    } on DioError catch (e) {
      logger.e(e.message);
    } on Exception catch (e) {
      logger.e(e.toString());
    }
  }

  documentLoad({
    required String base,
    required CertificateController controller,
    required int userId,
    required String iSMCERTREQId,
    required String hrmeId,
  }) async {
    var dio = Dio();
    var api = base + URLS.certificateFileView;
    try {
      controller.approvedloading(true);
      var response = await dio.post(api,
          options: Options(headers: getSession()),
          data: {
            "UserId": userId,
            "ISMCERTREQ_Id": iSMCERTREQId,
            "HRME_Id": hrmeId
          });
      logger.i(
          {"UserId": userId, "ISMCERTREQ_Id": iSMCERTREQId, "HRME_Id": hrmeId});
      if (response.statusCode == 200) {
        CertificateDocumentModel certificateDocumentModel =
            CertificateDocumentModel.fromJson(response.data['document']);
        controller.certificatDocList.addAll(certificateDocumentModel.values!);
        controller.employeeRemarks.value =
            response.data['ismcertreqapP_Remarks'];
        controller.maxLevel.value = response.data['maxmumlevel'];
        logger.v('Max Approval :-${controller.maxLevel.value}');
        if (response.data['aprovedlist'] != null) {
          PreviousApprovedModel previousApprovedModel =
              PreviousApprovedModel.fromJson(response.data['aprovedlist']);
          controller.previousApprovedList.addAll(previousApprovedModel.values!);
        }
        PreviousApprovedViewModel viewModel =
            PreviousApprovedViewModel.fromJson(response.data['viewlist']);
        controller.viewList.clear();
        controller.viewList.addAll(viewModel.values!);
        logger.w('Level ${controller.viewList.first.hrpaoNSanctionLevelNo}');
        CertificateEmployeeModel certificateEmployeeModel =
            CertificateEmployeeModel.fromJson(response.data['getloaddetails']);
        controller.loadEmployee(certificateEmployeeModel.values!);
        CerEmployListModel cerEmployListModel =
            CerEmployListModel.fromJson(response.data['employees']);
        controller.employeeList.addAll(cerEmployListModel.values!);
        if (response.data['display_data'] != null) {
          CertificateFinalApprovalModel certificateFinalApprovalModel =
              CertificateFinalApprovalModel.fromJson(
                  response.data['display_data']);
          controller.finalApprovalList.clear();
          controller.finalApprovalList
              .addAll(certificateFinalApprovalModel.values!);
        }
        controller.approvedloading(true);
      }
    } on DioError catch (e) {
      logger.e(e.message);
    } on Exception catch (e) {
      logger.e(e.toString());
    }
  }

  approveCertificate({
    required String base,
    required CertificateController controller,
    required Map<String, dynamic> body,
  }) async {
    logger.i(body);
    var dio = Dio();
    var api = base + URLS.certificateApprove;
    try {
      controller.aprove(true);
      var response = await dio.post(api,
          options: Options(headers: getSession()), data: body);

      if (response.statusCode == 200) {
        if (response.data['returnval'] == true) {
          Fluttertoast.showToast(msg: "Status Updated SuccessFully");
        }
        controller.aprove(true);
      }
    } on DioError catch (e) {
      logger.e(e.message);
    } on Exception catch (e) {
      logger.e(e.toString());
    }
  }
}
