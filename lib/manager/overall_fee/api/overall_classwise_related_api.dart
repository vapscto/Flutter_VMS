import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/manager/overall_fee/model/overallFeeAcademicYearModel.dart';
import 'package:m_skool_flutter/manager/overall_fee/model/overallFeeClasswiseStudentDetailModel.dart';
import 'package:m_skool_flutter/manager/overall_fee/model/overallFeeSectionwiseDataModel.dart';

var dio = Dio();
Future<OverallFeeAcademicYearModel?> getClasswiseAcademicYearData({
  required int miId,
  required String base,
}) async {
  var url = base + URLS.getOverallFeeAcademicYear;

  try {
    var response = await dio.post(
      url,
      options: Options(
        headers: getSession(),
      ),
      data: {
        "MI_ID": miId,
      },
    );
    if (response.statusCode == 200) {
      OverallFeeAcademicYearModel overallFeeAcademicYearModel =
          OverallFeeAcademicYearModel.fromJson(response.data);
      return overallFeeAcademicYearModel;
    }
    return null;
  } catch (e) {
    logger.d(e.toString());
    return null;
  }
}

Future<ClasswiseFeeResultModel?> getClasswiseResultData({
  required String base,
  required int asmayId,
  required int miId,
}) async {
  var url = base + URLS.getOverallClasswiseFeeResults;
  try {
    var response = await dio.post(
      url,
      options: Options(
        headers: getSession(),
      ),
      data: {
        "ASMAY_Id": asmayId,
        "MI_Id": miId,
      },
    );
    if (response.statusCode == 200) {
      ClasswiseFeeResultModel classwiseFeeResultModel =
          ClasswiseFeeResultModel.fromJson(response.data);
      return classwiseFeeResultModel;
    }
    return null;
  } catch (e) {
    logger.d(e.toString());
    return null;
  }
}

Future<ClasswiseSectionDetailModel?> getclasswiseSectionData({
  required String base,
  required int asmayId,
  required int asmclId,
  required int miId,
}) async {
  var url = base + URLS.getClasswiseSectionwiseFeeResults;
  try {
    var response = await dio.post(
      url,
      options: Options(
        headers: getSession(),
      ),
      data: {
        "MI_Id": miId,
        "ASMAY_Id": asmayId,
        "ASMCL_Id": asmclId,
      },
    );
    if (response.statusCode == 200) {
      ClasswiseSectionDetailModel classwiseSectionDetailModel =
          ClasswiseSectionDetailModel.fromJson(response.data);
      return classwiseSectionDetailModel;
    }
    return null;
  } catch (e) {
    logger.d(e.toString());
    return null;
  }
}
