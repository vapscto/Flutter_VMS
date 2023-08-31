import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/student/certificates/model/stud_list.dart';

class GetApplyCertificate {
  GetApplyCertificate.init();
  static final GetApplyCertificate instance = GetApplyCertificate.init();

  Future<List<StudListValues>> getAllAppliedCertificate(
      {required int miId,
      required int asmayId,
      required int amstId,
      required String role,
      required String base}) async {
    final Dio ins = getGlobalDio();
    final String getAllCert = base + URLS.getAllAppliedCertificate;
    try {
      Response response = await ins
          .post(getAllCert, options: Options(headers: getSession()), data: {
        "mI_ID": miId,
        "ASMAY_Id": asmayId,
        "AMST_Id": amstId,
        "roletype": role,
      });
      final StudList allAppliedCert =
          StudList.fromJson(response.data['studlist']);
      logger.d(allAppliedCert.toJson());
      return Future.value(allAppliedCert.values);
    } on Exception catch (e) {
      logger.e(e.toString());
      return Future.error({
        "errorTitle": "Unable to connect to server",
        "errorMsg":
            "Sorry! but we are unable to connect to server, try again later",
      });
    }
  }
}
