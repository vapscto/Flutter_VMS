import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/driver_indent/controller/driver_intent_controller.dart';
import 'package:m_skool_flutter/vms/driver_indent/model/driver_ind_approve.dart';
import 'package:m_skool_flutter/vms/driver_indent/model/indent_approved_model.dart';

class DriverIndentAPI {
  DriverIndentAPI.init();
  static final DriverIndentAPI i = DriverIndentAPI.init();
  onload({
    required String base,
    required DriverIndentController controller,
    required Map<String, dynamic> body,
  }) async {
    logger.i(body);
    var dio = Dio();
    var api = base + URLS.driverIndent;
    try {
      controller.loadingData(true);
      var response = await dio.post(api,
          options: Options(headers: getSession()), data: body);

      if (response.statusCode == 200) {
        DriverloadModel driverloadModel =
            DriverloadModel.fromJson(response.data['indentApprovalList']);
        controller.indentApprovalList.clear();
        controller.indentApprovalList.addAll(driverloadModel.values!);
        DriverIndentApprovedModel driverIndentApprovedModel =
            DriverIndentApprovedModel.fromJson(response.data['indentApproved']);
        controller.indentApprovedListData.clear();
        controller.indentApprovedListData
            .addAll(driverIndentApprovedModel.values!);
        controller.loadingData(false);
      }
    } on DioError catch (e) {
      logger.e(e.message);
    } on Exception catch (e) {
      logger.e(e.toString());
    }
  }
}
