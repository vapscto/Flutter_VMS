import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/manager/feedemo/controller/fee_demo_controller.dart';
import 'package:m_skool_flutter/manager/feedemo/model/fee_report_.dart';


class GetfeereportApi {
  GetfeereportApi.init();

  static final GetfeereportApi instance = GetfeereportApi.init();

   Future<List<FeeReportmodelValues>> getfeereport({
    required int miId,
    required int asmayId,
    required String base,
    required FeeDemoController controller,
  }) async {
    try {
      final Dio ins = getGlobalDio();
      final String api =
          "${base}api/PrincipalDefaulterFeeFacade/Getreport/";

          logger.d(api);

      final Response response =
          await ins.post(api, options: Options(headers: getSession()), data: {

              "MI_Id": miId,
    "ASMAY_Id": controller.selectedAcademicYear!.asmaYId,
    "asmS_Id": controller.selectedsection!.asmSId,
    "asmcL_Id":controller.selectedClass!.asmcLId,
   

      });

      logger.d({

              "MI_Id": miId,
    "ASMAY_Id": controller.selectedAcademicYear!.asmaYId,
    "asmS_Id": controller.selectedsection!.asmSId,
    "asmcL_Id":controller.selectedClass!.asmSId,
   

      });
   
      if (response.data['studbal'] == null) {
        return Future.error({
          "errorTitle": "No Data found",
          "errorMsg": "We are unable to get employeeSalarySlipDetails"
        });
      }
      final FeeReportmodel employee = FeeReportmodel.fromJson(
          response.data['studbal']);

      // salaryController.updateSalarySlip(employee.values!);

      return Future.value(employee.values);
    } on Exception catch (e) {
      logger.e(e.toString());
      return Future.error({
        "errorTitle": "Server error Occured",
        "errorMsg": "We are unable to get employeeSalarySlipDetails"
      });
    }
  }
}
