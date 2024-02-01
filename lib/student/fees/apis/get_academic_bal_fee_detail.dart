import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/student/fees/controller/pay_online_data_controller.dart';
import 'package:m_skool_flutter/student/fees/model/academic_year_fee_detail_model.dart';

class GetAcademicFeeDetailBalanceApi {
  GetAcademicFeeDetailBalanceApi.init();
  static final GetAcademicFeeDetailBalanceApi instance =
      GetAcademicFeeDetailBalanceApi.init();

  getDetailsForCurrentAcademicYear({
    required int miId,
    required int asmayId,
    required int amstId,
    required String configSet,
    required String base,
    required PayOnlineDataController payOnlineDataController,
  }) async {
    final String api = base + URLS.getFeeDetForCurrentAcademic;
    final Dio dio = getGlobalDio();
    try {
      logger.d({
        "MI_Id": miId,
        "AMST_Id": amstId,
        "ASMAY_Id": asmayId,
        "configset": configSet,
      });

      logger.d(api);
      final Response response = await dio.post(
        api,
        options: Options(headers: getSession()),
        data: {
          "MI_Id": miId,
          "AMST_Id": amstId,
          "ASMAY_Id": asmayId,
          "configset": configSet,
        },
      );
      if (response.data["filonlinepaymentgrid"] == null) {
        payOnlineDataController.updateisPageLoading(false);
        payOnlineDataController.updateIsAcademicFeeDetailLoaded(true);
        return;
      }
      final AcademicYearFeeDtlModel academicYearFeeDtlModel =
          AcademicYearFeeDtlModel.fromJson(
              response.data['filonlinepaymentgrid']);

      // if (response.data["currpaymentdetailsValues"] == null) {
      //   //Error
      //   return;
      // }

      payOnlineDataController
          .updateAcademicYearFeeDet(academicYearFeeDtlModel.values!);
      logger.d(payOnlineDataController.academicYearFeeDet.first.fSSNetAmount);
      logger.d(payOnlineDataController.academicYearFeeDet.first.fSSPaidAmount);
      logger.d(
          payOnlineDataController.academicYearFeeDet.first.fSSConcessionAmount);
      logger.d(payOnlineDataController.academicYearFeeDet.first.fSSToBePaid);
      payOnlineDataController.updateisPageLoading(false);
      payOnlineDataController.updateIsAcademicFeeDetailLoaded(true);

      // logger.d(payOnlineDataController.isAcademicFeeDetailLoaded.value);
    } on Exception catch (e) {
      logger.e(e.toString());
      return Future.error({
        "errorTitle": "Unable to connect to server",
        "errorMsg":
            "While fetching your fee details either we are unable to connect to server or server returned an error, Try again later",
      });
    }
  }
}
