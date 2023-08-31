import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/staffs/gallery_upload/controller/academicYear_controller.dart';
import 'package:m_skool_flutter/staffs/gallery_upload/model/AcademicYearList.dart';
 
class GetAcademicYearDataApi {
  GetAcademicYearDataApi.init();

  static final GetAcademicYearDataApi instance = GetAcademicYearDataApi.init();

  getExamSelectedYear(
      {required int miId,
      required String base,
      required AcadmeicController controller}) async {
    final Dio ins = getGlobalDio();
    final String api = base + URLS.galleryAcademicYearData;
    logger.d(api);
    logger.d({
      "MI_ID": miId,
    });

    if (controller.isErrorOccuredWhileLoadingAcademic.value) {
      controller.updateIsErrorOccuredWhileLoadingAcademic(false);
    }
    controller.updateIsLoadingAcademicYear(true);
    try {
      final Response response =
          await ins.post(api, options: Options(headers: getSession()), data: {
        "MI_Id": miId,
      });
      logger.d(response.data["yearlist"]);
      if (response.data["yearlist"] == null) {
        controller.updateIsErrorOccuredWhileLoadingAcademic(true);
        controller.updateIsLoadingAcademicYear(false);
        return;
      }
      final AcademicYearList selectedAcademic =
          AcademicYearList.fromJson(response.data['yearlist']);
      logger.d(selectedAcademic.values!);
      if (selectedAcademic.values!.isNotEmpty) {
        controller.selectedAcademic = selectedAcademic.values!.first;
      }

      controller.updateAcademic(selectedAcademic.values!);
      controller.updateIsErrorOccuredWhileLoadingAcademic(false);
      controller.updateIsLoadingAcademicYear(false);
    } on Exception catch (e) {
      logger.e(e.toString());
      controller.updateIsErrorOccuredWhileLoadingAcademic(true);
      controller.updateIsLoadingAcademicYear(false);
    }
  }
}
