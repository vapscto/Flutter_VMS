import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:m_skool_flutter/vms/security/model/model.dart';
import 'package:m_skool_flutter/vms/utils/save_image.dart';

class SecurtyWorkController extends GetxController {
  RxBool isLoading = RxBool(false);
  RxBool isError = RxBool(false);
  RxString uploadImagePath = ''.obs;
  void updateLoading(bool val) {
    isLoading.value = val;
  }

  void updateIamgePath(String val) {
    uploadImagePath.value = val;
  }

  void updateError(bool val) {
    isError.value = val;
  }

  RxList<qRcodeActivityDetailsValues> securtyWorkList =
      <qRcodeActivityDetailsValues>[].obs;
  RxList<bool> checkBox = <bool>[].obs;
  RxList<String> securityUploadImage = <String>[].obs;

  Future<bool> getFromCamera({required int miId, required String base}) async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      String? imageUrl =
          await securUpload(image: pickedFile.path, miId: miId, base: base)
              .then(
        (value) {
          updateIamgePath(value!);
        },
      );
      securityUploadImage.add(pickedFile.name);
      return true;
    }
    return false;
  }
}
