import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/staffs/gallery_upload/controller/gallery_controller.dart';
import 'package:m_skool_flutter/staffs/gallery_upload/model/gallery_classList_model.dart';
 

// import 'package:m_skool_flutter/manager/gallery/controller/staff_gallery_controller.dart';

class GetGalleryInitialDataApi {
  GetGalleryInitialDataApi.init();

  static final GetGalleryInitialDataApi instance =
      GetGalleryInitialDataApi.init();

  Future<void> getGalleryClass(
      {required int miId,
      required int userId,
      required int asmaYId,
      required int ivrmrtId,
      required int amstId,
      required String roleFlag,
      required StaffGalleryController galleryController,
      required String base}) async {
    final Dio ins = getGlobalDio();
    final String apiUrl = base + URLS.staffGalleryClassApi;

    logger.d(apiUrl);

    logger.d({
      "MI_Id": miId,
      "UserId": userId,
      "ASMAY_Id": asmaYId,
      "IVRMRT_Id": ivrmrtId,
      "Role_flag": roleFlag,
      "amsT_Id ": amstId,
    });

    try {
      final Dio ins = getGlobalDio();
      final String apiUrl = base + URLS.staffGalleryClassApi;
      if (galleryController.isErrorOccuredLoadingClass.value) {
        galleryController.updateIsErrorOccuredLoadingClass(false);
      }
      galleryController.updateLoadingStatus(
          "We are in process to loading class's for selected Academic Year");
      galleryController.updateIsClassLoading(true);

      final Response response = await ins
          .post(apiUrl, options: Options(headers: getSession()), data: {
        "MI_Id": miId,
        "UserId": userId,
        "ASMAY_Id": asmaYId,
        "IVRMRT_Id": ivrmrtId,
        "Role_flag": roleFlag,
        "amsT_Id ": amstId,
      });
      logger.d({
        "MI_Id": miId,
        "UserId": userId,
        "ASMAY_Id": asmaYId,
        "IVRMRT_Id": ivrmrtId,
        "Role_flag": roleFlag,
        "amsT_Id ": amstId,
      });
      logger.d(response.data['classlist']);
      if (response.data['classlist'] == null) {
        galleryController.updateIsClassLoading(false);
        galleryController.updateErrorStatus(
            "No Classes are present in record, Please contact your technical team for assistance");
        galleryController.updateIsErrorOccuredLoadingClass(true);

        return;
      }
      final StaffGalleryClassListModel classes =
          StaffGalleryClassListModel.fromJson(response.data['classlist']);
      if (classes.values!.isNotEmpty) {
        galleryController.updateSelectedClass(classes.values!.first);
      }
      galleryController.updateClasses(classes.values!);
      galleryController.updateIsClassLoading(false);
    } on DioError catch (e) {
      galleryController.updateIsClassLoading(false);
      galleryController.updateErrorStatus(e.message);
      galleryController.updateIsErrorOccuredLoadingClass(true);
      logger.e(e.message);
      return;
    } on Exception catch (e) {
      logger.e(e.toString());
      galleryController.updateIsClassLoading(false);
      galleryController.updateErrorStatus(
          "An Internal error Occured, while trying to create a view for you. you can try again later");
      return;
    }
  }
}
