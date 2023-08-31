import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/staffs/verify_homework_classwork/controller/pick_image_controller.dart';
import 'package:m_skool_flutter/staffs/verify_homework_classwork/model/attachments_model.dart';
import 'package:m_skool_flutter/staffs/verify_homework_classwork/model/filtered_attachment_model.dart';
import 'package:m_skool_flutter/staffs/verify_homework_classwork/model/verify_cw_model.dart';

class GetCwApi {
  GetCwApi.init();
  static final GetCwApi instance = GetCwApi.init();

  Future<List<VerifyClassworkListValues>> getCwList({
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
    final Dio ins = getGlobalDio();
    final String api = base + URLS.getVerifyClassWorkList;
    logger.d(api);
    logger.d({
      "Mi_Id": miId,
      "login_Id": loginId,
      "User_Id": userId,
      "ASMAY_Id": asmayId,
      "ASMCL_Id": "$asmclId",
      "ASMS_Id": "$asmsId",
      "ISMS_Id": "$ismsId",
      "fromdate": fromDate,
      "todate": toDate,
      "ICW_Id": topic,
      "AMST_Id": 0,
    });
    try {
      final Response response =
          await ins.post(api, options: Options(headers: getSession()), data: {
        "Mi_Id": miId,
        "login_Id": loginId,
        // "User_Id": userId,
        "ICW_Id": topic,
        "AMST_Id": 0,
        "ASMAY_Id": asmayId,
        "ASMCL_Id": "$asmclId",
        "ASMS_Id": "$asmsId",
        "ISMS_Id": "$ismsId",
        "fromdate": fromDate,
        "todate": toDate
      });

      final VerifyClassworkList classworks =
          VerifyClassworkList.fromJson(response.data['getclasswork_list']);

      final AttachmentsModel attachment =
          AttachmentsModel.fromJson(response.data['viewhomework']);
      final List<FilteredAttachment> fAttachments = [];
      for (var element in classworks.values!) {
        List<Map<String, dynamic>> attach = [];
        for (var element2 in attachment.values!) {
          if (element.aMSTId == element2.aMSTId) {
            attach.add({
              "FilePath1": element2.icwuplatTFileName,
              "FileName1": element2.icwuplatTAttachment,
              "ICWUPL_Id": element2.iCWUPLId,
              "ICWUPLATT_Id": element2.icwuplatTId,
              "Remark": ""
            });
          }
        }
        fAttachments.add(
            FilteredAttachment(amstId: element.aMSTId!, attachments: attach));
      }
      controller.updateFilteredAttachment(fAttachments);
      return Future.value(classworks.values);
    } on DioError catch (e) {
      logger.e(e.message);
      logger.e(e.stackTrace);
      return Future.error({
        "errorTitle": "An Error Incountered",
        "errorMsg": e.message,
      });
    } on Exception catch (e) {
      logger.e(e.toString());
      return Future.error({
        "errorTitle": "An Error Incountered",
        "errorMsg":
            "An Internal error Occurred, while trying to create a view for you",
      });
    }
  }
}
