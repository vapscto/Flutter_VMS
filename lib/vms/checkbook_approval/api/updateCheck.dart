 import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';

import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/checkbook_approval/controller/detailed_todo_controller.dart';
import 'package:m_skool_flutter/vms/checkbook_approval/model/getTaDaModel.dart';

Future<int> updateCheque({
  required int userId,
  required int mi_id,
  required String base,
  required GetDetailedToDo controller,
}) async {
  final Dio ins = getGlobalDio();
  final String apiUrl =
       base+URLS.updateCheck;

  

  logger.d("show data${apiUrl}");
    logger.d(  {"UserId": userId, "MI_Id": mi_id});
  try {
    controller.updateisLoading(true);

    final Response response = await ins.post(apiUrl,
        options: Options(headers: getSession()),
        data: {"UserId": userId, "MI_Id": mi_id});

    logger.d("show${response.data['getadvancetada']}");
    if (response.data['getadvancetada'] == null) {
      controller.updateisErrorOccuredLoading(true);
      return 0;
    } else if (response.data['getadvancetada'] != null) {
      controller.updateisErrorOccuredLoading(false);
      controller.updateisLoading(false);
      GetTaDaModel loadTaDaResponse =
          GetTaDaModel.fromJson(response.data['getadvancetada']);
      controller.getTaDaModelList.addAll(loadTaDaResponse.values!);
      for (int i = 0; i < loadTaDaResponse.values!.length; i++) {
        controller.tEControllerListOfSncAmount.add(TextEditingController(
            text: controller.getTaDaModelList
                .elementAt(i)
                .vPAYVOUAppliedAmount
                .toString()));
        controller.tEControllerListOfNarration.add(TextEditingController(
            text: controller.getTaDaModelList
                .elementAt(i)
                .vPAYVOURemarks
                .toString()));
        controller.tEControllerListOfApprovalRemark.add(TextEditingController(
          text: controller.getTaDaModelList.elementAt(i).vPAYVOUToSupplierFlg !=
                  null
              ? ""
              : "",
        ));
        controller.checkList.add(
          false  );
        controller.radioSelect.add(controller.getTaDaModelList
                    .elementAt(i)
                    .vPAYVOUStatusFlg
                    .toString() ==
                "Rejected"
            ? 0
            : 1);
      }
      
      return response.statusCode!;
    }

    return response.statusCode!;
  } on DioError catch (e) {
    controller.updateisErrorOccuredLoading(true);

    logger.e(e.message);
    return 0;
  } on Exception catch (e) {
    logger.e(e.toString());
    controller.updateisErrorOccuredLoading(true);

    return 0;
  }
}
