import 'package:dio/dio.dart';
import 'package:m_skool_flutter/Principal/toperWise/controller/toper_wise_result.dart';
import 'package:m_skool_flutter/Principal/toperWise/model/top_result_model.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';

Future<void> featchResult(
    {required int miId,
    required String asmayId,
    required String asmclId,
    required int asmsId,
    required String emeId,
    required int ismsId,
    required int examCheckType,
    required int reportType,
    required int subCheckType,
    required String topper,
    required base,
    required ToperWiseController controller}) async {
  final String api = base + URLS.toperWiseResult;

  final Dio ins = getGlobalDio();
  logger.d(api);

  logger.d({
    "MI_ID": miId,
    "ASMAY_Id": asmayId,
    "ASMCL_Id": asmclId,
    "ASMS_Id": asmsId,
    "EME_Id": emeId,
    "ISMS_Id": ismsId,
    "exm_check_type": examCheckType,
    "report_type": reportType,
    "sub_check_type": subCheckType,
    "topper": topper
  });
  if (controller.isErrorOccuredWhileLoadingAcademic.value) {
    controller.updateIsErrorOccuredWhileLoadingAcademic(false);
  }
  controller.updateIsLoadingCategory(true);
  try {
    final Response response =
        await ins.post(api, options: Options(headers: getSession()), data: {
      "MI_ID": miId,
      "ASMAY_Id": asmayId,
      "ASMCL_Id": asmclId,
      "ASMS_Id": asmsId,
      "EME_Id": emeId,
      "ISMS_Id": ismsId,
      "exm_check_type": examCheckType,
      "report_type": reportType,
      "sub_check_type": subCheckType,
      "topper": topper
    });
    // logger.d(response.data["datareport"]);
    if (response.data["datareport"] == null) {
      controller.updateIsErrorOccuredWhileLoadingAcademic(true);
      controller.updateIsLoadingAcademicYear(false);
      return;
    }
    TopResultListModel topResultListModel =
        TopResultListModel.fromJson(response.data["datareport"]);
    if (topResultListModel.values!.isNotEmpty) {
      controller.updateIsLoadingCategory(false);
    }
    controller.marksDataTableList.addAll(topResultListModel.values!);
    controller.updateIsErrorOccuredWhileLoadingAcademic(false);
    controller.updateIsLoadingAcademicYear(false);
  } on Exception catch (e) {
    logger.e(e.toString());
    controller.updateIsErrorOccuredWhileLoadingAcademic(true);
    controller.updateIsLoadingAcademicYear(false);
  }
}
