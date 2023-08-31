import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/manager/overall_fee/model/overallFeeDetailModel.dart';

var dio = Dio();

Future<OverallFeeDetailModel?> getOverallFeeDetailsData({
  required String base,
  required int miId,
  required int asmayId,
}) async {
  var url = base + URLS.feeDetails;
  try {
    var response = await dio.post(
      url,
      options: Options(
        headers: getSession(),
      ),
      data: {
        "MI_Id": miId,
        "ASMAY_Id": asmayId,
      },
    );
    if (response.statusCode == 200) {
      OverallFeeDetailModel overallFeeDetailModel =
          OverallFeeDetailModel.fromJson(response.data);
      return overallFeeDetailModel;
    }
    return null;
  } catch (e) {
    logger.d(e.toString());
    return null;
  }
}
