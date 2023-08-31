import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/staffs/gallery_upload/controller/gallery_controller.dart';
import 'package:m_skool_flutter/staffs/gallery_upload/model/gallery_Section_Model.dart';
 
class GetGallerySectionApi {
  GetGallerySectionApi.init();

  static final GetGallerySectionApi instance = GetGallerySectionApi.init();

  Future<void> getGallerySection({
    required int miId,
    required int userId,
    required int asmaYId,
    required int ivrmrtId,
    required int amstId,
    required String roleFlag,
    required int asmcLId,
    required bool fromVerifyCat,
    required StaffGalleryController galleryController,
    required String base,
  }) async {
    final Dio ins = getGlobalDio();
    final String api = base + URLS.staffGallerySectionApi;
    logger.d(api);

    logger.d({
      "MI_Id": miId,
      "UserId": userId,
      "ASMAY_Id": asmaYId,
      "IVRMRT_Id": ivrmrtId,
      "Role_flag": roleFlag,
      "amsT_Id ": amstId,
      "IGA_CommonGalleryFlg": false,
      "ASMCL_Id": asmcLId
    });

    if (galleryController.isErrorOccuredLoadingSection.value) {
      galleryController.updateIsErrorOccuredLoadingSection(true);
    }
    galleryController.updateLoadingStatus(
        "We are in process to loading section's for selected Academic Year, and class");
    galleryController.updateIsSectionLoading(true);

    try {
      final Response response = await ins.post(
        api,
        options: Options(headers: getSession()),
        data: {
          "MI_Id": miId,
          "UserId": userId,
          "ASMAY_Id": asmaYId,
          "IVRMRT_Id": ivrmrtId,
          "Role_flag": roleFlag,
          "amsT_Id ": amstId,
          "IGA_CommonGalleryFlg": false,
          "ASMCL_Id": asmcLId
        },
      );

      if (response.data['sectionlist'] == null) {
        galleryController.updateIsSectionLoading(false);
        galleryController.updateErrorStatus(
            "No Section were found for selected Classes, Try with another class or contact your technical team for assistance");
        galleryController.updateIsErrorOccuredLoadingSection(true);

        return;
      }
      final GallerySectionModel sectionListModel =
          GallerySectionModel.fromJson(response.data['sectionlist']);
      //logger.d("message 420");
      if (fromVerifyCat == true) {
        logger.d("message");
        logger.d(sectionListModel.values!.first.toJson());
        galleryController
            .updateVerifySelectedSection(sectionListModel.values!.first);
      } else {
        if (galleryController.selectedSection.isNotEmpty) {
          galleryController.selectedSection.clear();
        }
        if (sectionListModel.values!.isNotEmpty) {
          galleryController
              .updateSelectedSection(sectionListModel.values!.first);
        }
      }

      galleryController.updateSections(sectionListModel.values!);
      galleryController.updateIsSectionLoading(false);
    } on DioError catch (e) {
      galleryController.updateIsSectionLoading(false);
      galleryController.updateErrorStatus(e.message);
      logger.e(e.message);
      return;
    } on Exception catch (e) {
      logger.e(e.toString());
      galleryController.updateIsSectionLoading(false);
      galleryController.updateErrorStatus(
          "An Internal error Occured, while trying to create a view for you. you can try again later");
      return;
    }
  }
}
