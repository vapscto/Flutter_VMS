import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/certificate_approval/controller/certificate_controller.dart';
import 'package:m_skool_flutter/vms/certificate_approval/model/certificate_approval_model.dart';
import 'package:m_skool_flutter/vms/certificate_approval/model/certificate_doc_model.dart';
import 'package:m_skool_flutter/vms/certificate_approval/model/certificate_list_model.dart';

class CertificateLoadAPI {
  CertificateLoadAPI.init();
  static final CertificateLoadAPI instance = CertificateLoadAPI.init();
  certificateLoad({
    required String base,
    required CertificateController controller,
    required int userId,
  }) async {
    var dio = Dio();
    var api = base + URLS.certificateList; //certificateFileView
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
    var api = base + URLS.certificateFileView; //certificateFileView
    try {
      controller.approvedloading(true);
      var response = await dio.post(api,
          options: Options(headers: getSession()),
          data: {
            "UserId": userId,
            "ISMCERTREQ_Id": iSMCERTREQId,
            "HRME_Id": hrmeId
          });
      if (response.statusCode == 200) {
        CertificateDocumentModel certificateDocumentModel =
            CertificateDocumentModel.fromJson(response.data['document']);
        controller.certificatDocList.addAll(certificateDocumentModel.values!);
        controller.employeeRemarks.value =
            response.data['ismcertreqapP_Remarks'];
        controller.approvedloading(true);
      }
    } on DioError catch (e) {
      logger.e(e.message);
    } on Exception catch (e) {
      logger.e(e.toString());
    }
  }
}
