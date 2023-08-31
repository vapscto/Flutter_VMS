import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/manager/feedemo/controller/fee_demo_controller.dart';
import 'package:m_skool_flutter/manager/feedemo/model/category_class_model.dart';

class GetinitialClassApi {
  GetinitialClassApi.init();

  static final GetinitialClassApi instance = GetinitialClassApi.init();

  getclasses(
      {required String base,
      required int miId,
      required FeeDemoController controller,
      required int asmayId}) async {
    final Dio ins = getGlobalDio();
    String api = base + URLS.getDemoclassData;
 logger.d(api);
    if (controller.isErrorOccuredWhileLoadingclass.value) {
      controller.updateIsErrorOcuuredWhileLoadingclass(false);
    }
    controller.updateIsLoadingclass(true);
    try {
      final Response response = await ins.post(api,
          options: Options(headers: getSession()),
          data: {"MI_Id": miId, "ASMAY_Id": asmayId});

      logger.d({"MI_Id": miId, "ASMAY_Id": asmayId});

      if (response.data['classarray'] == null) {
        controller.updateIsErrorOcuuredWhileLoadingclass(true);
        controller.updateIsLoadingclass(false);
        return;
      }

      final ClassCategoryListModel academicYear =
          ClassCategoryListModel.fromJson(response.data['classarray']);
      if (academicYear.values!.isEmpty) {
        controller.classes.clear();
      } else {
        controller.updateClasses(academicYear.values!);
        controller.selectedClass = academicYear.values!.first;
      }

      controller.updateIsLoadingclass(false);
      controller.updateIsErrorOcuuredWhileLoadingclass(false);
    } on Exception catch (e) {
      logger.e(e.toString());
      controller.updateIsErrorOcuuredWhileLoadingclass(true);
      controller.updateIsLoadingclass(false);
    }
  }
}
