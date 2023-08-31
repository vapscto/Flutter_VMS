import 'package:dio/dio.dart';

import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/student/certificates/model/certlist_asca_model.dart';
import 'package:m_skool_flutter/student/certificates/model/get_cert_data_model.dart';

class GetCertificateType {
  GetCertificateType.init();
  static final GetCertificateType instance = GetCertificateType.init();

  Future<CertListAsca> getCertificateType({
    required int miId,
    required int asmayId,
    required int ivrmrtId,
    required int amstId,
    required String baseUrl,
  }) async {
    final String apiUrl = baseUrl + URLS.getCertitificateType;
    final Dio ins = getGlobalDio();

    logger.d(apiUrl);
    try {
      Response response = await ins
          .post(apiUrl, options: Options(headers: getSession()), data: {
        "MI_Id": miId,
        "ASMAY_Id": asmayId,
        "IVRMRT_Id": ivrmrtId,
        "AMST_Id": amstId,
        "flag": "Student"
      });

      final GetCertificateDataModel dataModel =
          GetCertificateDataModel.fromJson(response.data);

      final CertListAsca ascaAndCertList = CertListAsca(
          ascaId: dataModel.studentdetails!.values!.first.ascAId!,
          certificateList: dataModel.certificatelist!);

      return Future.value(ascaAndCertList);
    } on Exception catch (e) {
      logger.e(e.toString());
      return Future.error(
        {
          "errorTitle": "Unable to connect to server",
          "errorMsg":
              "An error occured while fetching the list of certificate you can apply for.",
        },
      );
    }
  }
}
