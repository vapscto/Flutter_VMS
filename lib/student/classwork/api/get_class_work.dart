import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/student/classwork/model/class_work_model.dart';
import 'package:m_skool_flutter/student/information/controller/hwcwnb_controller.dart';

class GetClassWorkApi {
  GetClassWorkApi.init();
  static final GetClassWorkApi instance = GetClassWorkApi.init();
  Future<List<ClassWorkModelValues>> getClassWorks({
    required int miId,
    required int asmayId,
    required int amstId,
    required int roleId,
    required int userId,
    required String base,
    String? startDate,
    String? endDate,
    HwCwNbController? controller,
  }) async {
    try {
      final Dio dio = getGlobalDio();
      final String classworkApi = base + URLS.classWork;
      final Map<String, dynamic> data = {};

      logger.d(classworkApi);
      if (controller != null) {
        controller.updateIsClassWorkDataLoading(true);
      }
      data.addAll({
        "mI_ID": miId,
        "ASMAY_Id": asmayId,
        "AMST_Id": amstId,
        "User_Id": userId,
        "roleid": roleId,
        "flag": "classwork"
      });

      logger.d({
        "mI_ID": miId,
        "ASMAY_Id": asmayId,
        "AMST_Id": amstId,
        "User_Id": userId,
        "roleid": roleId,
        "flag": "classwork"
      });
      if (startDate != null && endDate != null) {
        data.addAll({
          "icW_FromDate": startDate,
          "icW_ToDate": endDate,
        });
      }
      logger.d(data);

      Response response = await dio.post(
        classworkApi,
        options: Options(headers: getSession()),
        data: data,
      );

      if (response.data['assignmentlist'] == null) {
        return Future.error({
          "errorTitle": "No Data Found",
          "errorMsg":
              "Sorry! but assignmentlist array not present in database... contact your technical team.",
        });
      }

      final ClassWorkModel classWorkModel =
          ClassWorkModel.fromJson(response.data['assignmentlist']);

      if (controller != null) {
        controller.updateClassWorkList(classWorkModel.values!);
        controller.updateIsClassWorkDataLoading(false);
      }
      return Future.value(classWorkModel.values!);
    } on Exception catch (e) {
      logger.e(e.toString());
      return Future.error({
        "errorTitle": "Unable to connect to Server",
        "errorMsg":
            "Sorry! but we are unable to connect to server right now, you can try again later",
      });
    }
  }
}
