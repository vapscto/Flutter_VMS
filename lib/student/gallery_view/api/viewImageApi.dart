import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/student/gallery_view/controller/viewGallery_controller.dart';
import 'package:m_skool_flutter/student/gallery_view/model/galleryView.dart';
 
class GetFeatchApiImages {
  GetFeatchApiImages.init();
  static final GetFeatchApiImages instance = GetFeatchApiImages.init();
  featchApiImages(
      {required ViewGalleryController ctr,
      required String base,
      required String miId,
      required String amstId,
      required String asmayId,
      required String userId,
      required String roleId}) async {
    List<GalleryViewModel> images = [];
    Map<String, dynamic> map = {
      "MI_Id": miId,
      "AMST_Id": amstId,
      "ASMAY_Id": asmayId,
      "UserId": userId,
      "roleid": roleId,
      "Feecheck": 1,
      "stdupdate": 1,
      "OnClickOrOnChange": "OnChange",
      "flag": "GALLERY"
    };

    String api = base + URLS.viewGallery;
    logger.d(api);

    var dio = Dio();
    final Dio ins = getGlobalDio();
    logger.d({
      "MI_Id": miId,
      "AMST_Id": amstId,
      "ASMAY_Id": asmayId,
      "UserId": userId,
      "roleid": roleId,
      "Feecheck": 1,
      "stdupdate": 1,
      "OnClickOrOnChange": "OnClick",
      "flag": "GALLERY"
    });

    try {
      final Response response =
          await ins.post(api, options: Options(headers: getSession()), data: map
              // data: {
              //   "MI_Id": 4,
              //   "AMST_Id": 150168895,
              //   "ASMAY_Id": 11178,
              //   "UserId": 75600,
              //   "roleid": 7,
              //   "Feecheck": 1,
              //   "stdupdate": 1,
              //   "OnClickOrOnChange": "OnClick",
              //   "flag": "GALLERY"
              // }
              );
      logger.d("000${map}");
      logger.d(response.data['imagegallery']);
      Imagegallery imageList =
          Imagegallery.fromJson(response.data['imagegallery']);

      ctr.viewImagesList(imageList.values);
    } on DioError catch (e) {
      return Future.error({
        "errorTitle": "Unexpected Error Occured",
        "errorMsg": e.message,
      });
    } on Exception catch (e) {
      logger.e(e.toString());
      return Future.error({
        "errorTitle": "Unexpected Error Occured",
        "errorMsg": "An internal error Occured while loading attachment's"
      });
    }
  }
}
