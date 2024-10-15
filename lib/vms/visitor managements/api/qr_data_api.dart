import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/visitor%20managements/controller/visitor_controller.dart';
import 'package:m_skool_flutter/vms/visitor%20managements/model/visitor_details.dart';

class QrDataAPI {
  QrDataAPI.init();
  static final QrDataAPI i = QrDataAPI.init();
  getData(
      {required String base,
      required Map<String, dynamic> body,
      required VisitorManagementsController controller}) async {
    var api = "${base}api/AddVisitorsFacade/FetchDetails";
    var dio = Dio();
    var response = await dio.post(api,
        data: body, options: Options(headers: getSession()));
    if (response.statusCode == 200) {
      if (response.data['vis_list'] != null) {
        VisitorDetailsModel visitorDetailsModel =
            VisitorDetailsModel.fromJson(response.data['vis_list']);
        controller.visitorData.value = visitorDetailsModel.values!;
      }
    }
  }

  Future<void> saveQrData(
      {required String base, required Map<String, dynamic> body}) async {
    var api = "${base}api/AppointmentStatusFacade/saveData";
    var dio = Dio();
    logger.i(api);
    logger.w(body);
    try {
      var response = await dio.post(api,
          data: body, options: Options(headers: getSession()));
      if (response.statusCode == 200) {
        logger.v(response.data);
        if (response.data['returnVal'] == "saved") {
          Fluttertoast.showToast(msg: "Visitor Details Saved Successfully");
        } else if (response.data['returnVal'] == "updated") {
          Fluttertoast.showToast(msg: "Visitor Details Updated Successfully");
        } else {
          Fluttertoast.showToast(msg: "Failed to save Details");
        }
      }
    } on Exception catch (e) {
      logger.e(e);
    }
  }
}
