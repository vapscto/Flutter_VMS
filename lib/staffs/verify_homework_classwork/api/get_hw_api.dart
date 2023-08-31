import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/staffs/verify_homework_classwork/controller/pick_image_controller.dart';
import 'package:m_skool_flutter/staffs/verify_homework_classwork/model/filtered_attachment_model.dart';
import 'package:m_skool_flutter/staffs/verify_homework_classwork/model/hw_all_attachment.dart';
import 'package:m_skool_flutter/staffs/verify_homework_classwork/model/verify_hw_model.dart';

class GetHwApi {
  GetHwApi.init();
  static final GetHwApi instance = GetHwApi.init();

  Future<List<VerifyHwListModelValues>> getHwForVerification({
    required int miId,
    required int hrmeId,
    required int loginId,
    required int userId,
    required int ivrmrtId,
    required String roleFlag,
    required int asmayId,
    required int ismsId,
    required int asmclId,
    required int asmsId,
    required String fromDate,
    required String toDate,
    required String base,
    required int topic,
    required PickImageController controller,
  }) async {
    try {
      final Dio ins = getGlobalDio();
      final String api = base + URLS.getHwList;
      logger.d({
        "MI_Id": miId,
        // "HRME_Id": hrmeId,
        "Login_Id": loginId,
        "UserId": userId,
        // "IVRMRT_Id": ivrmrtId,
        // "Role_flag": "Staff",
        "ASMAY_Id": asmayId,
        "ISMS_Id": ismsId,
        "ASMCL_Id": asmclId,
        "ASMS_Id": asmsId,
        "fromdate": fromDate,
        "todate": toDate,
        "IHW_Id": topic
      });
      final Response response =
          await ins.post(api, options: Options(headers: getSession()), data: {
        "MI_Id": miId,
        // "HRME_Id": hrmeId,
        "Login_Id": loginId,
        "UserId": userId,
        // "IVRMRT_Id": ivrmrtId,
        // "Role_flag": "Staff",
        "ASMAY_Id": asmayId,
        "ISMS_Id": ismsId,
        "ASMCL_Id": asmclId,
        "ASMS_Id": asmsId,
        "fromdate": fromDate,
        "todate": toDate,
        "IHW_Id": topic
      });

      final VerifyHwListModel hwListModel =
          VerifyHwListModel.fromJson(response.data['gethomework_list']);

      final HwAllAttachmentsModel attachment =
          HwAllAttachmentsModel.fromJson(response.data['viewhomework']);
      final List<FilteredAttachment> fAttachments = [];
      for (var element in hwListModel.values!) {
        List<Map<String, dynamic>> attach = [];
        for (var element2 in attachment.values!) {
          if (element.aMSTId == element2.aMSTId) {
            attach.add({
              "FilePath1": element2.ihwuplatTFileName,
              "FileName1": element2.ihwuplatTFileName,
              "IHWUPL_Id": element2.iHWUPLId,
              "IHWUPLATT_Id": element2.iHWUPLId,
              "Remark": ""
            });
          }
        }
        fAttachments.add(
            FilteredAttachment(amstId: element.aMSTId!, attachments: attach));
      }
      controller.updateFilteredAttachment(fAttachments);

      return Future.value(hwListModel.values);
    } on DioError catch (e) {
      logger.e(e.message);
      return Future.error(
          {"errorTitle": "Unexpected Error Occured", "errorMsg": e.message});
    } on Exception catch (e) {
      logger.e(e.toString());
      return Future.error({
        "errorTitle": "Unexpected Error Occured",
        "errorMsg": "An internal error Occured, while creating your view",
      });
    }
  }
}
