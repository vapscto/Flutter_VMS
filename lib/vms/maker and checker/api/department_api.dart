import 'package:dio/dio.dart';
 
import 'package:m_skool_flutter/constants/api_url_constants.dart';

import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
 
import 'package:m_skool_flutter/vms/maker%20and%20checker/controller/mc_home_screen.dart';
 
import 'package:m_skool_flutter/vms/maker%20and%20checker/model/designation.dart';
 

Future<int> feachDesignation(
    {required String base,
      required int userId,
    required int mi_id,
    required MakerCheckerController controller,
    required int ivrmrt,
    required List<Map<String, dynamic>> list}) async {
  final Dio ins = getGlobalDio();
  String apiUrl =base+URLS.DeptList;
  
 
  logger.d(apiUrl);
  logger.d({
      "IVRMRT_Id": ivrmrt,
      "UserId": userId,
      "MI_Id": mi_id,
      "DRApprovalTypeFlag": "DRApproval",
      "departmentlist": list
    });
  try {
    controller.dsgloading(true);

    final Response response =
        await ins.post(apiUrl, options: Options(headers: getSession()), data: {
      "IVRMRT_Id": ivrmrt,
      "UserId": userId,
      "MI_Id": mi_id,
      "DRApprovalTypeFlag": "DRApproval",
      "departmentlist": list
    });
    logger.d(list);
    if (response.data['designation'] != null) {
      controller.dsgloading(false);

      dsgnModel dsgnList = dsgnModel.fromJson(response.data['designation']);

      controller.designationList.addAll(dsgnList.values!);

      return response.statusCode!;
    }
    return 0;
  } on DioError catch (e) {
    logger.e(e.message);
    return 0;
  } on Exception catch (e) {
    logger.e(e.toString());

    return 0;
  }
}
