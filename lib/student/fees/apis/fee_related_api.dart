import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/student/fees/model/fee_receipt_details_model.dart';
import 'package:m_skool_flutter/student/fees/model/fee_receipt_no_model.dart';
import 'package:m_skool_flutter/student/fees/model/fee_receipt_year_list_model.dart';

import '../model/feeModel.dart';

var dio = Dio();

Future<FeeDetails?> getFeeAnalysisList({
  required int miId,
  required int asmayId,
  required int amstId,
  required String base,
}) async {
  var url = base + URLS.getFeeAnalysis;
  try {
    var response = await dio.post(
      url,
      options: Options(
        headers: getSession(),
      ),
      data: {
        "MI_Id": miId,
        "ASMAY_Id": asmayId,
        "AMST_Id": amstId,
      },
    );
    if (response.statusCode == 200) {
      logger.d(response.data);
      FeeDetails feeDetails = FeeDetails.fromJson(response.data);
      return feeDetails;
    } else {
      Fluttertoast.showToast(msg: 'Unable to fetch data');
      return null;
    }
  } catch (e) {
    logger.e(e.toString());
    return null;
  }
}

Future<FeeReceiptYearListModel?> getFeeReceiptYearList({
  required int miId,
  required int asmayId,
  required int amstId,
  required String base,
}) async {
  var url = base + URLS.getFeeReceiptYear;
  try {
    var response = await dio.post(
      url,
      options: Options(
        headers: getSession(),
      ),
      data: {
        "MI_Id": miId,
        "ASMAY_Id": asmayId,
        "AMST_Id": amstId,
      },
    );
    if (response.statusCode == 200) {
      FeeReceiptYearListModel feeReceiptYearListModel =
          FeeReceiptYearListModel.fromJson(response.data);
      return feeReceiptYearListModel;
    } else {
      Fluttertoast.showToast(msg: 'Unable to fetch data');
      return null;
    }
  } catch (e) {
    logger.e(e.toString());
    return null;
  }
}

Future<FeeReceiptNoModel?> getFeeReceiptNoList({
  required int miId,
  required int asmayId,
  required int amstId,
  required String base,
}) async {
  var url = base + URLS.getFeeReceiptNo;
  try {
    var response = await dio.post(
      url,
      options: Options(
        headers: getSession(),
      ),
      data: {
        "MI_Id": miId,
        "ASMAY_Id": asmayId,
        "AMST_Id": amstId,
      },
    );
    if (response.statusCode == 200) {
      logger.d(response.data);
      FeeReceiptNoModel feeReceiptNoModel =
          FeeReceiptNoModel.fromJson(response.data);
      return feeReceiptNoModel;
    } else {
      Fluttertoast.showToast(msg: 'Unable to fetch data');
      return null;
    }
  } on Exception catch (e) {
    logger.e(e.toString());
    return Future.error(
      {
        "errorTitle": "Unable to connect to server",
        "errorMsg":
            "Sorry!! We are unable to connect to server right now.. try again later",
      },
    );
  }
}

Future<FeeReceiptDetailsModel?> getFeeReceiptDetails({
  required int miId,
  required int asmayId,
  required int amstId,
  required String base,
  required int fypId,
}) async {
  var url = base + URLS.getFeeReceiptDetails;
  try {
    var response = await dio.post(
      url,
      options: Options(
        headers: getSession(),
      ),
      data: {
        "MI_Id": miId,
        "ASMAY_Id": asmayId,
        "AMST_Id": amstId,
        "FYP_Id": fypId,
        "configset": "T",
        "minstall": 0
      },
    );
    if (response.statusCode == 200) {
      logger.d(response.data);
      FeeReceiptDetailsModel feeReceiptDetailsModel =
          FeeReceiptDetailsModel.fromJson(response.data);
      return feeReceiptDetailsModel;
    } else {
      Fluttertoast.showToast(msg: 'Unable to fetch data');
      return null;
    }
  } on Exception catch (e) {
    logger.e(e.toString());
    return Future.error(
      {
        "errorTitle": "Unable to connect to server",
        "errorMsg":
            "Sorry!! We are unable to connect to server right now.. try again later",
      },
    );
  }
}
