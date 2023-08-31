import 'package:get/get.dart';
import 'package:m_skool_flutter/student/gallery_view/model/galleryView.dart';
 

class ViewGalleryController extends GetxController {
  RxList<Values> viewImagesList = RxList();

  addImages(List<Values> values) {
    viewImagesList.addAll(values);
  }
}
